import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';

class MyUserHomepage extends StatefulWidget {
  const MyUserHomepage({super.key});

  @override
  State<MyUserHomepage> createState() => _MyUserHomepageState();
}

/// TODO: Ideally you pass this a user variable where it can get whether the
///  user is a HEAD or PASSENGER to display the right page. PASSENGER users cant
///  see the "View Passengers" button, but HEADS can. So if theres a way to
///  turn off that widget given that condition, ideally this widget should have
///  it. For now I wont do that.
class _MyUserHomepageState extends State<MyUserHomepage> {

   final FirebaseAuth auth = FirebaseAuth.instance;
  
  String getData() {
  final User user = auth.currentUser!;
  return user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    return Scaffold(
        backgroundColor: obcBlue,
        body: Stack(children: [
          //White BG with Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Welcome\nback, ' + getData() + '!',
                        style: const TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                          fontFamily: 'Nunito',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 25),
                      // Set-up Ride Button
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(40)),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(obcGrey),
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: BorderSide(color: obcGrey))),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SingleBooking');
                        },
                        child: const Text('Set-up ride',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Nunito',
                            )),
                      ),
                      // View Passengers Button
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(40)),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(obcGrey),
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: BorderSide(color: obcGrey))),
                        ),
                        onPressed: null,
                        child: const Text('View Passengers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Nunito',
                            )),
                      ),
                      const SizedBox(height: 25),
                      // View Ride History Button
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(14)),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(obcGrey),
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: BorderSide(color: obcGrey))),
                        ),
                        onPressed: null,
                        child: const Text('View ride history',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Nunito',
                            )),
                      ),
                    ]),
              ),
            ),
          ),

          // BackButton
          Container(
              margin: const EdgeInsets.all(10),
              child: const Align(
                alignment: Alignment.topLeft,
                child: BackButton(color: Colors.white),
              )),
          // ChatButton
          Container(
              margin: const EdgeInsets.all(10),
              child: const Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromRGBO(33, 41, 239, 1)),
                  ),
                  onPressed: null,
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
              )),
          // <USER> Homepage Text
          Container(
              margin: const EdgeInsets.all(40),
              alignment: Alignment.center,
              child: Column(
                children: const [
                  SizedBox(height: 25),
                  Text(
                    'HEAD',
                    style: TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Homepage',
                    style: TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          // Bottom Loading Bar
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: screenHeight * 0.10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: obcBlue),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: obcBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      Text(
                        ' Searching for a ride',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          color: Colors.white,
                        ),
                      )
                    ],
                  )))
        ]));
  }
}
