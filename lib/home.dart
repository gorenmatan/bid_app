import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  final String title = "Maps Demo";

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  static LatLng _initialPosition;
  static LatLng _currentPosition = _initialPosition;
  final Set<Marker> _markers = {};
  String _address = "";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }


  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: LatLng(position.latitude, position.longitude),
      ));
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }




  _onTapHandler(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
      ));
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  _initialPosition == null ?
        Container(child: Center(child:Text('loading map..', style: TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),),),)
            :Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.4746,
              ),
              markers: Set.from(_markers),
              onTap: _onTapHandler,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              compassEnabled: false,
              myLocationButtonEnabled: true,

            ),
            Positioned(
              left: 15.0,
              top: 15.0,
              child: Icon(
                Icons.clear,
                size: 30.0,
                color: Colors.black54,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              right: 30.0,
              left: 30.0,
              child: Center(
                child: TextFormField(
                  style: TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 24.0,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "WorkSansLight",
                      fontSize: 16.0,
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: _address == "" ? "search location" : _address,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 25.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final coordinates = new Coordinates(
                            _currentPosition.latitude, _currentPosition.longitude);
                        var addresses = await Geocoder.local.findAddressesFromCoordinates(
                            coordinates);
                        var first = addresses.first;
                        setState(() {
                          _address = "${first.addressLine}";
                        });

                      },
                      child: Icon(Icons.check, size: 36.0),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
