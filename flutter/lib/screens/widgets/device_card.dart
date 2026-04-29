import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class DeviceCard extends StatelessWidget {
  final dynamic device;
  final VoidCallback onTap;

  const DeviceCard({
    Key? key,
    required this.device,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: device.state 
              ? const Color(0xFF3B82F6)
              : const Color(0xFF374151),
            width: 2,
          ),
          boxShadow: device.state
            ? [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'GPIO ${device.pin}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: device.state
                      ? const Color(0xFF3B82F6).withOpacity(0.2)
                      : const Color(0xFF374151),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    device.state ? Icons.power_settings_new : Icons.power_off,
                    color: device.state 
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF6B7280),
                    size: 24,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: device.state
                  ? const Color(0xFF10B981).withOpacity(0.2)
                  : const Color(0xFF374151),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                device.state 
                  ? AppLocalizations.of(context).deviceOn
                  : AppLocalizations.of(context).deviceOff,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: device.state
                    ? const Color(0xFF10B981)
                    : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
