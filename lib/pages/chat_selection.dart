import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatSelection extends StatefulWidget {
  const ChatSelection({super.key});

  @override
  State<ChatSelection> createState() => _ChatSelectionState();
}

class _ChatSelectionState extends State<ChatSelection> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getData() {
    final User user = auth.currentUser!;
    return user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 41, 239, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackButton(
        color: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: const Text(
                "Chat",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  fontFamily: 'Nunito',
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: screenHeight * 0.90,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
              ),

              /// Each Selection of chat showing name and picture
              child: Column(
                children: [
                  ChatBox(
                      chatName: "Wilbert",
                      chatText: "Is there a character that...",
                      time: DateTime(1, 1, 1, 11, 26)),
                  ChatBox(
                      chatName: "Lhance",
                      chatText: "Wong",
                      time: DateTime(1, 1, 1, 4, 17)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBox extends StatefulWidget {
  ChatBox({
    super.key,
    required this.chatName,
    required this.chatText,
    required this.time,
  });

  final String chatName;
  final DateTime time;
  String chatText;

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    final DateFormat formatter = DateFormat('hh:mm');
    final String timeInfo = formatter.format(widget.time);

    return Container(
        width: screenWidth,
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: ElevatedButton(
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
          onPressed: () {
            Navigator.of(context).pushNamed('/ChatPage');
          },
          child: Row(
          children: [
            Flexible(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(33, 41, 239, 1),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.chatText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(timeInfo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          fontFamily: 'Nunito',
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 3,
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
