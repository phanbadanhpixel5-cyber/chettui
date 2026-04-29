import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Device {
  final String id;
  final String name;
  final int pin;
  bool state;
  final String type;
  DateTime lastUpdated;

  Device({
    required this.id,
    required this.name,
    required this.pin,
    required this.state,
    required this.type,
    required this.lastUpdated,
  });

  factory Device.fromJson(Map<dynamic, dynamic> json) {
    return Device(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Device',
      pin: json['pin'] ?? 0,
      state: json['state'] ?? false,
      type: json['type'] ?? 'relay',
      lastUpdated: DateTime.parse(
        json['lastUpdated'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pin': pin,
      'state': state,
      'type': type,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class DeviceProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late IO.Socket _socket;
  
  Map<String, Device> _devices = {};
  bool _isConnected = false;
  String _connectionStatus = 'Disconnected';

  Map<String, Device> get devices => _devices;
  bool get isConnected => _isConnected;
  String get connectionStatus => _connectionStatus;

  DeviceProvider() {
    _initializeConnection();
  }

  Future<void> _initializeConnection() async {
    try {
      // Connect to backend server
      _socket = IO.io(
        'http://your-backend-ip:5000',
        IO.SocketIoClientOptions(
          reconnection: true,
          reconnectionDelay: const Duration(seconds: 1),
          reconnectionDelayMax: const Duration(seconds: 5),
          reconnectionAttempts: 20,
          transports: ['websocket'],
        ),
      );

      _socket.on('connect', (_) {
        _isConnected = true;
        _connectionStatus = 'Connected';
        notifyListeners();
        _loadDevices();
      });

      _socket.on('disconnect', (_) {
        _isConnected = false;
        _connectionStatus = 'Disconnected';
        notifyListeners();
      });

      _socket.on('device_updated', (data) {
        if (_devices.containsKey(data['deviceId'])) {
          _devices[data['deviceId']]!.state = data['state'];
          _devices[data['deviceId']]!.lastUpdated = DateTime.now();
          notifyListeners();
        }
      });

      _socket.connect();

      // Listen to Firebase Realtime Database
      _database.ref('devices').onValue.listen((event) {
        if (event.snapshot.exists) {
          _devices.clear();
          for (var child in event.snapshot.children) {
            final device = Device.fromJson(
              Map<String, dynamic>.from(
                child.value as Map,
              ),
            );
            _devices[device.id] = device;
          }
          notifyListeners();
        }
      });
    } catch (e) {
      if (kDebugMode) print('Connection error: $e');
      _connectionStatus = 'Error: $e';
      notifyListeners();
    }
  }

  Future<void> _loadDevices() async {
    try {
      final snapshot = await _database.ref('devices').get();
      if (snapshot.exists) {
        _devices.clear();
        for (var child in snapshot.children) {
          final device = Device.fromJson(
            Map<String, dynamic>.from(child.value as Map),
          );
          _devices[device.id] = device;
        }
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print('Load devices error: $e');
    }
  }

  Future<void> toggleDevice(String deviceId) async {
    try {
      if (_devices.containsKey(deviceId)) {
        final device = _devices[deviceId]!;
        device.state = !device.state;
        device.lastUpdated = DateTime.now();
        
        // Update Firebase
        await _database.ref('devices/$deviceId/state').set(device.state);
        
        // Send command via WebSocket
        _socket.emit('control_device', {
          'deviceId': deviceId,
          'state': device.state,
        });
        
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print('Toggle device error: $e');
    }
  }

  Future<void> setDeviceState(String deviceId, bool state) async {
    try {
      if (_devices.containsKey(deviceId)) {
        _devices[deviceId]!.state = state;
        _devices[deviceId]!.lastUpdated = DateTime.now();
        
        await _database.ref('devices/$deviceId/state').set(state);
        _socket.emit('control_device', {
          'deviceId': deviceId,
          'state': state,
        });
        
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print('Set device state error: $e');
    }
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }
}
