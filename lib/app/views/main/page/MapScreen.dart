import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
        onTap: _onMapTapped, // Add this line
      ),
    );
  }

  void _onMapTapped(LatLng tappedPoint) {
    double latitude = tappedPoint.latitude;
    double longitude = tappedPoint.longitude;
    print('Tapped Coordinate : ($latitude, $longitude)');
    Fluttertoast.showToast(
        msg: '탭 좌표 : ($latitude, $longitude)',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}
//
// class YesNoDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final VoidCallback onYesPressed;
//   final VoidCallback onNoPressed;
//
//   YesNoDialog({
//     required this.title,
//     required this.content,
//     required this.onYesPressed,
//     required this.onNoPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             onNoPressed();
//           },
//           child: Text('No'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             onYesPressed();
//           },
//           child: Text('Yes'),
//         ),
//       ],
//     );
//   }
// }