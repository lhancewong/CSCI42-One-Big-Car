import 'package:flutter/material.dart';
import 'package:one_big_car/user_profile.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

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
            const TextField(
              style: TextStyle(fontSize:16),
              decoration: InputDecoration(
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
            const TextField(
              obscureText: true,
              style: TextStyle(fontSize:16),
              decoration: InputDecoration(
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
                Navigator.of(context).push(_routeUserProfile());
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

Route _routeUserProfile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MyUserProfile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
