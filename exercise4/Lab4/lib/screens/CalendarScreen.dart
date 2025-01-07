import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_project/models/ExamSchedule.dart';
import 'package:new_flutter_project/main.dart';
import 'package:new_flutter_project/screens/MapScreen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<String, List<ExamSchedule>> _events;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _events = {};
    _fetchExams();
  }

  Future<void> _fetchExams() async {
    var snapshot = await FirebaseFirestore.instance.collection('examschedules').get();
    List<ExamSchedule> exams = await Future.wait(
      snapshot.docs.map((doc) async => ExamSchedule.fromMap(doc.data())).toList(),
    );

    Map<String, List<ExamSchedule>> groupedEvents = {};
    for (var exam in exams) {
      DateTime eventDate = DateTime(
        exam.datetime.year,
        exam.datetime.month,
        exam.datetime.day,
      );

      var eventDateKey = eventDate.toIso8601String();

      if (groupedEvents[eventDateKey] == null) {
        groupedEvents[eventDateKey] = [];
      }
      groupedEvents[eventDateKey]!.add(exam);
      
      scheduleLocalNotification(exam.location.name, exam.subject, exam.datetime);
    }

    setState(() {
      _events = groupedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text('Exam Calendar', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar<ExamSchedule>(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              var selectedDayKey = selectedDay.toIso8601String();
              selectedDayKey = selectedDayKey.substring(0, selectedDayKey.length - 1);

              if (_events[selectedDayKey] != null) {
                _showExamPopup(context, _events[selectedDayKey]!);
              }
            },
            eventLoader: (day) {
              var dayKey = day.toIso8601String();
              dayKey = dayKey.substring(0, dayKey.length - 1);
              return _events[dayKey] ?? [];
            },
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
          ),
          if (_selectedDay != null && _events[_selectedDay?.toIso8601String()]?.isNotEmpty == true)
            ..._events[_selectedDay?.toIso8601String()]!.map(
              (exam) => ListTile(
                title: Text(exam.subject),
                subtitle: Text(DateFormat('HH:mm').format(exam.datetime)),
              ),
            ),
        ],
      ),
    );
  }

  void _showExamPopup(BuildContext context, List<ExamSchedule> exams) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exam Details'),
          content: SingleChildScrollView(
            child: Column(
              children: exams.map((exam) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject: ${exam.subject}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Time: ${DateFormat('HH:mm').format(exam.datetime)}',
                      ),
                      Text(
                        'Location: ${exam.location.name}',
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(location: exam.location),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('View on Map'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
