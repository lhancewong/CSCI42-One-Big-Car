import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_big_car/global/global.dart';

const List<String> items = [
  'Single Ride',
  '1 Day',
  '1 Week',
  '1 Month',
  '1 Semester',
  '1 Year'
];

const List<String> days = ['M', 'T', 'W', 'TH', 'F', 'S'];

class SingleBooking extends StatefulWidget {
  const SingleBooking({super.key});

  @override
  State<SingleBooking> createState() => _SingleBookingState();
}

class _SingleBookingState extends State<SingleBooking> {
  String? dropdownValue;
  DateTime? arrivalTime;
  DateTime? departureTime;
  Map data = {};
  Map<String, dynamic> bookingMap = {};
  List sourceData = [];
  List destinationData = [];
  Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
  Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);
  var dayColors = List.filled(6, const Color.fromRGBO(243, 243, 243, 1));
  var dayTextColors = List.filled(6, Colors.black);
  bool isDaySelected = false;

  TextEditingController TextController1 = TextEditingController();
  TextEditingController TextController2 = TextEditingController();
  TextEditingController TextController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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

    InputDecoration dateFieldInputDeco(String text, IconData? icon) {
      return InputDecoration(
        labelText: text,
        labelStyle: const TextStyle(fontSize: 14),
        suffixIcon: Icon(icon, color: obcBlue),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: obcBlue,
            width: 3.0,
          ),
        ),
      );
    }

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
                const EdgeInsets.only(top: 65, bottom: 40, left: 40, right: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                
                Text('Booking Page', style: titleStyle)
              ],
            ),
          ),
          //White BG with Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.85,
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
                    DropdownButton<String>(
                      hint: Text("Choose Carpool Arrangement",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          )),
                      value: dropdownValue,
                      underline: Container(color: obcBlue),
                      isExpanded: true,
                      icon: Icon(
                        Icons.expand_more,
                        color: obcBlue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          bookingMap.clear();
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: dropdownValue == items[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Select a date textfield
                          DateTimeFormField(
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            firstDate: DateTime.now(),
                            onDateSelected: (DateTime value) {
                              bookingMap["datetime"] = value;
                            },
                            decoration: dateFieldInputDeco(
                                "Select a Date and Time", Icons.event_note),
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
                    Visibility(
                      visible:
                          dropdownValue != items[0] && dropdownValue != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Select Ateneo Arrival and Departure Time/s",
                            style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DateTimeFormField(
                                  mode: DateTimeFieldPickerMode.time,
                                  firstDate: DateTime.now(),
                                  onDateSelected: (DateTime value) {
                                    dropdownValue == items[1]
                                        ? bookingMap["arrival time"] = value
                                        : arrivalTime = value;
                                  },
                                  decoration: dateFieldInputDeco(
                                      "Arrival", Icons.access_time),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DateTimeFormField(
                                  mode: DateTimeFieldPickerMode.time,
                                  firstDate: DateTime.now(),
                                  onDateSelected: (DateTime value) {
                                    dropdownValue == items[1]
                                        ? bookingMap["departure time"] = value
                                        : departureTime = value;
                                  },
                                  decoration: dateFieldInputDeco(
                                      "Departure", Icons.access_time),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Visibility(
                            visible: dropdownValue != items[1],
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 6; i++)
                                    SizedBox(
                                      width: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            padding:
                                                const MaterialStatePropertyAll(
                                                    EdgeInsets.zero),
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    dayColors[i]),
                                            foregroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Colors.black),
                                            /* shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: BorderSide(color: obcGrey))), */
                                          ),
                                          child: Text(days[i],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: dayTextColors[i],
                                              )),
                                          onPressed: () {
                                            setState(() {
                                              if (dayColors[i] == obcGrey) { // fix para updates based on inputted times for each day
                                                print(arrivalTime);
                                                if (arrivalTime == null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please enter an Arrival Time in Ateneo");
                                                } else if (departureTime ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please enter a Departure Time from Ateneo");
                                                } else {
                                                  dayColors[i] = obcBlue;
                                                  dayTextColors[i] =
                                                      Colors.white;
                                                  isDaySelected = true;
                                                  bookingMap[days[i]] = {
                                                    "arrival time": arrivalTime,
                                                    "departure time": departureTime,
                                                  };

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Saved ${days[i]} schedule.");
                                                }
                                              } else {
                                                dayColors[i] = obcGrey;
                                                dayTextColors[i] = Colors.black;

                                                bookingMap.removeWhere(
                                                    (key, value) =>
                                                        key == days[i]);

                                                Fluttertoast.showToast(
                                                    msg: "Removed ${days[i]}");
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                ]),
                          ),
                          const SizedBox(height: 20),
                          DateTimeFormField(
                            mode: DateTimeFieldPickerMode.date,
                            firstDate: DateTime.now(),
                            onDateSelected: (DateTime value) {
                              dropdownValue == items[1]
                                  ? bookingMap["date"] = value
                                  : bookingMap["start date"] = value;
                            },
                            decoration: dateFieldInputDeco(
                                dropdownValue == items[1]
                                    ? "Select a Date"
                                    : "Arrangement Start",
                                Icons.event_note),
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: dropdownValue != items[1],
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.date,
                              firstDate: DateTime.now(),
                              onDateSelected: (DateTime value) {
                                bookingMap["end date"] = value;
                              },
                              decoration: dateFieldInputDeco(
                                  "Arrangement End", Icons.event_note),
                            ),
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
                  } else if (dropdownValue == null) {
                    Fluttertoast.showToast(
                        msg: "Please choose a Carpool Arrangement.");
                  } else if (bookingMap["datetime"] == null &&
                      dropdownValue == items[0]) {
                    Fluttertoast.showToast(
                        msg: "Please select a Date and Time.");
                  } else if (bookingMap["arrival time"] == null &&
                      dropdownValue == items[1]) {
                    Fluttertoast.showToast(
                        msg: "Please select an Arrival Time in Ateneo");
                  } else if (bookingMap["departure time"] == null &&
                      dropdownValue == items[1]) {
                    Fluttertoast.showToast(
                        msg: "Please select a Departure Time from Ateneo");
                  } else if (bookingMap["date"] == null &&
                      dropdownValue == items[1]) {
                    Fluttertoast.showToast(msg: "Please select a Date");
                  } else if (bookingMap["start date"] == null &&
                      dropdownValue != null &&
                      dropdownValue != items[0] &&
                      dropdownValue != items[1]) {
                    Fluttertoast.showToast(
                        msg:
                            "Please select a Start Date for your Carpool Arrangement");
                  } else if (bookingMap["end date"] == null &&
                      dropdownValue != null &&
                      dropdownValue != items[0] &&
                      dropdownValue != items[1]) {
                    Fluttertoast.showToast(
                        msg:
                            "Please select an End Date for your Carpool Arrangement");
                  } else if (bookingMap["end date"] == null &&
                      dropdownValue != null &&
                      dropdownValue != items[0] &&
                      dropdownValue != items[1]) {
                    Fluttertoast.showToast(
                        msg:
                            "Please select at least 1 day for your Carpool Arrangement");
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

                    if (dropdownValue == items[0]) {
                      bookingMap.addAll({
                        "notes": TextController3.text,
                      });
                    }

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
                    bookingRef
                        .child(currentFirebaseUser!.uid)
                        .update(bookingMap);

                    Fluttertoast.showToast(
                        msg: "Booking Information has been saved.");
                    Navigator.of(context).pushNamed('/RideSearch');
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
