import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_big_car/global/map_key.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

final kGoogleApiKey = mapKey;
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _LocationState extends State<Location> {
  final database = FirebaseDatabase.instance.ref();

  static const LatLng sourceLocation = LatLng(14.63989835, 121.078195189384);
  static const LatLng destination = LatLng(14.651494, 121.074615);

  static const CameraPosition _cameraPosition =
      CameraPosition(target: sourceLocation, zoom: 17.0);
  Set<Marker> markersList = {
    const Marker(
      markerId: MarkerId("0"),
      position: sourceLocation,
    ),
  };
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  List<LatLng> polylineCoordinates = [];

  /* Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  } */

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        mapKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          ));
      setState(() {});
    }
  }

  /* @override
  void initState() {
    getPolyPoints();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    Color obcBlue = const Color.fromRGBO(33, 41, 239, 1);
    Color obcGrey = const Color.fromRGBO(243, 243, 243, 1);

    return Scaffold(
        key: homeScaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: obcBlue,
        appBar: AppBar(
          title: const Text('Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Nunito',
                color: Colors.white,
              )),
          backgroundColor: obcBlue,
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController mapController) {
              googleMapController = mapController;
            },
            initialCameraPosition: _cameraPosition,
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                points: polylineCoordinates,
                color: obcBlue,
                width: 6,
              )
            },
            markers: markersList,
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 20,
            child: GestureDetector(
              onTap: _handlePressButton,
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(Icons.location_on,
                      size: 25, color: Theme.of(context).primaryColor),
                  SizedBox(width: 5),
                  //here we show the address on the top
                  Expanded(
                    child: Text(
                      markersList.elementAt(0).infoWindow.title.toString() ==
                              "null"
                          ? "Search Location"
                          : markersList
                              .elementAt(0)
                              .infoWindow
                              .title
                              .toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.search,
                      size: 25,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, <String, Object>{
                  'latitude': markersList.elementAt(0).position.latitude,
                  'longitude': markersList.elementAt(0).position.longitude,
                  'title': markersList.elementAt(0).infoWindow.title.toString(),
                });
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 101, vertical: 10),
                decoration: BoxDecoration(
                    color: obcBlue, borderRadius: BorderRadius.circular(10)),
                child: const Text('Choose Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ]));
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, "ph")]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
