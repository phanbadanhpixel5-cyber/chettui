import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class Schedule {
  final String id;
  final String name;
  final String deviceId;
  final String action; // 'ON' or 'OFF'
  final String time; // Format: HH:mm
  final bool enabled;
  final DateTime createdAt;
  final List<int> daysOfWeek; // 0 = Sunday, 6 = Saturday

  Schedule({
    required this.id,
    required this.name,
    required this.deviceId,
    required this.action,
    required this.time,
    required this.enabled,
    required this.createdAt,
    required this.daysOfWeek,
  });

  factory Schedule.fromJson(String id, Map<dynamic, dynamic> json) {
    return Schedule(
      id: id,
      name: json['name'] ?? 'Unnamed Schedule',
      deviceId: json['deviceId'] ?? '',
      action: json['action'] ?? 'ON',
      time: json['time'] ?? '00:00',
      enabled: json['enabled'] ?? true,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      daysOfWeek: List<int>.from(json['daysOfWeek'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'deviceId': deviceId,
      'action': action,
      'time': time,
      'enabled': enabled,
      'createdAt': createdAt.toIso8601String(),
      'daysOfWeek': daysOfWeek,
    };
  }
}

class ScheduleProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  
  Map<String, Schedule> _schedules = {};
  bool _isLoading = false;
  String _error = '';

  Map<String, Schedule> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String get error => _error;

  ScheduleProvider() {
    _initializeSchedules();
  }

  Future<void> _initializeSchedules() async {
    try {
      _isLoading = true;
      notifyListeners();

      _database.ref('schedules').onValue.listen((event) {
        if (event.snapshot.exists) {
          _schedules.clear();
          for (var child in event.snapshot.children) {
            final schedule = Schedule.fromJson(
              child.key!,
              Map<String, dynamic>.from(child.value as Map),
            );
            _schedules[schedule.id] = schedule;
          }
          _error = '';
        }
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _error = 'Error loading schedules: $e';
      _isLoading = false;
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> createSchedule({
    required String name,
    required String deviceId,
    required String action,
    required String time,
    required List<int> daysOfWeek,
  }) async {
    try {
      final schedule = Schedule(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        deviceId: deviceId,
        action: action,
        time: time,
        enabled: true,
        createdAt: DateTime.now(),
        daysOfWeek: daysOfWeek,
      );

      await _database.ref('schedules/${schedule.id}').set(schedule.toJson());
      _error = '';
      notifyListeners();
    } catch (e) {
      _error = 'Error creating schedule: $e';
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> updateSchedule(String scheduleId, Schedule schedule) async {
    try {
      await _database.ref('schedules/$scheduleId').set(schedule.toJson());
      _error = '';
      notifyListeners();
    } catch (e) {
      _error = 'Error updating schedule: $e';
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      await _database.ref('schedules/$scheduleId').remove();
      _schedules.remove(scheduleId);
      _error = '';
      notifyListeners();
    } catch (e) {
      _error = 'Error deleting schedule: $e';
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> toggleSchedule(String scheduleId) async {
    try {
      if (_schedules.containsKey(scheduleId)) {
        final schedule = _schedules[scheduleId]!;
        final updatedSchedule = Schedule(
          id: schedule.id,
          name: schedule.name,
          deviceId: schedule.deviceId,
          action: schedule.action,
          time: schedule.time,
          enabled: !schedule.enabled,
          createdAt: schedule.createdAt,
          daysOfWeek: schedule.daysOfWeek,
        );
        await updateSchedule(scheduleId, updatedSchedule);
      }
    } catch (e) {
      _error = 'Error toggling schedule: $e';
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }
}
