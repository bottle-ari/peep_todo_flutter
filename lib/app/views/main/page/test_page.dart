import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peep_todo_flutter/app/utils/reminder_utils/location/location_reminder.dart';
import 'package:uuid/uuid.dart';
import 'package:peep_todo_flutter/app/controllers/data/reminder_controller.dart';
import 'package:peep_todo_flutter/app/data/model/reminder/reminder_model.dart';

import '../../../utils/reminder_utils/wifi/wifi_info.dart';

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
        title: Text('테스트 페이지'),
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
              child: Text('현재 위치와의 거리 차이 / insert'),
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
    final info = await WifiInfo.getCurrentWifiInfo();
    var wifiBSSID = info.bssid; // 11:22:33:44:55:66
    var wifiIP = info.ip; // 192.168.1.1
    var wifiName = info.wifiName; // FooNetwork
    debugPrint(wifiName);
    setState(() {
      _testLabel = "와이파이 이름 : "+wifiName.toString();
    });
  }

  Future<void> _getDistanceInfo() async {
    /**
     * 현재 위치와 EditText사이의 거리 차이 구하기
     */
    // todo : 숫자 키보드만 되게
    var langtitude = double.parse(_latitudeController.text);
    var longtitude = double.parse(_longtitudeController.text);
    LocationData locationData = await _getCurrentLocation();
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

    // DB를 불러오기
    // 디버그를 위해서 컨트롤러를 여기서 불러오게 임시로 해놓음
    final ReminderController reminderController = Get.put(ReminderController(), permanent: true);
    var uuid = const Uuid();
    String newUuid = uuid.v4();
    reminderController.addReminder(
      reminder: ReminderModel(
        id: newUuid,
        name: "테스트_리마인더_23.12.18",
        icon: "",
        ifCondition: "{\"pos\": {\"langtitude\" : \"$langtitude\",\"longtitude\":\"$longtitude\"}}", // todo : JSON 등의 형식 하나 정해서 해놓기
        notifyCondition: "", // todo : JSON 등의 형식 하나 정해서 해놓기
        pos: reminderController.reminderList.length,
      ),
    );
    debugPrint(distance.toString()); // todo : insert된건지 확인
    // setState(() {
    //   _testLabel = distance.toString();
    // });
  }

  Future<LocationData> _getCurrentLocation() async {
    // await location.requestPermission();
    // try {
    //   currentLocation = await location.getLocation();
    //   _testLabel = "test asdf..";
    //   // debugPrint(currentLocation.toString());
    // } catch (e) {
    //   debugPrint("로케이션 오류 발생");
    // }
    // setState(() {});
    LocationData locationData = await LocationReminder.getCurrentLocationData();
    setState(() {
      _testLabel = locationData.toString();
    });
    return locationData;
  }



}