import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getData() {
    final User user = auth.currentUser!;
    return user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackButton(
        color: Color.fromRGBO(33, 41, 239, 1),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),

            /// Top Bar containing chatter's icon and name
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(33, 41, 239, 1),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "User Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ))
              ],
            ),
          ),

          /// Chat messages of you and the chatter
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: screenHeight * 0.9,
              child: Column(
                children: [
                  /// This is the person your chatting with's chat and icon (left side)
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(33, 41, 239, 1),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: screenWidth * 0.50,
                                child: const Text(
                                  "User Name",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.60,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  color: Color.fromARGB(255, 221, 221, 221),
                                ),
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  "Is there a character that could even possibly EVEN TOUCH Madara Uchiha? Let alone defeat him. Im not talking about Edo Tensei Uchiha Madara. Im not talking about Gedou Rinne Tensei Uchiha Madara either. Hell, Im not even talking about Juubi Jinchuuriki Gedou Rinne Tensei Uchiha Madara with the Eternal Mangekyou Sharingan and Rinnegan doujutsus (with the rikodou abilities and being capable of both Amateratsu and Tsukuyomi genjutsu), ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  /// This is your chat and icon (right side)
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: screenWidth * 0.50,
                                child: const Text(
                                  "You",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.60,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  color: Color.fromRGBO(33, 41, 239, 1),
                                ),
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  "What are you smoking lmao",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(10.0),
                height: screenHeight * 0.10,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 64, 72, 249)),
                  color: Color.fromARGB(255, 64, 72, 249),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 25.0),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 64, 72, 249)),
                    color: Color.fromARGB(255, 117, 122, 255),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Aa",
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        textAlign: TextAlign.left,
                      )),
                )),
          )
        ],
      ),
    );
  }
}
