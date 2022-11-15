import 'package:flutter/material.dart';
import 'package:one_big_car/database/user_database.dart';
import 'package:one_big_car/model/user.dart';

const List<String> list = <String>['HEAD', 'PASSENGER'];

class UserCreate extends StatefulWidget {
  final User? user;

  const UserCreate({super.key, this.user});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  String dropdownValue = list.first;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController yearLevelController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool userExists = widget.user != null;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: const BackButton(
          color: Color.fromRGBO(33, 41, 239, 1),
        ),
        body: Container(
            margin: const EdgeInsets.all(40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userExists ? 'Edit User' : 'Create User',
                          style: const TextStyle(
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
                      OBCTextField(
                        labelText: 'Location',
                        fontSize: 16,
                        controller: locationController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 40),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 3,
                              color: const Color.fromRGBO(33, 41, 239, 1),
                            ),
                            value: dropdownValue,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.expand_more,
                              color: Color.fromRGBO(33, 41, 239, 1),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(fontSize: 16)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromRGBO(33, 41, 239, 1)),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white),
                        ),
                        onPressed: () {
                          final fName = fNameController.text;
                          final lName = lNameController.text;
                          final courseCode = courseCodeController.text;
                          final yearLevel = yearLevelController.text;
                          final location = locationController.text;

                          addOrUpdateUser(
                            fName: fName,
                            lName: lName,
                            courseCode: courseCode,
                            yearLevel: yearLevel,
                            location: location,
                          );

                          fNameController.clear();
                          lNameController.clear();
                          courseCodeController.clear();
                          yearLevelController.clear();
                          locationController.clear();

                          Navigator.of(context).pop();
                        },
                        child: Text(userExists ? 'Edit User' : 'Create User',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                      ),
                    ]),
              ),
            )));
  }

  Future addOrUpdateUser(
      {required String fName,
      required String lName,
      required String courseCode,
      required String yearLevel,
      required String location}) async {
    final user = User(
      firstName: fName,
      lastName: lName,
      courseCode: courseCode,
      yearLevel: yearLevel,
      isHead: dropdownValue == 'HEAD',
      location: location,
    );

    final userExists = widget.user != null;

    if (userExists) {
      final user = widget.user!.copy(
        firstName: fName,
        lastName: lName,
        courseCode: courseCode,
        yearLevel: yearLevel,
        isHead: dropdownValue == 'HEAD',
        location: location,
      );
      await UserDatabase.instance.update(user);
    } else {
      await UserDatabase.instance.create(user);
    }
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
      style: TextStyle(fontSize: widget.fontSize),
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
