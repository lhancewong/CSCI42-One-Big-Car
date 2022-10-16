import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';

const List<String> list = <String>['HEAD', 'PASSENGER'];

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  String dropdownValue = list.first;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getData() {
    final User user = auth.currentUser!;
    return user.displayName ?? 'Anon User';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackButton(
        color: Color.fromRGBO(33, 41, 239, 1),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(40.0),
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(33, 41, 239, 1)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: const Color.fromRGBO(33, 41, 239, 1),
              ),
              child: Column(
                children: [
                  Container(
                      width: screenWidth * 0.85,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "April 4, 2020",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Multi-Ride",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("PAYMENT",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.green,
                                  )),
                              const Text(
                                "COMPLETED",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.green),
                              )
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: screenWidth * 0.85,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "April 4, 2020",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Single Ride",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 63,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("PAYMENT",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.red,
                                  )),
                              const Text(
                                "INCOMPLETE",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.red),
                              )
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: screenWidth * 0.85,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "April 4, 2020",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Multi-Ride",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("PAYMENT",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.red,
                                  )),
                              const Text(
                                "INCOMPLETE",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.red),
                              )
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: screenWidth * 0.85,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "April 4, 2020",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Single Ride",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 65,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("PAYMENT",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.green,
                                  )),
                              const Text(
                                "COMPLETED",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    fontFamily: 'Nunito',
                                    color: Colors.green),
                              )
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
