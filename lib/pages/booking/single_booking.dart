import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SingleBooking extends StatefulWidget {
  const SingleBooking({super.key});

  @override
  State<SingleBooking> createState() => _SingleBookingState();
}

class _SingleBookingState extends State<SingleBooking> {
  final database = FirebaseDatabase.instance.ref();

  TextEditingController TextController1 = TextEditingController();
  TextEditingController TextController2 = TextEditingController();
  TextEditingController TextController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate;

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
                      style: const TextStyle(fontSize: 14),
                      decoration: textInputDeco('Pick-up Area'),
                    ),
                    const SizedBox(height: 20),
                    // Drop-off area textfield
                    TextField(
                      controller: TextController2,
                      style: const TextStyle(fontSize: 14),
                      decoration: textInputDeco('Drop-off Area'),
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
                  final booking = <String, dynamic>{
                    'pick-up': TextController1,
                    'drop-off': TextController2,
                  };
                  database
                      .child('bookings')
                      .push()
                      .set(booking)
                      .then((_) => print('Booking created!'))
                      .catchError((error) => print('Error: $error'));
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
