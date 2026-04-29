import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';
import '../providers/weather_provider.dart';
import '../l10n/app_localizations.dart';
import 'widgets/device_card.dart';
import 'widgets/weather_widget.dart';
import 'widgets/connection_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).appTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<DeviceProvider>(
              builder: (context, deviceProvider, _) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: deviceProvider.isConnected 
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: deviceProvider.isConnected 
                          ? Colors.green 
                          : Colors.red,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: deviceProvider.isConnected 
                              ? Colors.green 
                              : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          deviceProvider.connectionStatus,
                          style: TextStyle(
                            fontSize: 12,
                            color: deviceProvider.isConnected 
                              ? Colors.green 
                              : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: AppLocalizations.of(context).navSchedule,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context).navSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const ScheduleTab();
      case 2:
        return const SettingsTab();
      default:
        return const HomeTab();
    }
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<DeviceProvider, WeatherProvider>(
      builder: (context, deviceProvider, weatherProvider, _) {
        return RefreshIndicator(
          onRefresh: () async {
            await weatherProvider.refreshWeather();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather Widget
                if (weatherProvider.weatherData != null)
                  WeatherWidget(weather: weatherProvider.weatherData!),
                
                const SizedBox(height: 24),
                
                // Connection Status
                const ConnectionStatus(),
                
                const SizedBox(height: 24),
                
                // Devices Section
                Text(
                  AppLocalizations.of(context).devicesTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                if (deviceProvider.devices.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF374151),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).devicesEmpty,
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: deviceProvider.devices.length,
                    itemBuilder: (context, index) {
                      final device = deviceProvider.devices.values.elementAt(index);
                      return DeviceCard(
                        device: device,
                        onTap: () {
                          deviceProvider.toggleDevice(device.id);
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule,
            size: 64,
            color: const Color(0xFF374151),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).scheduleComingSoon,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            size: 64,
            color: const Color(0xFF374151),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).settingsComingSoon,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
