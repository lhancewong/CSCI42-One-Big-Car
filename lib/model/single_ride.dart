class SingleRide {
  final String id;
  String pickUpArea;
  String dropOffArea;
  DateTime meetUpTime;

  SingleRide({
    this.id = '',
    required this.pickUpArea,
    required this.dropOffArea,
    required this.meetUpTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pickUpArea': pickUpArea,
        'dropOffArea': dropOffArea,
        'meetUpTime': meetUpTime,
      };

  /* Future createUser({
    required String fName,
    required String lName,
    required String courseCode,
    required String yearLevel 
  }) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final user = User(
      id: docUser.id,
      firstName: fName,
      lastName: lName,
      courseCode: courseCode,
      yearLevel: yearLevel,
      location: const GeoPoint(69,69),
    );
    final userJson = user.toJson();

    await docUser.set(userJson);
    } */
}
