import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  // final LatLng _targetPoint = LatLng(YourLatitude, YourLongitude); // Replace with your target point coordinates
  // 잠실 : 37.51227, 127.0954
  // todo : 실제 값으로 수정
  final LatLng _targetPoint = LatLng(37.51227, 127.0954); // Replace with your target point coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _targetPoint,
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller = controller;
          });
        },
      ),
    );
  }
}