import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class RideList extends StatefulWidget {
  const RideList({super.key});

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
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

    Widget buildListItemv2(BuildContext context, rideInfo) {
      String rideHeadName = rideInfo['head']['name'];
      String rideSourceName = rideInfo['source']['title'];
      String rideDestinationName = rideInfo['destination']['title'];
      return ListTile(
        title: ElevatedButton(
          style: listButtonStyle,
          onPressed: () async {
            OverlayState? overlayState = Overlay.of(context);
            late OverlayEntry overlayEntry;
            overlayEntry = OverlayEntry(builder: ((context) {
              return Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.black.withOpacity(0.5),
                ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.6,
                  decoration: BoxDecoration(
                    color: obcGrey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: obcGrey,
                        child: IconButton(
                          onPressed: () async {
                            overlayEntry.remove();
                          },
                          icon: const Icon(Icons.close),
                          iconSize: 25,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: screenHeight * 0.6,
                          decoration: BoxDecoration(
                            color: obcBlue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.55,
                              child: RichText(
                                text: TextSpan(
                                    text: "Rider:\n",
                                    style: overlaysmalltextStyle,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: rideHeadName,
                                        style: overlaybigtextStyle,
                                      )
                                    ]),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.55,
                              child: RichText(
                                text: TextSpan(
                                    text: "Meeting point @\n",
                                    style: overlaysmalltextStyle,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: rideSourceName,
                                        style: overlaybigtextStyle,
                                      )
                                    ]),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.55,
                              child: RichText(
                                text: TextSpan(
                                    text: "Drop-off point\n",
                                    style: overlaysmalltextStyle,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: rideDestinationName,
                                        style: overlaybigtextStyle,
                                      )
                                    ]),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await user.reload();
                        }
                        String? passengerUID = user!.uid.toString();
                        final snapshot = await FirebaseDatabase.instance
                            .ref()
                            .child('users/$passengerUID/first name')
                            .get();
                        var passengerID = {
                          "passenger": passengerUID,
                          "name": snapshot.value.toString(),
                        };
                        overlayEntry.remove();
                        DatabaseReference passengerRef =
                            FirebaseDatabase.instance.ref().child("bookings");
                        passengerRef
                            .child(passengerUID)
                            .child("passenger")
                            .update(passengerID);
                      },
                      style: confirmBookingButton,
                      child: const Text("Confirm Booking",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              fontFamily: 'Nunito',
                              color: Colors.white)),
                    ),
                  ),
                )
              ]);
            }));

            overlayState?.insert(overlayEntry);
            /* await Future.delayed(Duration(seconds: 3));
            overlayEntry.remove(); */
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('time'),
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
                      text: "TODAY'S \n RIDES\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 35,
                        fontFamily: 'Nunito',
                        color: obcGrey,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                            text: dateInfo,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20))
                      ]),
                  textAlign: TextAlign.center,
                )),
          ),
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
