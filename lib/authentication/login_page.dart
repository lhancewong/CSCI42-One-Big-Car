import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_big_car/global/global.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  validateForm() {
    if (!emailTextController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    } else if (passwordTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      saveInfo();
      Navigator.pushNamed(context, '/UserProfile', arguments: <String, String>{
        'email': emailTextController.text,
        'Password': passwordTextController.text,
      });
    }
  }

  saveInfo() async {
    final User? firebaseUser = (await fAuth
        .signInWithEmailAndPassword(
      email: emailTextController.text.trim(),
      password: passwordTextController.text.trim(),
    )
        .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    })).user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      await Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.pushNamed(context, '/UserProfile');
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: const Icon(
          Icons.arrow_back,
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
                  const Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                    child: const Text('Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Register');
                    },
                    child: const Text(
                      'Create a new account',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ])));
  }
}
