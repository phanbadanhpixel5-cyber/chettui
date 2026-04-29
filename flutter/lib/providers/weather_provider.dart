import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final String main;
  final double windSpeed;
  final String city;
  final DateTime updatedAt;

  WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.main,
    required this.windSpeed,
    required this.city,
    required this.updatedAt,
  });

  factory WeatherData.fromJson(Map<dynamic, dynamic> json) {
    return WeatherData(
      temperature: (json['temperature'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: json['humidity'] as int,
      description: json['description'] ?? 'N/A',
      main: json['main'] ?? 'Unknown',
      windSpeed: (json['windSpeed'] as num).toDouble(),
      city: json['city'] ?? 'Unknown',
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class WeatherProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  
  WeatherData? _weatherData;
  bool _isLoading = false;
  String _error = '';

  WeatherData? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String get error => _error;

  WeatherProvider() {
    _initializeWeather();
  }

  Future<void> _initializeWeather() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Listen to Firebase weather data
      _database.ref('weather').onValue.listen((event) {
        if (event.snapshot.exists) {
          try {
            _weatherData = WeatherData.fromJson(
              Map<String, dynamic>.from(event.snapshot.value as Map),
            );
            _error = '';
          } catch (e) {
            _error = 'Error parsing weather data: $e';
            if (kDebugMode) print(_error);
          }
        }
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _error = 'Error loading weather: $e';
      _isLoading = false;
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('http://your-backend-ip:5000/api/weather'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(data);
        _error = '';
      } else {
        _error = 'Failed to fetch weather data';
      }
    } catch (e) {
      _error = 'Error refreshing weather: $e';
      if (kDebugMode) print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getWeatherIcon(String condition) {
    final condition_lower = condition.toLowerCase();
    if (condition_lower.contains('clear') || condition_lower.contains('sunny')) {
      return '☀️';
    } else if (condition_lower.contains('cloud')) {
      return '☁️';
    } else if (condition_lower.contains('rain')) {
      return '🌧️';
    } else if (condition_lower.contains('thunder')) {
      return '⛈️';
    } else if (condition_lower.contains('snow')) {
      return '❄️';
    } else if (condition_lower.contains('wind')) {
      return '💨';
    }
    return '🌡️';
  }
}
