const { SerialPort } = require('serialport');
const { ReadlineParser } = require('@serialport/parser-readline');

class ArduinoController {
  constructor(io, db) {
    this.io = io;
    this.db = db;
    this.port = null;
    this.parser = null;
    this.connected = false;
    this.devices = {
      '1': { name: 'Device 1', pin: 5, state: false },
      '2': { name: 'Device 2', pin: 6, state: false },
      '3': { name: 'Device 3', pin: 7, state: false },
      '4': { name: 'Device 4', pin: 8, state: false }
    };
    this.ledState = 'disconnected'; // disconnected, connected_idle, active
  }

  connect() {
    const portName = process.env.ARDUINO_PORT || 'COM3';
    const baudRate = parseInt(process.env.ARDUINO_BAUD_RATE || '9600');

    try {
      this.port = new SerialPort({
        path: portName,
        baudRate: baudRate,
        autoOpen: false
      });

      this.parser = this.port.pipe(new ReadlineParser({ delimiter: '\n' }));

      this.port.open((err) => {
        if (err) {
          console.error('[Arduino] Port open error:', err.message);
          this.connected = false;
          this.retryConnection();
        } else {
          console.log('[Arduino] Port opened successfully');
          this.connected = true;
          this.initializeDevices();
        }
      });

      this.parser.on('data', (data) => {
        this.handleArduinoData(data);
      });

      this.port.on('error', (err) => {
        console.error('[Arduino] Serial port error:', err.message);
        this.connected = false;
        this.retryConnection();
      });

      this.port.on('close', () => {
        console.log('[Arduino] Port closed');
        this.connected = false;
      });
    } catch (error) {
      console.error('[Arduino] Connection error:', error.message);
      this.retryConnection();
    }
  }

  disconnect() {
    if (this.port && this.port.isOpen) {
      this.port.close(() => {
        console.log('[Arduino] Port closed');
        this.connected = false;
      });
    }
  }

  retryConnection() {
    console.log('[Arduino] Retrying connection in 5 seconds...');
    setTimeout(() => {
      this.connect();
    }, 5000);
  }

  initializeDevices() {
    // Initialize device states in Firebase
    Object.keys(this.devices).forEach((key) => {
      this.db.ref(`devices/${key}`).set({
        id: key,
        name: this.devices[key].name,
        pin: this.devices[key].pin,
        state: this.devices[key].state,
        lastUpdated: new Date().toISOString()
      });
    });

    // Send initialization command to Arduino
    this.sendCommand('INIT');
  }

  controlDevice(deviceId, state) {
    if (!this.connected) {
      console.error('[Arduino] Not connected to device');
      return false;
    }

    const device = this.devices[deviceId];
    if (!device) {
      console.error(`[Arduino] Device ${deviceId} not found`);
      return false;
    }

    const command = `SET:${device.pin}:${state ? 'ON' : 'OFF'}`;
    this.sendCommand(command);

    // Update state in Firebase
    this.db.ref(`devices/${deviceId}`).update({
      state: state,
      lastUpdated: new Date().toISOString()
    });

    // Update local state
    this.devices[deviceId].state = state;

    // Trigger LED state change
    this.updateLedState();

    // Broadcast to all connected clients
    this.io.emit('device_updated', {
      deviceId,
      state,
      timestamp: new Date().toISOString()
    });

    return true;
  }

  sendCommand(command) {
    if (this.port && this.port.isOpen) {
      this.port.write(command + '\n', (err) => {
        if (err) {
          console.error('[Arduino] Write error:', err.message);
        } else {
          console.log(`[Arduino] Sent command: ${command}`);
        }
      });
    }
  }

  handleArduinoData(data) {
    console.log('[Arduino] Received:', data);

    // Parse Arduino responses
    if (data.includes('BUTTON_PRESSED')) {
      const parts = data.split(':');
      const pin = parts[1];
      this.handleButtonPress(pin);
    } else if (data.includes('STATUS')) {
      const parts = data.split(':');
      const pin = parts[1];
      const state = parts[2] === 'ON';
      this.updateDeviceStatus(pin, state);
    }
  }

  handleButtonPress(pin) {
    // Find device by pin
    const deviceId = Object.keys(this.devices).find(
      key => this.devices[key].pin == pin
    );

    if (deviceId) {
      const currentState = this.devices[deviceId].state;
      this.controlDevice(deviceId, !currentState);
      console.log(`[Arduino] Button pressed on pin ${pin}, toggling device ${deviceId}`);
    }
  }

  updateDeviceStatus(pin, state) {
    const deviceId = Object.keys(this.devices).find(
      key => this.devices[key].pin == pin
    );

    if (deviceId) {
      this.devices[deviceId].state = state;
      this.db.ref(`devices/${deviceId}`).update({
        state: state,
        lastUpdated: new Date().toISOString()
      });
    }
  }

  updateLedState() {
    // Determine LED state based on device states
    const anyDeviceActive = Object.values(this.devices).some(d => d.state);
    this.ledState = this.connected ? (anyDeviceActive ? 'active' : 'connected_idle') : 'disconnected';
    
    // Send LED state to Arduino
    const ledCommand = `LED:${this.ledState}`;
    this.sendCommand(ledCommand);
  }

  isConnected() {
    return this.connected;
  }

  getDevices() {
    return this.devices;
  }
}

module.exports = ArduinoController;
