# TAO Device Controller - Deployment Checklist

## Pre-Deployment Verification

### Hardware Setup ✓
- [ ] Arduino board connected and recognized by computer
- [ ] 3 push buttons wired to GPIO 5, 6, 7
- [ ] Status LED wired to GPIO 8 with 220Ω resistor
- [ ] 4 relay modules connected
- [ ] All connections double-checked for correctness
- [ ] USB cable properly connected

### Backend Server ✓
- [ ] Node.js 18+ installed
- [ ] All dependencies installed (`npm install`)
- [ ] Firebase project created
- [ ] Service account key generated
- [ ] `.env` file configured with all required variables
- [ ] OpenWeatherMap API key obtained
- [ ] Backend starts without errors (`npm start`)
- [ ] Server responds on port 5000

### Arduino Configuration ✓
- [ ] DeviceController.ino uploaded successfully
- [ ] Serial Monitor shows `[Arduino] System initialized`
- [ ] Pin configuration verified
- [ ] Button functionality tested
- [ ] LED status changes working

### Flutter App ✓
- [ ] Flutter SDK installed and updated
- [ ] Firebase configuration added (google-services.json for Android, GoogleService-Info.plist for iOS)
- [ ] Backend IP address updated in device_provider.dart
- [ ] Dependencies installed (`flutter pub get`)
- [ ] App builds without errors
- [ ] App runs on emulator/device

### Firebase Setup ✓
- [ ] Realtime Database created
- [ ] Database structure initialized with devices, schedules, weather collections
- [ ] Security rules configured
- [ ] Service account has write permissions
- [ ] Test write operations successful

## Pre-Launch Testing

### Backend Tests
```bash
# Health check
curl http://localhost:5000/api/health

# Test device endpoint
curl http://localhost:5000/api/devices

# Check weather endpoint
curl http://localhost:5000/api/weather
```

### Arduino Tests
1. Upload sketch to Arduino
2. Open Serial Monitor (115200 baud)
3. Press each button - should see `BUTTON_PRESSED:X` in output
4. Watch LED status changes
5. Power on relay modules and test switches

### App Tests
1. Install app on device/emulator
2. Verify connection to backend
3. Check device list loads
4. Test device toggle
5. Verify weather displays
6. Create and test schedule

### Integration Tests
1. Physical button press → App updates
2. App toggle → Arduino relay responds
3. Weather auto-refreshes
4. Schedule executes at set time
5. LED status reflects connection

## Performance Checks

- [ ] Device response time < 2 seconds
- [ ] Weather updates < 30 seconds
- [ ] No memory leaks after 1 hour use
- [ ] App handles 100 rapid button presses
- [ ] Backend handles concurrent connections
- [ ] Firebase reads/writes successful under load

## Security Verification

- [ ] All API endpoints protected (if applicable)
- [ ] Firebase Realtime Database has security rules
- [ ] No hardcoded credentials in code
- [ ] API keys stored in environment variables
- [ ] HTTPS configured for production
- [ ] Serial communication secure (Arduino)

## Documentation Review

- [ ] README.md complete and accurate
- [ ] SETUP_GUIDE.md covers all steps
- [ ] Arduino pin configuration documented
- [ ] API endpoints documented
- [ ] Environment variables documented
- [ ] Troubleshooting guide complete

## Database Schema Verification

```json
{
  "devices": {
    "1": {
      "id": "1",
      "name": "Device 1",
      "pin": 5,
      "state": false,
      "type": "relay",
      "lastUpdated": "ISO8601"
    }
  },
  "weather": {
    "temperature": 25,
    "humidity": 60,
    "description": "Clear sky",
    "main": "Clear",
    "windSpeed": 5.5,
    "city": "Hanoi",
    "updatedAt": "ISO8601"
  },
  "schedules": {
    "schedule-id": {
      "name": "Morning Device 1",
      "deviceId": "1",
      "action": "ON",
      "time": "08:00",
      "enabled": true,
      "daysOfWeek": [1,2,3,4,5],
      "createdAt": "ISO8601"
    }
  }
}
```

## Deployment Steps

### 1. Backend Deployment

```bash
# On production server
cd backend
npm install
npm start

# Or using PM2 for process management
npm install -g pm2
pm2 start server.js --name "tao-backend"
pm2 save
```

### 2. Arduino Deployment

```
1. Upload DeviceController.ino to production Arduino
2. Connect USB to server machine
3. Verify in backend logs: "Arduino connected"
```

### 3. Flutter Deployment - Android

```bash
cd flutter
flutter build apk --release
# Upload to Google Play or distribute APK
```

### 4. Flutter Deployment - iOS

```bash
cd flutter
flutter build ios --release
# Use Xcode to upload to App Store
```

## Post-Deployment Checklist

- [ ] Backend server running continuously
- [ ] Arduino connected and responding
- [ ] App successfully installed on user devices
- [ ] Users can connect to backend
- [ ] Device control working end-to-end
- [ ] Weather data refreshing automatically
- [ ] Schedules executing on time
- [ ] No critical errors in logs
- [ ] Mobile push notifications working (if enabled)
- [ ] Database backups configured

## Monitoring & Maintenance

### Daily Checks
- [ ] Backend server running
- [ ] Arduino connection active
- [ ] Weather data updating
- [ ] No unusual errors in logs

### Weekly Checks
- [ ] Test all device controls
- [ ] Verify schedule execution
- [ ] Check database growth
- [ ] Review error logs

### Monthly Checks
- [ ] Backup Firebase database
- [ ] Update dependencies
- [ ] Security audit
- [ ] Performance analysis

## Rollback Procedure

If deployment fails:

1. **Backend Issue**
   ```bash
   git revert HEAD
   npm start
   ```

2. **Arduino Issue**
   - Revert to previous .ino file
   - Re-upload to board

3. **App Issue**
   - Release previous APK/IPA
   - Notify users to update

## Support Contacts

- Backend Issues: Check server logs
- Hardware Issues: Verify connections
- App Issues: Check Firebase permissions
- Weather Issues: Verify API key

## Sign-Off

- [ ] Project Manager Review
- [ ] QA Testing Complete
- [ ] Security Review Complete
- [ ] Performance Testing Complete
- [ ] Documentation Complete
- [ ] Ready for Production Release

---

**Deployment Date**: ___________  
**Deployed By**: ___________  
**Verified By**: ___________  
**Notes**: _________________________________
