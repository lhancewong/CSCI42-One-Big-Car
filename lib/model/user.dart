// ignore_for_file: prefer_const_declarations

final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id,
    firstName,
    lastName,
    courseCode,
    yearLevel,
    isHead,
    location,
  ];

  static final String id = '_id';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';
  static final String courseCode = 'courseCode';
  static final String yearLevel = 'yearLevel';
  static final String isHead = 'isHead';
  static final String location = 'location';
}

class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String courseCode;
  final String yearLevel;
  final bool isHead;
  final String location;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.courseCode,
    required this.yearLevel,
    required this.isHead,
    required this.location,
  });

  User copy({
    int? id,
    String? firstName,
    String? lastName,
    String? courseCode,
    String? yearLevel,
    bool? isHead,
    String? location,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        courseCode: courseCode ?? this.courseCode,
        yearLevel: yearLevel ?? this.yearLevel,
        isHead: isHead ?? this.isHead,
        location: location ?? this.location,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        firstName: json[UserFields.firstName] as String,
        lastName: json[UserFields.lastName] as String,
        courseCode: json[UserFields.courseCode] as String,
        yearLevel: json[UserFields.yearLevel] as String,
        isHead: json[UserFields.isHead] == 1,
        location: json[UserFields.location] as String,
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.courseCode: courseCode,
        UserFields.yearLevel: yearLevel,
        UserFields.isHead: isHead ? 1 : 0,
        UserFields.location: location,
      };
}
