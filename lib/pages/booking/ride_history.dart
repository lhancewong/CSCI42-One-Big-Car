import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:one_big_car/global/global.dart';
import 'package:one_big_car/pages/booking/ride_history.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);
    final Size buttonSize = Size(screenWidth * 0.85, screenHeight * 0.1);
    final ButtonStyle listButtonStyle = ElevatedButton.styleFrom(
        fixedSize: buttonSize,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: obcGrey,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    TextStyle overlaysmalltextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      fontFamily: 'Nunito',
      color: Colors.black,
    );
    TextStyle overlaybigtextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 25,
      fontFamily: 'Nunito',
      color: Colors.black,
    );
    final ButtonStyle confirmBookingButton = ElevatedButton.styleFrom(
        fixedSize: buttonSize,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: obcBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    final String dateInfo = formatter.format(DateTime.now());

    final bookingsRef = FirebaseDatabase.instance.ref('bookings');

    String? getData() {
      currentFirebaseUser = fAuth.currentUser;
      if (currentFirebaseUser != null) {
        return "Username can't be empty";
      }

      return null;
    }

    Widget buildListItem(BuildContext context, DataSnapshot rideInfo) {
      String rideSourceName =
          rideInfo.child("source").child("title").value.toString();
      String rideDestinationName =
          rideInfo.child("destination").child("title").value.toString();

      return ListTile(
        title: ElevatedButton(
          style: listButtonStyle,
          onPressed: () async {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('time'),
              Text(
                "FROM: $rideSourceName",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                ),
              ),
              Text(
                "TO: $rideDestinationName",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildListItemv2(BuildContext context, rideInfo) {
      var passengerID = {
        "passenger": currentFirebaseUser!.uid,
      };
      String rideHead = rideInfo['head']['head'];
      String rideSourceName = rideInfo['source']['title'];
      String rideDestinationName = rideInfo['destination']['title'];
      String ridePassenger = rideInfo['passenger']['passenger'];
      return ListTile(
        title: ElevatedButton(
          style: listButtonStyle,
          onPressed: () async {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "FROM: $rideSourceName",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                ),
              ),
              Text(
                "TO: $rideDestinationName",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: obcBlue,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: BackButton(
          color: obcGrey,
        ),
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.08,
                ),
                child: RichText(
                  text: TextSpan(
                    text: "USER \n HISTORY\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                      fontFamily: 'Nunito',
                      color: obcGrey,
                    ),
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          /* Container(
              margin: EdgeInsets.only(top: screenHeight * 0.23),
              child: FirebaseAnimatedList(
                query: bookingsRef,
                itemBuilder: (context, snapshot, animation, index) {
                  if (!snapshot.exists) return const Text('Loading...');
                  return ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 110,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return buildListItem(context, snapshot);
                      });
                },
              )), */
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.23),
            child: StreamBuilder(
                stream: bookingsRef.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    return ListView.builder(
                        itemExtent: 110,
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return buildListItemv2(context, list[index]);
                        });
                  }
                  /* buildListItem(context, list[index])); */
                }),
          )
        ]));
  }
}
