import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<TimetableScreen> {
  List<List<String>> timetableData = List.generate(
    5, // Days (Monday to Friday)
    (index) =>
        List.generate(10, (index) => ""), // Time slots (8:00 AM to 6:00 PM)
  );

  String? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Weekday headers
            Row(
              children: [
                _buildDayHeader('Mon'),
                _buildDayHeader('Tue'),
                _buildDayHeader('Wed'),
                _buildDayHeader('Thu'),
                _buildDayHeader('Fri'),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // 5 days + 1 for time column
                ),
                itemCount: 5 * 10, // 5 days * 10 time slots
                itemBuilder: (context, index) {
                  final day = index ~/ 10; // 10 time slots per day
                  final timeSlot = index % 10;

                  return _buildTimetableCell(day, timeSlot);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCell() {
    return Container(); // Empty cell for the time column
  }

  Widget _buildDayHeader(String day) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topCenter,
        color: Colors.deepPurple,
        child: Text(
          day,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTimetableCell(int day, int timeSlot) {
    final String hour = _getTimeSlotHour(timeSlot);

    return GestureDetector(
      onTap: () {
        _showTaskDialog(day, timeSlot);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hour,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.greenAccent),
            ),
            Text(
              timetableData[day][timeSlot],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeSlotHour(int timeSlot) {
    const int startHour = 8; 
    final int currentHour = startHour + timeSlot;
    final String hour = '${currentHour.toString().padLeft(2, '0')}:00';
    return hour;
  }

  Future<void> _showTaskDialog(int day, int timeSlot) async {
    task = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Task'),
          content: TextField(
            onChanged: (value) {
              task = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, task);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (task != null) {
      setState(() {
        timetableData[day][timeSlot] = task!;
      });
    }
  }
}
