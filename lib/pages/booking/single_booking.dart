import 'dart:ffi';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_big_car/global/global.dart';

class SingleBooking extends StatefulWidget {
  const SingleBooking({super.key});

  @override
  State<SingleBooking> createState() => _SingleBookingState();
}

class _SingleBookingState extends State<SingleBooking> {
  Map data = {};
  List sourceData = [];
  List destinationData = [];

  TextEditingController TextController1 = TextEditingController();
  TextEditingController TextController2 = TextEditingController();
  TextEditingController TextController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;

    double screenHeight = MediaQuery.of(context).size.height;

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    InputDecoration textInputDeco(String labelText) {
      return InputDecoration(
        labelText: labelText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(33, 41, 239, 1),
            width: 3.0,
          ),
        ),
      );
    }

    InputDecoration dateFieldInputDeco = InputDecoration(
      labelText: 'Select a Date and Time',
      labelStyle: const TextStyle(fontSize: 14),
      suffixIcon: Icon(Icons.event_note, color: obcBlue),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: obcBlue,
          width: 3.0,
        ),
      ),
    );

    TextStyle titleStyle = const TextStyle(
      height: 1,
      fontWeight: FontWeight.w800,
      fontSize: 32,
      color: Colors.white,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: obcBlue,
      body: Stack(
        children: [
          // Page title
          Container(
            padding:
                const EdgeInsets.only(top: 55, bottom: 40, left: 40, right: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text('Single-Ride', style: titleStyle),
                Text('Booking Page', style: titleStyle)
              ],
            ),
          ),
          //White BG with Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.83,
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
                margin: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    // Pick-up area textfield
                    TextField(
                      controller: TextController1,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: textInputDeco('Pick-up Area'),
                      onTap: () async {
                        final data =
                            await Navigator.pushNamed(context, '/Location')
                                as Map;

                        setState(() {
                          TextController1.text = data['title'];
                          sourceData = [
                            data['title'],
                            data['latitude'],
                            data['longitude']
                          ];
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Drop-off area textfield
                    TextField(
                      controller: TextController2,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: textInputDeco('Drop-off Area'),
                      onTap: () async {
                        final data =
                            await Navigator.pushNamed(context, '/Location')
                                as Map;

                        setState(() {
                          TextController2.text = data['title'];
                          destinationData = [
                            data['title'],
                            data['latitude'],
                            data['longitude']
                          ];
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Select a date textfield
                    DateTimeFormField(
                      mode: DateTimeFieldPickerMode.dateAndTime,
                      firstDate: DateTime.now(),
                      onDateSelected: (DateTime value) {
                        selectedDate = value;
                      },
                      decoration: dateFieldInputDeco,
                    ),
                    const SizedBox(height: 25),
                    // Notes textfield
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: obcGrey),
                        color: obcGrey,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Notes:',
                            style: TextStyle(fontSize: 14),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.multiline,
                            minLines: 8,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
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
          // Bottom rounded blue bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.10,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: obcBlue,
                border: Border.all(color: obcBlue),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              // Submit Single Ride Button
              child: TextButton(
                onPressed: () async {
                  if (sourceData.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please select a Pick-up Area.");
                  } else if (destinationData.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please select a Drop-off Area.");
                  } else if (selectedDate != null) {
                    Fluttertoast.showToast(
                        msg: "Please select a Date and Time.");
                  } else {
                    Map<String, Object> sourceBookingMap = {
                      "title": sourceData[0],
                      "latitude": sourceData[1],
                      "longitude": sourceData[2],
                    };

                    Map<String, Object> destinationBookingMap = {
                      "title": destinationData[0],
                      "latitude": destinationData[1],
                      "longitude": destinationData[2],
                    };

                    Map<String, dynamic> bookingMap = {
                      "datetime": selectedDate,
                      "notes": TextController3.text,
                    };

                    DatabaseReference sourceBookingRef =
                        FirebaseDatabase.instance.ref().child("bookings");
                    sourceBookingRef
                        .child(currentFirebaseUser!.uid)
                        .child("source")
                        .update(sourceBookingMap);

                    DatabaseReference destinationBookingRef =
                        FirebaseDatabase.instance.ref().child("bookings");
                    destinationBookingRef
                        .child(currentFirebaseUser!.uid)
                        .child("destination")
                        .update(destinationBookingMap);

                    DatabaseReference bookingRef =
                        FirebaseDatabase.instance.ref().child("bookings");
                    bookingRef.child(currentFirebaseUser!.uid).update(bookingMap);

                    Fluttertoast.showToast(
                        msg: "Booking Information has been saved.");
                  }
                },
                child: const Text(
                  'Submit Single-ride Request',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
