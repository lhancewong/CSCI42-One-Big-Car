import 'package:flutter/material.dart';

const List<String> list = <String>['HEAD', 'PASSENGER'];

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  Map data = {};
  String dropdownValue = list.first;
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    username = data['Username'];
    password = data['Password'];
  
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
                  username,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
