# Arduino TAO Device Controller Setup Guide

## Hardware Requirements
- Arduino board (Uno, Mega, or compatible)
- 3 Push buttons
- 1 LED with 220Ω resistor
- 4 Relay modules (for controlling devices)
- USB cable for serial communication
- Connecting wires

## Pin Configuration

| Component | Pin | Function |
|-----------|-----|----------|
| Button 1 | GPIO 5 | Control Device 1 |
| Button 2 | GPIO 6 | Control Device 2 |
| Button 3 | GPIO 7 | Control Device 3 |
| Device 4 Relay | GPIO 4 | Control Device 4 |
| Status LED | GPIO 8 | Connection Status |

## LED Status Indicators

- **Fast Blink (200ms)**: Disconnected from backend server
- **Slow Blink (1s)**: Connected to server, no devices active
- **Solid ON**: At least one device is active
- **Pulse**: Transitioning states

## Serial Communication Protocol

### Commands from Backend to Arduino

| Command | Example | Description |
|---------|---------|-------------|
| INIT | `INIT` | Initialize system |
| SET | `SET:5:ON` | Set pin 5 to ON |
| SET | `SET:4:OFF` | Set pin 4 to OFF |
| LED | `LED:connected_idle` | Set LED mode |
| STATUS | `STATUS` | Request device status |
| PING | `PING` | Connection check |

### Responses from Arduino

| Response | Example | Description |
|----------|---------|-------------|
| Status Update | `STATUS:5:ON:6:OFF:7:OFF:4:ON` | All device states |
| Button Press | `BUTTON_PRESSED:5` | Button on pin 5 pressed |
| Acknowledgment | `[Arduino] Device 1: ON` | Command received |

## LED Modes

```
LED:disconnected      - Fast blink (connection lost)
LED:connected_idle    - Slow blink (connected, idle)
LED:active            - Solid on (devices active)
LED:pulse             - Pulse pattern (transitioning)
```

## Installation Steps

1. Connect Arduino to computer via USB
2. Open Arduino IDE
3. Load `DeviceController.ino`
4. Select correct board and COM port
5. Upload sketch
6. Open Serial Monitor (115200 baud) to verify
7. Connect to backend server

## Testing

```
Serial Monitor Output Examples:
[Arduino] System initialized
[Arduino] Initialized - connected to server
[Arduino] Device 1: ON
[Arduino] BUTTON_PRESSED:5
STATUS:5:ON:6:OFF:7:OFF:4:ON
```

## Troubleshooting

- **No serial output**: Check USB connection and COM port selection
- **LED not blinking**: Verify pin 8 connection and LED polarity
- **Buttons not responding**: Check pin connections and Serial Monitor for BUTTON_PRESSED messages
- **Connection timeout**: Ensure backend server is running and sending INIT command
