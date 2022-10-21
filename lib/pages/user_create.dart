import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_big_car/firestore_models.dart';

class UserCreate extends StatefulWidget {
  const UserCreate({super.key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController yearLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackButton(
        color: Color.fromRGBO(33, 41, 239, 1),
      ),
      body: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Create User',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            const SizedBox(height: 20),
            OBCTextField(
              labelText: 'First Name',
              fontSize: 16,
              controller: fNameController,
            ),
            const SizedBox(height: 10),
            OBCTextField(
              labelText: 'Last Name',
              fontSize: 16,
              controller: lNameController,
            ),
            const SizedBox(height: 10),
            OBCTextField(
              labelText: 'Course Code',
              fontSize: 16,
              controller: courseCodeController,
            ),
            const SizedBox(height: 10),
            OBCTextField(
              labelText: 'Year Level',
              fontSize: 16,
              controller: yearLevelController,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(33, 41, 239, 1)),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white)
              ),
              onPressed: () {
                  final fName =  fNameController.text;
                  final lName = lNameController.text;
                  final courseCode = courseCodeController.text;
                  final yearLevel = yearLevelController.text;

                  createUser(
                    fName: fName,
                    lName: lName,
                    courseCode: courseCode,
                    yearLevel: yearLevel
                  );

                  fNameController.clear();
                  lNameController.clear();
                  courseCodeController.clear();
                  yearLevelController.clear();
              },
              child: const Text(
                'Create User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ),
            ),
          ]
        )
      )
    );
  }

  Future createUser({
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
  }
}

class OBCTextField extends StatefulWidget {
  OBCTextField({
    super.key,
    required this.labelText,
    required this.fontSize,
    required this.controller,
  });

  final String labelText;
  final double fontSize;
  final TextEditingController controller;

  @override
  State<OBCTextField> createState() => _OBCTextFieldState();
}

class _OBCTextFieldState extends State<OBCTextField> {
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      style: TextStyle(fontSize:widget.fontSize),
      decoration: InputDecoration(
        labelText: widget.labelText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(33, 41, 239, 1),
            width: 3.0,
          ), 
        ),
      ),
      /// TODO: set up a validator so the user wont make empty users
    );
  }


  
}