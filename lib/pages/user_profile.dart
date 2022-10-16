import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';

const List<String> list = <String>['HEAD', 'PASSENGER'];

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
              height: screenHeight * 0.75,
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
                const Text(
                  'User Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    color: Color.fromRGBO(33, 41, 239, 1),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.65,
                  height: screenWidth * 0.65,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(33, 41, 239, 1),
                      width: screenWidth * 0.020,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  getData(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'IV BS CS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(33, 41, 239, 1)),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Colors.white),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    underline: Container(color: Colors.white),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.expand_more,
                      color: Color.fromRGBO(33, 41, 239, 1),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            fontFamily: 'Nunito',
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(90, 15, 90, 15)),
                    backgroundColor: MaterialStatePropertyAll<Color>(obcGrey),
                    foregroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide(color: obcGrey))),
                  ),
                  child: const Text(
                    "Home",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        fontFamily: 'Nunito',
                        color: Color.fromRGBO(33, 41, 239, 1),
                      )),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Homepage');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
