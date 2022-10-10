import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_big_car/main.dart';
import 'package:one_big_car/pages/authentication.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
  
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(33, 41, 239, 1)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: const Color.fromRGBO(33, 41, 239, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    fontFamily: 'Nunito',
                    color: Color.fromRGBO(33, 41, 239, 1),
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  "ONE BIG CAR",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w800,
                    fontSize: 70,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
                const Image(
                    image: AssetImage('assets/car.png'),
                ),
                const SizedBox(height: 40),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => AuthFunc(
                    loggedIn: appState.loggedIn,
                      signOut: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
