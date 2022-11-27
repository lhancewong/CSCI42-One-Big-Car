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
  TextEditingController textController = TextEditingController();

  String getData() {
    final User user = auth.currentUser!;
    return user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String username = "Wilbert";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(33, 41, 239, 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(33, 41, 239, 1),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: screenWidth * 0.50,
                            child: Text(
                              username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black,
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
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  /// This is your chat and icon (right side)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: screenWidth * 0.50,
                            child: const Text(
                              "You",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.60,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromRGBO(33, 41, 239, 1),
                            ),
                            child: const Text(
                              "What are you smoking lmao",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
                border:
                    Border.all(color: const Color.fromARGB(255, 64, 72, 249)),
                color: const Color.fromARGB(255, 64, 72, 249),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 25.0),
                width: screenWidth * 0.9,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 64, 72, 249)),
                  color: const Color.fromARGB(255, 117, 122, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: textController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Aa',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(33, 41, 239, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
