/*
  TAO Device Controller - Arduino Code
  Controls 4 devices via 3 buttons (GPIO 5,6,7) and 1 LED status indicator (GPIO 8)
  
  Pins:
  - Button 1: GPIO 5 (Device 1)
  - Button 2: GPIO 6 (Device 2)
  - Button 3: GPIO 7 (Device 3)
  - Device 4: GPIO 4 (controlled via serial)
  - Status LED: GPIO 8
  
  LED Status:
  - Fast blink: Disconnected from server
  - Slow blink: Connected but no device active
  - Solid ON: At least one device active
*/

#define BUTTON1_PIN 5
#define BUTTON2_PIN 6
#define BUTTON3_PIN 7
#define DEVICE4_PIN 4
#define STATUS_LED_PIN 8

// Device states
volatile boolean device1State = false;
volatile boolean device2State = false;
volatile boolean device3State = false;
volatile boolean device4State = false;

// LED states
enum LedMode {
  FAST_BLINK,      // Disconnected
  SLOW_BLINK,      // Connected, idle
  SOLID_ON,        // Active
  PULSE            // Custom pattern
};

LedMode currentLedMode = FAST_BLINK;
unsigned long lastBlinkTime = 0;
unsigned long lastStateUpdate = 0;
const unsigned long STATE_UPDATE_INTERVAL = 5000; // Send state every 5 seconds

// Blink intervals (ms)
const unsigned long FAST_BLINK_INTERVAL = 200;
const unsigned long SLOW_BLINK_INTERVAL = 1000;
const unsigned long PULSE_INTERVAL = 500;

boolean isConnected = false;
unsigned long lastCommunication = 0;
const unsigned long COMMS_TIMEOUT = 30000; // 30 seconds timeout

void setup() {
  Serial.begin(9600);
  
  // Configure pins
  pinMode(BUTTON1_PIN, INPUT_PULLUP);
  pinMode(BUTTON2_PIN, INPUT_PULLUP);
  pinMode(BUTTON3_PIN, INPUT_PULLUP);
  pinMode(DEVICE4_PIN, OUTPUT);
  pinMode(STATUS_LED_PIN, OUTPUT);
  
  // Initialize devices to OFF
  digitalWrite(DEVICE4_PIN, LOW);
  digitalWrite(STATUS_LED_PIN, LOW);
  
  // Attach interrupts for buttons
  attachInterrupt(digitalPinToInterrupt(BUTTON1_PIN), handleButton1, FALLING);
  attachInterrupt(digitalPinToInterrupt(BUTTON2_PIN), handleButton2, FALLING);
  attachInterrupt(digitalPinToInterrupt(BUTTON3_PIN), handleButton3, FALLING);
  
  Serial.println("[Arduino] System initialized");
  delay(500);
}

void loop() {
  // Handle serial communication
  handleSerialCommands();
  
  // Update LED status
  updateLedStatus();
  
  // Send periodic state updates
  unsigned long currentTime = millis();
  if (currentTime - lastStateUpdate >= STATE_UPDATE_INTERVAL) {
    sendStateUpdate();
    lastStateUpdate = currentTime;
  }
  
  // Check connection timeout
  if (isConnected && (currentTime - lastCommunication > COMMS_TIMEOUT)) {
    isConnected = false;
    currentLedMode = FAST_BLINK;
    Serial.println("[Arduino] Connection timeout - server disconnected");
  }
}

void handleSerialCommands() {
  if (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    command.trim();
    
    lastCommunication = millis();
    
    if (command == "INIT") {
      // Initialization command from server
      isConnected = true;
      currentLedMode = SLOW_BLINK;
      Serial.println("[Arduino] Initialized - connected to server");
      sendStateUpdate();
    }
    else if (command.startsWith("SET:")) {
      // Format: SET:PIN:ON/OFF
      // Example: SET:5:ON (set pin 5 to ON)
      handleSetCommand(command);
    }
    else if (command.startsWith("LED:")) {
      // Format: LED:disconnected/connected_idle/active
      handleLedCommand(command);
    }
    else if (command == "STATUS") {
      // Request current status
      sendStateUpdate();
    }
    else if (command == "PING") {
      Serial.println("PONG");
    }
  }
}

void handleSetCommand(String command) {
  // Parse: SET:PIN:ON/OFF
  int colonPos1 = command.indexOf(':');
  int colonPos2 = command.lastIndexOf(':');
  
  int pin = command.substring(colonPos1 + 1, colonPos2).toInt();
  String stateStr = command.substring(colonPos2 + 1);
  boolean state = (stateStr == "ON");
  
  // Update device state and GPIO
  switch(pin) {
    case 5: // Device 1
      device1State = state;
      Serial.println("[Arduino] Device 1: " + String(state ? "ON" : "OFF"));
      break;
    case 6: // Device 2
      device2State = state;
      Serial.println("[Arduino] Device 2: " + String(state ? "ON" : "OFF"));
      break;
    case 7: // Device 3
      device3State = state;
      Serial.println("[Arduino] Device 3: " + String(state ? "ON" : "OFF"));
      break;
    case 4: // Device 4
      device4State = state;
      digitalWrite(DEVICE4_PIN, state ? HIGH : LOW);
      Serial.println("[Arduino] Device 4: " + String(state ? "ON" : "OFF"));
      break;
  }
  
  // Trigger LED pattern change
  updateLedPattern();
}

void handleLedCommand(String command) {
  // Format: LED:disconnected/connected_idle/active
  String mode = command.substring(command.indexOf(':') + 1);
  
  if (mode == "disconnected") {
    currentLedMode = FAST_BLINK;
    isConnected = false;
  }
  else if (mode == "connected_idle") {
    currentLedMode = SLOW_BLINK;
    isConnected = true;
  }
  else if (mode == "active") {
    currentLedMode = SOLID_ON;
    isConnected = true;
  }
  else if (mode == "pulse") {
    currentLedMode = PULSE;
    isConnected = true;
  }
}

void updateLedStatus() {
  unsigned long currentTime = millis();
  
  switch(currentLedMode) {
    case FAST_BLINK:
      if (currentTime - lastBlinkTime >= FAST_BLINK_INTERVAL) {
        digitalWrite(STATUS_LED_PIN, !digitalRead(STATUS_LED_PIN));
        lastBlinkTime = currentTime;
      }
      break;
      
    case SLOW_BLINK:
      if (currentTime - lastBlinkTime >= SLOW_BLINK_INTERVAL) {
        digitalWrite(STATUS_LED_PIN, !digitalRead(STATUS_LED_PIN));
        lastBlinkTime = currentTime;
      }
      break;
      
    case SOLID_ON:
      digitalWrite(STATUS_LED_PIN, HIGH);
      break;
      
    case PULSE:
      // Pulse effect: increase brightness, then decrease
      int brightness = (int)(127 * (1 + sin((currentTime % 1000) / 1000.0 * 2 * PI)));
      analogWrite(STATUS_LED_PIN, brightness);
      break;
  }
}

void updateLedPattern() {
  // Change LED blink pattern when button is pressed
  if (currentLedMode == SLOW_BLINK) {
    currentLedMode = PULSE;
  } else if (currentLedMode == PULSE) {
    currentLedMode = SLOW_BLINK;
  }
}

void sendStateUpdate() {
  String status = "[Arduino] STATUS:";
  status += "5:" + String(device1State ? "ON" : "OFF") + ":";
  status += "6:" + String(device2State ? "ON" : "OFF") + ":";
  status += "7:" + String(device3State ? "ON" : "OFF") + ":";
  status += "4:" + String(device4State ? "ON" : "OFF");
  
  Serial.println(status);
}

// Button interrupt handlers
void handleButton1() {
  delay(20); // Debounce
  if (digitalRead(BUTTON1_PIN) == LOW) {
    device1State = !device1State;
    Serial.println("[Arduino] BUTTON_PRESSED:5");
    updateLedPattern();
    sendStateUpdate();
  }
}

void handleButton2() {
  delay(20); // Debounce
  if (digitalRead(BUTTON2_PIN) == LOW) {
    device2State = !device2State;
    Serial.println("[Arduino] BUTTON_PRESSED:6");
    updateLedPattern();
    sendStateUpdate();
  }
}

void handleButton3() {
  delay(20); // Debounce
  if (digitalRead(BUTTON3_PIN) == LOW) {
    device3State = !device3State;
    Serial.println("[Arduino] BUTTON_PRESSED:7");
    updateLedPattern();
    sendStateUpdate();
  }
}
