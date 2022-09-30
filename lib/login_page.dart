import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
              controller: usernameTextController,
              style: const TextStyle(fontSize:16),
              decoration: const InputDecoration(
                labelText: 'Username',
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
              style: const TextStyle(fontSize:16),
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
                  style: TextStyle(fontSize:12),
                  ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(33, 41, 239, 1)),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white)
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/UserProfile', arguments: <String, String> {
                  'Username': usernameTextController.text,
                  'Password': passwordTextController.text,
                });
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ),
            ),
            const TextButton(
              onPressed: null,
              child: Text(
                'Create a new account',
                style: TextStyle(fontSize:12),
              ),
            )
          ]
        )
      )
    );
  }
}