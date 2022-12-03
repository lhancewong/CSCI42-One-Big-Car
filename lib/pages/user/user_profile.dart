import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_big_car/global/global.dart';
import 'package:firebase_storage/firebase_storage.dart';

const List<String> list = <String>['HEAD', 'PASSENGER'];

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? dropdownValue;

  Map data = {};

  String name = "";

  @override
  void initState() {
    super.initState();

    loadProfilePicture();
  }

  saveInfo() async {
    Map userMap = {
      "role": dropdownValue,
    };

    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
    usersRef.child(currentFirebaseUser!.uid).child("profile").set(userMap);

    final ref = FirebaseDatabase.instance.ref();
    String? user = currentFirebaseUser!.uid.toString();
    final snapshot = await ref.child('users/$user/first name').get();
    if (snapshot.exists) {
      name = '${snapshot.value}';
    } else {
      name = "Poseidon";
    }

    Fluttertoast.showToast(msg: "Profile information has been saved.");
    Navigator.pushNamed(context, '/Homepage', arguments: <String, String>{
      "name": name,
    });

    String getData() {
      final User user = fAuth.currentUser!;
      return user.displayName ?? 'Anon User';
    }
  }

  void pickUploadProfilePicture() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: MediaQuery.of(context).size.width * 0.65,
      maxWidth: MediaQuery.of(context).size.width * 0.65,
      imageQuality: 80,
    );

    String? user = currentFirebaseUser!.uid.toString();
    final profilePicRef =
        FirebaseStorage.instance.ref().child('images/$user/profilepic.jpg');
    await profilePicRef.putFile(File(image!.path));
    loadProfilePicture();
  }

  void loadProfilePicture() async {
    String? user = currentFirebaseUser!.uid.toString();
    final profilePicRef =
        FirebaseStorage.instance.ref().child('images/$user/profilepic.jpg');
    profilePicRef.getDownloadURL().then(((value) {
      setState(() {
        profilePicUrl = value;
      });
    }));
  }

  String profilePicUrl = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    ButtonStyle buttonStyle = ButtonStyle(
      padding:
          const MaterialStatePropertyAll(EdgeInsets.fromLTRB(90, 15, 90, 15)),
      backgroundColor: MaterialStatePropertyAll<Color>(obcGrey),
      foregroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
              side: BorderSide(color: obcGrey))),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: BackButton(
        color: obcBlue,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.75,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.all(color: obcBlue),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: obcBlue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'User Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: obcBlue,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: pickUploadProfilePicture,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: obcBlue,
                        width: screenWidth * 0.020,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: CircleAvatar(
                      radius: screenWidth * 0.35,
                      backgroundImage: NetworkImage(profilePicUrl),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  data["name"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data["year&course"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: obcBlue),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Colors.white),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    underline: Container(color: Colors.white),
                    isExpanded: true,
                    icon: Icon(
                      Icons.expand_more,
                      color: obcBlue,
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
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: buttonStyle,
                  child: Text("Save",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        color: obcBlue,
                      )),
                  onPressed: () {
                    saveInfo();
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
