import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/examSchedule.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_project/screens/MapScreen.dart';

class EventCard extends StatelessWidget {
  final ExamSchedule exam;

  const EventCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4, 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exam.subject,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.access_time, size: 20, color: Colors.pink[100]),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${DateFormat('dd.MM.yyyy HH:mm').format(exam.datetime)} at ${exam.location.name}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
              child: const Text('View on map'),
            ),
          ],
        ),
      ),
    );
  }
}
