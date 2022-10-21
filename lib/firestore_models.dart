import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  String firstName;
  String lastName;
  String courseCode;
  String yearLevel;
  GeoPoint location;
  
  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.courseCode,
    required this.yearLevel,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'courseCode': courseCode,
    'yearLevel': yearLevel,
    'location': location,
  };
}
