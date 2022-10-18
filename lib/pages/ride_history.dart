import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                  RideInfo(isMulti: true, paidFor: true, date: DateTime(2020, 12, 24)),
                  const SizedBox(height: 20),
                  RideInfo(isMulti: false, paidFor: false, date: DateTime(2020, 4, 13)),
                  const SizedBox(height: 20),
                  RideInfo(isMulti: false, paidFor: false, date: DateTime(2020, 8, 21)),
                  const SizedBox(height: 20),
                  RideInfo(isMulti: true, paidFor: true, date: DateTime(2020, 9, 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RideInfo extends StatefulWidget {
  RideInfo({
    super.key,
    required this.isMulti,
    required this.paidFor,
    required this.date,
  });

  final bool isMulti;
  final DateTime date;
  bool paidFor;

  @override
  State<RideInfo> createState() => _RideInfoState();
}

class _RideInfoState extends State<RideInfo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    final String dateInfo = formatter.format(widget.date);

    return Container(
      width: screenWidth * 0.85,
      height: 100,
      decoration: const BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateInfo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.isMulti ? 'Multi-Ride' : 'Single-Ride',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      fontFamily: 'Nunito',
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("PAYMENT",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      fontFamily: 'Nunito',
                      color: 
                        widget.paidFor ? Colors.green : Colors.red,
                    )
                  ),
                  Text(
                    widget.paidFor ? 'COMPLETED' : 'INCOMPLETE',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        fontFamily: 'Nunito',
                        color: 
                          widget.paidFor ? Colors.green : Colors.red,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
