import 'package:flutter/material.dart';

class RideList extends StatefulWidget {
  const RideList({super.key});

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);
    final Size buttonSize = Size(screenWidth * 0.45, screenHeight * 0.1);
    final ButtonStyle style = ElevatedButton.styleFrom(
        fixedSize: buttonSize, textStyle: const TextStyle(fontSize: 20));
    final ButtonStyle addButtonStyle = ElevatedButton.styleFrom(
      fixedSize: buttonSize,
      textStyle: const TextStyle(fontSize: 32),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(20),
    );

    return Scaffold(
        backgroundColor: obcBlue,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text("TODAY'S \nRIDES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w800,
                    fontSize: 46,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  )),
              Text('April 20, 2020',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              RideListEntries(
                  time: '8:00',
                  origin: 'FROM: Mandaluyong City',
                  destination: 'TO: Quezon City'),
              RideListEntries(
                  time: '8:00',
                  origin: 'FROM: JSEC',
                  destination: 'TO: Quezon City'),
              RideListEntries(
                  time: '9:00', origin: 'FROM: here', destination: 'TO: urmom'),
              RideListEntries(
                  time: '10:00',
                  origin: 'FROM: diajidjsa',
                  destination: 'TO: jsiajdisaj'),
            ],
          ),
        ));
  }
}

class RideListEntries extends StatefulWidget {
  const RideListEntries({
    super.key,
    required this.time,
    required this.origin,
    required this.destination,
  });

  final String time;
  final String origin;
  final String destination;

  @override
  State<RideListEntries> createState() => _RideListEntriesState();
}

class _RideListEntriesState extends State<RideListEntries> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: screenWidth * 0.85,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.time),
            Text(
              widget.origin,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Nunito',
                color: Colors.black,
              ),
            ),
            Text(
              widget.destination,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Nunito',
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}
