# TAO Device Controller - Complete IoT Management System

A comprehensive IoT device control application combining Flutter mobile app, Node.js backend server, Arduino hardware control, and Firebase cloud infrastructure. Manage up to 4 connected devices with real-time status monitoring, weather integration, and automated scheduling.

## Features

✅ **Device Management**
- Control 4 devices in real-time
- Physical button control via Arduino
- Visual status indicators
- Connection monitoring
- Manual on/off controls

✅ **Hardware Integration**
- Arduino with 3 physical buttons (GPIO 5, 6, 7)
- 4 relay modules for device control
- Status LED indicator (GPIO 8) with multiple states:
  - Fast blink: Disconnected
  - Slow blink: Connected, idle
  - Solid: At least one device active
  - Pulse: State transition

✅ **Real-Time Weather**
- Live temperature and humidity
- Weather description and conditions
- Wind speed monitoring
- Auto-refresh every 10 minutes
- Location-based data via OpenWeatherMap

✅ **Device Scheduling**
- Create time-based schedules
- Day-of-week selection
- ON/OFF automation
- Enable/disable schedules anytime
- Firebase persistence

✅ **Multi-Platform Support**
- Flutter app for iOS and Android
- WebSocket real-time communication
- REST API for traditional requests
- Responsive UI design

## Project Structure

```
project/
├── backend/                          # Node.js Server
│   ├── server.js                     # Main server entry
│   ├── controllers/
│   │   └── arduinoController.js      # Arduino communication
│   ├── services/
│   │   └── weatherService.js         # Weather API integration
│   ├── package.json
│   └── .env                          # Configuration
│
├── arduino/                          # Arduino Code
│   ├── DeviceController.ino          # Main sketch
│   └── README.md                     # Hardware setup guide
│
├── flutter/                          # Mobile App
│   ├── lib/
│   │   ├── main.dart                 # App entry point
│   │   ├── providers/
│   │   │   ├── device_provider.dart  # Device state management
│   │   │   ├── weather_provider.dart # Weather state
│   │   │   └── schedule_provider.dart # Schedule management
│   │   └── screens/
│   │       ├── home_screen.dart      # Main dashboard
│   │       ├── device_control_page.dart
│   │       ├── weather_page.dart
│   │       ├── schedule_page.dart
│   │       └── widgets/              # Reusable components
│   └── pubspec.yaml
│
├── SETUP_GUIDE.md                    # Detailed setup instructions
└── README.md                         # This file
```

## Quick Start

### 1. Prerequisites
- Node.js 18+ and npm
- Flutter SDK 3.0+
- Arduino IDE
- Firebase account
- OpenWeatherMap API key (free)

### 2. Clone & Setup Backend

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your Firebase and OpenWeather credentials
npm start
```

### 3. Setup Arduino

```
1. Connect Arduino via USB
2. Open Arduino IDE
3. Load arduino/DeviceController.ino
4. Select correct board and COM port
5. Upload sketch
6. Verify via Serial Monitor (115200 baud)
```

### 4. Run Flutter App

```bash
cd flutter
flutter pub get
flutter run
```

## Configuration

### Backend Environment Variables

```env
# Firebase
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your-key-id
FIREBASE_PRIVATE_KEY="your-private-key"
FIREBASE_CLIENT_EMAIL=your-service-account@project.iam.gserviceaccount.com

# Arduino
ARDUINO_PORT=COM3          # or /dev/ttyUSB0 on Linux
ARDUINO_BAUD_RATE=9600

# Weather
OPENWEATHER_API_KEY=your-api-key

# Server
PORT=5000
CORS_ORIGIN=http://localhost:3000
```

### Flutter Configuration

Update backend IP in `lib/providers/device_provider.dart`:

```dart
_socket = IO.io(
  'http://YOUR_BACKEND_IP:5000',  // Change this to your server IP
  IO.SocketIoClientOptions(...)
);
```

## API Reference

### REST Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/devices` | Get all device states |
| GET | `/api/devices/:id` | Get specific device |
| POST | `/api/devices/:id/control` | Toggle device |
| GET | `/api/weather` | Get current weather |
| GET | `/api/schedules` | Get all schedules |
| POST | `/api/schedules` | Create schedule |
| DELETE | `/api/schedules/:id` | Delete schedule |
| GET | `/api/health` | System health |

### WebSocket Events

```javascript
// Device Control
socket.emit('control_device', { deviceId: '1', state: true });

// Device Update
socket.on('device_updated', (data) => {
  console.log(data); // { deviceId, state, timestamp }
});

// Get Schedules
socket.emit('get_schedules');
socket.on('schedules_data', (schedules) => {
  console.log(schedules);
});
```

## Communication Protocol

### Arduino Serial Messages

**Commands to Arduino:**
- `INIT` - Initialize system
- `SET:5:ON` - Set GPIO 5 to ON
- `LED:connected_idle` - Set LED mode
- `STATUS` - Request status

**Arduino Responses:**
- `STATUS:5:ON:6:OFF:7:OFF:4:ON` - All device states
- `BUTTON_PRESSED:5` - Button press event
- `[Arduino] Device 1: ON` - Acknowledgment

## Features in Detail

### Real-Time Device Control
- Instant device state synchronization
- Firebase Realtime Database updates
- WebSocket push notifications
- Manual app controls
- Physical button support

### Weather Widget
- Current temperature display
- Humidity and pressure readings
- Wind speed information
- Weather description and icon
- Auto-refresh capability
- Location-based data

### Scheduling System
- Time-based automation
- Repeat pattern selection
- Enable/disable toggles
- Schedule history
- Firebase persistence

### Connection Monitoring
- Live status indicator
- Connection state display
- Reconnection handling
- System health checks
- LED feedback (hardware)

## Troubleshooting

### App Won't Connect
1. Check backend IP address is correct
2. Verify backend server is running (`npm start`)
3. Ensure port 5000 is accessible
4. Check Firebase credentials
5. Review firewall settings

### Arduino Serial Issues
1. Verify USB cable connection
2. Check COM port in Arduino IDE matches `.env`
3. Confirm baud rate is 9600
4. Look for error messages in Serial Monitor
5. Reload sketch if needed

### Weather Not Updating
1. Verify OpenWeatherMap API key
2. Check internet connectivity
3. Review API rate limits
4. Ensure Firebase write permissions
5. Check backend logs

### Devices Not Syncing
1. Test WebSocket connection
2. Verify Firebase Realtime Database
3. Check backend logs
4. Ensure app has internet access
5. Try restarting backend

## Security Considerations

⚠️ **Before Production:**
- Use HTTPS for backend communication
- Implement Firebase authentication
- Enable Row-Level Security (RLS)
- Use environment variables for secrets
- Implement rate limiting
- Add input validation
- Use secure token management

## Performance Tips

- WebSocket reduces latency vs HTTP polling
- Firebase caching for offline support
- Debounced button inputs prevent spam
- Weather updates every 10 minutes
- Efficient UI re-renders in Flutter

## Future Enhancements

- Voice control integration
- Mobile app notifications
- Advanced scheduling (cron-like)
- Device automation rules
- Remote access via VPN
- Multi-user support
- Analytics dashboard
- Backup and restore

## Supported Platforms

- **Mobile**: iOS 12+, Android 8+
- **Backend**: Linux, macOS, Windows
- **Arduino**: Uno, Mega, Nano, ESP32

## Hardware Specifications

| Component | Specification |
|-----------|---------------|
| Microcontroller | Arduino Uno/Mega |
| Buttons | 3x Push buttons (GPIO 5,6,7) |
| Relays | 4x 5V relay modules |
| LED | 1x 5mm LED + 220Ω resistor (GPIO 8) |
| Communication | USB Serial (9600 baud) |

## Technologies Used

**Frontend**
- Flutter 3.0+
- Provider (state management)
- Socket.io (real-time)
- Firebase SDK

**Backend**
- Node.js 18+
- Express.js
- Firebase Admin SDK
- Socket.io

**Hardware**
- Arduino C++
- Serial communication

**Cloud**
- Firebase Realtime Database
- OpenWeatherMap API

## Getting Help

1. Check SETUP_GUIDE.md for detailed setup
2. Review troubleshooting section
3. Check Arduino serial output for errors
4. Review backend console logs
5. Verify all configuration files

## License

Open Source - Modify and distribute freely

## Support

For issues, questions, or contributions, please refer to the detailed setup guide and troubleshooting documentation included in the project.

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Status**: Production Ready
