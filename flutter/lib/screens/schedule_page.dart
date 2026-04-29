import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/schedule_provider.dart';
import '../../providers/device_provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Schedules'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showCreateScheduleDialog(context);
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ScheduleProvider>(
        builder: (context, scheduleProvider, _) {
          if (scheduleProvider.schedules.isEmpty) {
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
                  const Text(
                    'No schedules created',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _showCreateScheduleDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Create Schedule'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scheduleProvider.schedules.length,
            itemBuilder: (context, index) {
              final schedule = scheduleProvider.schedules.values
                  .toList()[index];
              return _buildScheduleCard(context, schedule);
            },
          );
        },
      ),
    );
  }

  Widget _buildScheduleCard(BuildContext context, dynamic schedule) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: schedule.enabled
            ? const Color(0xFF3B82F6)
            : const Color(0xFF374151),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          schedule.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: schedule.action == 'ON'
                            ? const Color(0xFF10B981).withOpacity(0.2)
                            : const Color(0xFFEF4444).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          schedule.action,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: schedule.action == 'ON'
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: const Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        schedule.time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.device_hub,
                        size: 16,
                        color: const Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Device ${schedule.deviceId}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Switch(
                    value: schedule.enabled,
                    onChanged: (value) {
                      Provider.of<ScheduleProvider>(context, listen: false)
                          .toggleSchedule(schedule.id);
                    },
                    activeColor: const Color(0xFF3B82F6),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmation(context, schedule.id);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _CreateScheduleDialog(),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String scheduleId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Schedule'),
        content: const Text('Are you sure you want to delete this schedule?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ScheduleProvider>(context, listen: false)
                  .deleteSchedule(scheduleId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _CreateScheduleDialog extends StatefulWidget {
  @override
  State<_CreateScheduleDialog> createState() => _CreateScheduleDialogState();
}

class _CreateScheduleDialogState extends State<_CreateScheduleDialog> {
  late TextEditingController _nameController;
  late TextEditingController _timeController;
  String _selectedDevice = '1';
  String _selectedAction = 'ON';
  List<int> _selectedDays = [1, 2, 3, 4, 5]; // Weekdays by default

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _timeController = TextEditingController(text: '08:00');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devices = Provider.of<DeviceProvider>(context).devices;

    return AlertDialog(
      title: const Text('Create Schedule'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Schedule Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedDevice,
              items: devices.entries.map((e) {
                return DropdownMenuItem(
                  value: e.key,
                  child: Text('${e.value.name} (GPIO ${e.value.pin})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDevice = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Device',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAction,
              items: ['ON', 'OFF']
                  .map((action) => DropdownMenuItem(
                        value: action,
                        child: Text(action),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAction = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Action',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              readOnly: true,
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(_timeController.text.split(':')[0]),
                    minute: int.parse(_timeController.text.split(':')[1]),
                  ),
                );
                if (time != null) {
                  _timeController.text =
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                }
              },
              decoration: InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(Icons.access_time),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              Provider.of<ScheduleProvider>(context, listen: false)
                  .createSchedule(
                name: _nameController.text,
                deviceId: _selectedDevice,
                action: _selectedAction,
                time: _timeController.text,
                daysOfWeek: _selectedDays,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
