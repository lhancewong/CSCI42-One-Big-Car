import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_big_car/global/global.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController yearTextController = TextEditingController();
  TextEditingController courseTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  validateForm() {
    if (!emailTextController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    } else if (passwordTextController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters.");
    } else if (firstNameTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "First Name must be at least 1 character.");
    } else if (lastNameTextController.text.length < 2) {
      Fluttertoast.showToast(msg: "Last Name must be at least 2 characters.");
    } else if (yearTextController.text.isEmpty ||
        yearTextController.text.length > 1) {
      Fluttertoast.showToast(msg: "Year Level must be exactly 1 character.");
    } else if (courseTextController.text.length < 4) {
      Fluttertoast.showToast(msg: "Password must be at least 4 characters.");
    } else if (confirmPasswordTextController.text !=
        passwordTextController.text) {
      Fluttertoast.showToast(msg: "Passwords do not match");
    } else {
      saveInfo();
    }
  }

  saveInfo() async {
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailTextController.text.trim(),
      password: passwordTextController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map userMap = {
        "id": firebaseUser.uid,
        "email": emailTextController.text.trim(),
        "first name": firstNameTextController.text.trim(),
        "last name": lastNameTextController.text.trim(),
        "year": yearTextController.text.trim(),
        "course": courseTextController.text.trim(),
        "password": passwordTextController.text.trim(),
      };

      DatabaseReference usersRef =
          FirebaseDatabase.instance.ref().child("users");
      usersRef.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created.");
      Navigator.pushNamed(context, '/LogIn');
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  @override
  Widget build(BuildContext context) {

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);
    
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: BackButton(
        color: obcBlue,
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
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: emailTextController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.name,
                    enableSuggestions: false,
                    controller: firstNameTextController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.name,
                    enableSuggestions: false,
                    controller: lastNameTextController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: yearTextController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Year Level',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.name,
                    enableSuggestions: false,
                    controller: courseTextController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Course',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "•",
                    controller: passwordTextController,
                    enableSuggestions: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "•",
                    controller: confirmPasswordTextController,
                    enableSuggestions: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(33, 41, 239, 1)),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.white)),
                    onPressed: () {
                      validateForm();
                    },
                    child: const Text('Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/LogIn');
                    },
                    child: const Text(
                      'Already have an account? Log in.',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ])));
  }
}
