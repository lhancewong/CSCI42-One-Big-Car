import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RideSearch extends StatefulWidget {
  const RideSearch({super.key});

  @override
  State<RideSearch> createState() => _RideSearchState();
}
class _RideSearchState extends State<RideSearch> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.height;
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

    Widget buildListItem(BuildContext context, DocumentSnapshot rideInfo) {
      return ListTile(
        title: Container(
            width: screenWidth * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rideInfo['time']),
                Text(
                  rideInfo['origin'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Nunito',
                    color: Colors.black,
                  ),
                ),
                Text(
                  rideInfo['destination'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Nunito',
                    color: Colors.black,
                  ),
                ),
              ],
            )),
      );
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: BackButton(
          color: obcBlue,
        ),
        body: Stack(
                children: [
                  Padding(
          padding: EdgeInsets.only(
            left: 35,
            top: screenHeight * 0.12,
          ),
          child: Text(
            'Ride Search',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              fontFamily: 'Nunito',
              color: obcBlue,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(40.0),
            height: screenHeight * 0.75,
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.22),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('rides').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return ListView.builder(
                            itemExtent: 100,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) =>
                                buildListItem(context, snapshot.data!.docs[index]));
                }),
          ),
        )]));
  }
}