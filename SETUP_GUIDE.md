# TAO Device Controller - Complete Setup Guide

## System Overview

TAO Device Controller is a comprehensive IoT management system that enables seamless control of 4 connected devices through a modern mobile app, with real-time synchronization, weather integration, and scheduling capabilities.

### Architecture Components

```
┌─────────────────┐
│  Flutter App    │
│  (iOS/Android)  │
└────────┬────────┘
         │ WebSocket/HTTP
         ▼
┌─────────────────────────────────┐
│  Node.js Backend Server         │
│ (Express + Socket.io + Firebase)│
└────────┬──────────────────┬─────┘
         │                  │
         │ Serial/USB       │ Firebase Realtime DB
         ▼                  ▼
    ┌────────────┐    ┌──────────────┐
    │  Arduino   │    │  Weather API │
    │  Device    │    │ (OpenWeather)│
    └────────────┘    └──────────────┘
         │
         ├─ GPIO 5: Button 1 (Device 1)
         ├─ GPIO 6: Button 2 (Device 2)
         ├─ GPIO 7: Button 3 (Device 3)
         ├─ GPIO 4: Relay (Device 4)
         └─ GPIO 8: Status LED
```

## Prerequisites

### Hardware
- Arduino board (Uno, Mega, Nano, or ESP32)
- 3 push buttons
- 1 LED with 220Ω resistor
- 4 relay modules for device control
- Connecting wires and breadboard

### Software
- Flutter SDK (3.0+)
- Node.js (18+) and npm
- Arduino IDE
- Git

### Accounts & APIs
- Firebase project with Realtime Database
- OpenWeatherMap API key (free tier available)
- Backend server hosting (Raspberry Pi, Linux server, or cloud)

## Installation Steps

### 1. Backend Setup

```bash
# Navigate to backend directory
cd backend

# Copy environment template
cp .env.example .env

# Edit .env with your configuration
nano .env

# Install dependencies
npm install

# Start backend server
npm start
```

**Environment Variables:**
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your-key-id
FIREBASE_PRIVATE_KEY="your-private-key"
FIREBASE_CLIENT_EMAIL=your-email@project.iam.gserviceaccount.com
ARDUINO_PORT=COM3  (or /dev/ttyUSB0 on Linux)
OPENWEATHER_API_KEY=your-api-key
PORT=5000
```

### 2. Arduino Setup

1. Connect Arduino to computer via USB
2. Open Arduino IDE
3. Load `/arduino/DeviceController.ino`
4. Install required libraries:
   - None required (uses built-in libraries)
5. Select correct board and COM port
6. Upload sketch
7. Monitor serial output (115200 baud)

### 3. Firebase Configuration

1. Create Firebase project at https://console.firebase.google.com
2. Create Realtime Database
3. Generate service account key:
   - Project Settings → Service Accounts
   - Generate new private key
   - Copy JSON content to backend .env

4. Create database structure:
```json
{
  "devices": {
    "1": {
      "id": "1",
      "name": "Device 1",
      "pin": 5,
      "state": false,
      "type": "relay",
      "lastUpdated": "2024-01-01T00:00:00.000Z"
    },
    "2": {...},
    "3": {...},
    "4": {...}
  },
  "weather": {
    "temperature": 25,
    "humidity": 60,
    "description": "Clear sky",
    ...
  },
  "schedules": {}
}
```

### 4. Flutter App Setup

1. Clone or navigate to Flutter project
2. Update backend IP in device_provider.dart:
   ```dart
   _socket = IO.io(
     'http://YOUR_BACKEND_IP:5000',
     ...
   );
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Add Firebase configuration:
   - For iOS: Add GoogleService-Info.plist
   - For Android: Add google-services.json

5. Run app:
   ```bash
   flutter run
   ```

## System Features

### Device Control
- Real-time on/off control for 4 devices
- Visual status indicators
- Quick toggle buttons
- Last updated timestamp
- Connection status monitoring

### Weather Integration
- Real-time temperature and humidity
- Weather description and icons
- Wind speed and pressure data
- Auto-refresh every 10 minutes
- Location-based data

### Hardware Features

#### Button Control (Arduino)
- Physical buttons on GPIO 5, 6, 7
- Each button toggles its corresponding device
- Debounce protection
- Wireless sync with app

#### LED Status Indicator (GPIO 8)
- **Fast Blink (200ms)**: Disconnected from server
- **Slow Blink (1000ms)**: Connected, no devices active
- **Solid ON**: At least one device active
- **Pulse**: State transition

### Communication Protocol

#### WebSocket Events (Real-time)
```javascript
// Client to Server
socket.emit('control_device', {
  deviceId: '1',
  state: true
});

// Server to Client
socket.on('device_updated', (data) => {
  // data: { deviceId, state, timestamp }
});
```

#### REST API Endpoints
```
GET    /api/devices              - Get all device states
GET    /api/devices/:id          - Get specific device
POST   /api/devices/:id/control  - Control device
GET    /api/weather              - Get current weather
GET    /api/schedules            - Get all schedules
POST   /api/schedules            - Create schedule
DELETE /api/schedules/:id        - Delete schedule
GET    /api/health               - System health check
```

## Serial Communication (Arduino ↔ Backend)

### Commands Format
```
INIT                  - Initialize system
SET:5:ON              - Set GPIO 5 to ON
SET:4:OFF             - Set GPIO 4 to OFF
LED:connected_idle    - Set LED mode
STATUS                - Request device status
PING                  - Connection test
```

### Responses
```
[Arduino] System initialized
STATUS:5:ON:6:OFF:7:OFF:4:ON
BUTTON_PRESSED:5
PONG
```

## Usage Examples

### Turn on Device from App
```dart
// In Flutter
deviceProvider.setDeviceState('1', true);
```

### Physical Button Press
```
Arduino detects button press on GPIO 5
Sends: BUTTON_PRESSED:5
Backend toggles device state
Updates Firebase
WebSocket broadcasts to app
App updates UI
```

### Automatic Weather Update
```
1. Backend fetches weather every 10 minutes
2. Saves to Firebase
3. App receives real-time update
4. UI refreshes automatically
```

## Troubleshooting

### App Won't Connect
- Check backend IP in code matches your server
- Verify backend is running: `npm start`
- Check Firebase credentials
- Ensure firewall allows port 5000

### Arduino Not Responding
- Verify USB connection and COM port
- Check Arduino serial output (115200 baud)
- Ensure GPIO pins are correctly connected
- Reload Arduino sketch

### Weather Data Not Updating
- Verify OpenWeatherMap API key
- Check internet connection
- Review backend logs for API errors
- Ensure Firebase database permissions

### Devices Not Syncing
- Check WebSocket connection (browser console)
- Verify Firebase Realtime Database rules
- Ensure backend can write to Firebase
- Review browser/app network tab

## Security Notes

- Use HTTPS for production backend
- Implement Firebase authentication
- Use environment variables for sensitive data
- Enable Firebase Realtime Database rules
- Change default Arduino serial baud rate if needed
- Implement rate limiting on API endpoints

## Performance Optimization

- WebSocket for real-time updates (lower latency)
- Firebase caching for offline support
- Debounced button inputs
- Efficient re-renders in Flutter UI
- Weather update interval: 10 minutes

## File Structure

```
project/
├── backend/
│   ├── server.js
│   ├── controllers/
│   │   └── arduinoController.js
│   ├── services/
│   │   └── weatherService.js
│   ├── package.json
│   └── .env
├── arduino/
│   ├── DeviceController.ino
│   └── README.md
├── flutter/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── providers/
│   │   │   ├── device_provider.dart
│   │   │   └── weather_provider.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       ├── device_control_page.dart
│   │       └── widgets/
│   │           ├── device_card.dart
│   │           ├── weather_widget.dart
│   │           └── connection_status.dart
│   └── pubspec.yaml
└── README.md
```

## Deployment

### Backend Deployment Options
- **Raspberry Pi**: Run Node.js directly
- **Linux Server**: Use PM2 for process management
- **Docker**: Containerize backend for easy deployment
- **Cloud**: Deploy on Heroku, AWS, or DigitalOcean

### Flutter App Deployment
- **iOS**: Build and upload to App Store
- **Android**: Build APK and upload to Google Play
- **Both**: Use Firebase App Distribution for testing

## Support & Contributing

For issues or feature requests, check the project documentation and troubleshooting guide first.

## License

Open Source - Feel free to modify and distribute.
