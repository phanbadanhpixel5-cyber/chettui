import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/device_provider.dart';
import '../../l10n/app_localizations.dart';

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceProvider>(
      builder: (context, deviceProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: deviceProvider.isConnected 
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: deviceProvider.isConnected 
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trạng Thái Hệ Thống',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deviceProvider.connectionStatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: deviceProvider.isConnected 
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                deviceProvider.isConnected 
                  ? Icons.check_circle
                  : Icons.error_circle,
                color: deviceProvider.isConnected 
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
                size: 28,
              ),
            ],
          ),
        );
      },
    );
  }
}
