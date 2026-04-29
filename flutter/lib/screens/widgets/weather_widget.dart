import 'package:flutter/material.dart';
import '../../providers/weather_provider.dart';
import '../../l10n/app_localizations.dart';

class WeatherWidget extends StatelessWidget {
  final dynamic weather;

  const WeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = WeatherProvider();
    final icon = weatherProvider.getWeatherIcon(weather.main);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1F2937),
            const Color(0xFF111827),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF374151),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.city,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.description.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              Text(
                icon,
                style: const TextStyle(fontSize: 64),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherInfo(
                context,
                AppLocalizations.of(context).weatherTemperature,
                '${weather.temperature.toStringAsFixed(1)}°C',
                Icons.thermometer,
              ),
              _buildWeatherInfo(
                context,
                'Cảm Giác',
                '${weather.feelsLike.toStringAsFixed(1)}°C',
                Icons.trending_down,
              ),
              _buildWeatherInfo(
                context,
                AppLocalizations.of(context).weatherHumidity,
                '${weather.humidity}%',
                Icons.water_drop,
              ),
              _buildWeatherInfo(
                context,
                AppLocalizations.of(context).weatherWindSpeed,
                '${weather.windSpeed.toStringAsFixed(1)} m/s',
                Icons.air,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Last updated: ${DateTime.now().toString().split('.')[0]}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF3B82F6), size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
