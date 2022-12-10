import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:one_big_car/global/global.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

/// TODO: Ideally you pass this a user variable where it can get whether the
///  user is a HEAD or PASSENGER to display the right page. PASSENGER users cant
///  see the "View Passengers" button, but HEADS can. So if theres a way to
///  turn off that widget given that condition, ideally this widget should have
///  it. For now I wont do that.
class _UserHomepageState extends State<UserHomepage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Map data = {};
  String name = "";
  bool isHead = true;

  String? getData() {
    currentFirebaseUser = fAuth.currentUser;
    if (currentFirebaseUser != null) {
      return "Username can't be empty";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);
    Color obcLightBlue = const Color.fromRGBO(33, 41, 239, 0.5);

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    name = data["name"];
    isHead = ("HEAD" == data["role"]);

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
                child: DraggableScrollableSheet(
                  initialChildSize: 1,
                  minChildSize: 1,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      child: isHead
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Welcome\nback, $name!',
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
                                          MaterialStatePropertyAll<Color>(
                                              obcGrey),
                                      foregroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side:
                                                  BorderSide(color: obcGrey))),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/SingleBooking');
                                    },
                                    child: const Text('Set-up ride',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          fontFamily: 'Nunito',
                                        )),
                                  ),
                                  const SizedBox(height: 25),
                                  // View Passengers Button
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.all(40)),
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              obcGrey),
                                      foregroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side:
                                                  BorderSide(color: obcGrey))),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/PassengerList');
                                    },
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
                                          MaterialStatePropertyAll<Color>(
                                              obcGrey),
                                      foregroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side:
                                                  BorderSide(color: obcGrey))),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/RideHistory');
                                    },
                                    child: const Text('View ride history',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          fontFamily: 'Nunito',
                                        )),
                                  ),
                                ])
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Welcome\nback, $name!',
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
                                          MaterialStatePropertyAll<Color>(
                                              obcGrey),
                                      foregroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side:
                                                  BorderSide(color: obcGrey))),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/RideList');
                                    },
                                    child: const Text('Find a ride',
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
                                          MaterialStatePropertyAll<Color>(
                                              obcGrey),
                                      foregroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side:
                                                  BorderSide(color: obcGrey))),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/RideHistory');
                                    },
                                    child: const Text('View ride history',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          fontFamily: 'Nunito',
                                        )),
                                  ),
                                ]),
                    );
                  },
                ),
              ),
            ),
          ),

          // BackButton
          Container(
              margin: const EdgeInsets.all(30),
              child: const Align(
                alignment: Alignment.topLeft,
                child: BackButton(color: Colors.white),
              )),
          // ChatButton
          Container(
              margin: const EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromRGBO(33, 41, 239, 1)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/ChatSelection');
                  },
                  child: const Icon(
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
                children: [
                  const SizedBox(height: 25),
                  Text(
                    isHead ? 'HEAD' : 'PASSENGER',
                    style: const TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                  const Text(
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
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/RideList');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth, screenHeight * 0.10),
                  backgroundColor: obcBlue,
                ),
                child: const Text('View current ride details',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ))),
          )
        ]));
  }
}
