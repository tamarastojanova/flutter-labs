import 'package:new_flutter_project/models/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamSchedule {
  final String id;
  final String subject;
  final DateTime datetime;
  final Location location;

  ExamSchedule({
    required this.id,
    required this.subject,
    required this.datetime,
    required this.location,
  });

  static Future<ExamSchedule> fromMap(Map<String, dynamic> map) async {
    try {
      DocumentReference locationRef = map['location'];  // This is the location reference
      DocumentSnapshot locationSnapshot = await locationRef.get();
      Location location = Location.fromMap(locationSnapshot.data() as Map<String, dynamic>);

      return ExamSchedule(
        id: map['id'],
        subject: map['subject'],
        datetime: (map['datetime'] as Timestamp).toDate(),
        location: location,
      );
    } catch (e) {
      print("Error fetching location or date: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'dateTime': datetime.toIso8601String(),
      'location': location,
    };
  }
}