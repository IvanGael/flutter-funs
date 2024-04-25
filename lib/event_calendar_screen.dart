
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<String>> _events = {
    DateTime.now().subtract(const Duration(days: 30)): ['Event 1'],
    DateTime.now().subtract(const Duration(days: 20)): ['Event 2'],
    DateTime.now().subtract(const Duration(days: 10)): ['Event 3', 'Event 4'],
    DateTime.now(): ['Event 5', 'Event 6', 'Event 7'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => _events[day] ?? [],
          ),
          const SizedBox(height: 20),
          Text(
            'Selected Day: ${_selectedDay != null ? DateFormat('yyyy-MM-dd').format(_selectedDay!) : "None"}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: _selectedDay != null && _events[_selectedDay] != null
                  ? _events[_selectedDay]!
                      .map((event) => ListTile(
                            title: Text(event),
                          ))
                      .toList()
                  : [
                      const ListTile(
                        title: Text('No events for selected day'),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}