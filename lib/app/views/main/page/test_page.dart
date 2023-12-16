import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final Battery _battery = Battery();
  String _testLabel = "";
  Location location = Location();
  late LocationData currentLocation;

  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longtitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Battery Level: $_testLabel%'),
            ElevatedButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: Text('배터리 확인'),
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '위도 (ex : 37.51227)',
              ),
            ),
            TextField(
              controller: _longtitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '경도 (ex : 127.0954)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _getDistanceInfo();
              },
              child: Text('현재 위치와의 거리 차이'),
            ),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: Text('현재 위치 (위도 경도)'),
            ),
            ElevatedButton(
              onPressed: () {
                _getWifiInfo();
              },
              child: Text('와이파이 이름'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      _testLabel = batteryLevel.toString();
    });
  }

  Future<void> _getWifiInfo() async {
    final info = NetworkInfo();
    var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    var wifiIP = await info.getWifiIP(); // 192.168.1.1
    var wifiName = await info.getWifiName(); // FooNetwork
    debugPrint(wifiName);
    setState(() {
      _testLabel = "와이파이 이름 : "+wifiName.toString();
    });
  }

  Future<void> _getDistanceInfo() async {
    /**
     * 현재 위치와 EditText사이의 거리 차이 구하기
     */
    var langtitude = double.parse(_latitudeController.text);
    var longtitude = double.parse(_longtitudeController.text);
    LocationData locationData = await getLocationData();
    var currentLangtitude = locationData.latitude;
    var currentLongtitude = locationData.longitude;

    // final distance = await Geolocator.distanceBetween(37.51227, 127.0954, langtitude, longtitude);
    final distance = await Geolocator.distanceBetween(currentLangtitude!, currentLongtitude!, langtitude, longtitude);

    Fluttertoast.showToast(
        msg: '거리 차이 : '+distance.toString()+'미터',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        fontSize: 16.0
    );

    // debugPrint(distance.toString());
    // setState(() {
    //   _testLabel = distance.toString();
    // });
  }

  Future<void> _getCurrentLocation() async {
    // await location.requestPermission();
    // try {
    //   currentLocation = await location.getLocation();
    //   _testLabel = "test asdf..";
    //   // debugPrint(currentLocation.toString());
    // } catch (e) {
    //   debugPrint("로케이션 오류 발생");
    // }
    // setState(() {});
    LocationData locationData = await getLocationData();
    setState(() {
      _testLabel = locationData.toString();
    });
  }

  Future<LocationData> getLocationData() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // 서비스가 가능한지 확인하는 코드
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future<LocationData>.value(null as LocationData);
      }
    }

    // 사용자의 허락이 떨어졌는지 확인하는 코드
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // todo : 수정 필요 (임시로 null값 리턴)
        return Future<LocationData>.value(null as LocationData);
      }
    }

    locationData = await location.getLocation();
    debugPrint("로케이션 테스트 : "+locationData.toString());
    return locationData;
  }


}