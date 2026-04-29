const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const admin = require('firebase-admin');
const { Server } = require('socket.io');
const http = require('http');
const ArduinoController = require('./controllers/arduinoController');
const WeatherService = require('./services/weatherService');

dotenv.config();

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
    methods: ['GET', 'POST']
  }
});

// Middleware
app.use(cors());
app.use(express.json());

// Initialize Firebase
const serviceAccount = {
  projectId: process.env.FIREBASE_PROJECT_ID,
  privateKeyId: process.env.FIREBASE_PRIVATE_KEY_ID,
  privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
  clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
  clientId: process.env.FIREBASE_CLIENT_ID,
  authUri: process.env.FIREBASE_AUTH_URI,
  tokenUri: process.env.FIREBASE_TOKEN_URI,
};

try {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: `https://${process.env.FIREBASE_PROJECT_ID}.firebaseio.com`
  });
} catch (error) {
  console.error('[Backend] Firebase initialization error:', error);
}

const db = admin.database();
const realtimeDb = admin.database();

// Initialize services
const arduinoController = new ArduinoController(io, db);
const weatherService = new WeatherService(db);

// WebSocket connections
io.on('connection', (socket) => {
  console.log('[WebSocket] New client connected:', socket.id);

  // Listen for device control commands
  socket.on('control_device', (data) => {
    console.log('[WebSocket] Device control:', data);
    arduinoController.controlDevice(data.deviceId, data.state);
  });

  // Listen for schedule requests
  socket.on('get_schedules', async () => {
    try {
      const snapshot = await db.ref('schedules').once('value');
      socket.emit('schedules_data', snapshot.val());
    } catch (error) {
      console.error('[WebSocket] Error fetching schedules:', error);
    }
  });

  socket.on('disconnect', () => {
    console.log('[WebSocket] Client disconnected:', socket.id);
  });
});

// REST API Routes

// Get all devices status
app.get('/api/devices', async (req, res) => {
  try {
    const snapshot = await db.ref('devices').once('value');
    res.json(snapshot.val());
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get device by ID
app.get('/api/devices/:id', async (req, res) => {
  try {
    const snapshot = await db.ref(`devices/${req.params.id}`).once('value');
    res.json(snapshot.val());
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Control device
app.post('/api/devices/:id/control', async (req, res) => {
  try {
    const { state } = req.body;
    await arduinoController.controlDevice(req.params.id, state);
    res.json({ success: true, deviceId: req.params.id, state });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get current weather
app.get('/api/weather', async (req, res) => {
  try {
    const snapshot = await db.ref('weather').once('value');
    res.json(snapshot.val());
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all schedules
app.get('/api/schedules', async (req, res) => {
  try {
    const snapshot = await db.ref('schedules').once('value');
    res.json(snapshot.val());
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create/Update schedule
app.post('/api/schedules', async (req, res) => {
  try {
    const { name, deviceId, action, time, enabled } = req.body;
    const scheduleRef = db.ref('schedules').push();
    await scheduleRef.set({
      name,
      deviceId,
      action,
      time,
      enabled,
      createdAt: admin.database.ServerValue.TIMESTAMP
    });
    res.json({ success: true, scheduleId: scheduleRef.key });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete schedule
app.delete('/api/schedules/:id', async (req, res) => {
  try {
    await db.ref(`schedules/${req.params.id}`).remove();
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'ok',
    arduino: arduinoController.isConnected() ? 'connected' : 'disconnected',
    timestamp: new Date().toISOString()
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('[Backend] Error:', err);
  res.status(500).json({ error: 'Internal server error' });
});

// Start server
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
  console.log(`[Backend] Server running on port ${PORT}`);
  console.log('[Backend] Firebase connected');
  
  // Start Arduino connection
  arduinoController.connect();
  
  // Start weather updates
  weatherService.startWeatherUpdates();
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('[Backend] SIGTERM received, shutting down gracefully');
  arduinoController.disconnect();
  server.close(() => {
    console.log('[Backend] Server closed');
    process.exit(0);
  });
});

module.exports = { app, io, db };
