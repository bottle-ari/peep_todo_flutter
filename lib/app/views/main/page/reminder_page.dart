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
import 'MapScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReminderPage(),
    );
  }
}

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}


class _ReminderPageState extends State<ReminderPage> {
  // final Battery _battery = Battery();
  Location location = Location();
  late LocationData currentLocation;
  final List<ReminderModel> reminderDataList = []; // This should be your data list

  @override
  void initState() {
    super.initState();
  }


  void loadDBData() {
    // 맨처음 화면 킬 때 리마인더 전부 로딩
    final ReminderController reminderController = Get.put(ReminderController(), permanent: true);
    reminderController.loadReminderData();
    for (int i = 0; i < reminderController.reminderList.length; i++) {
      setState(() {
        reminderDataList.add(reminderController.reminderList[i]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리마인더'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getTabbedPoint(context);
              },
              child: Text('지도로 리마인더 추가'),
            ),
            // Flexible widget to contain the ListView
            Flexible(
              child: ListView.builder(
                itemCount: reminderDataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${reminderDataList[index].name} : ${reminderDataList[index].ifCondition!}"),
                    // Add other list tile properties as needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getTabbedPoint(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );
    if (result == null) {
      print("Null이라 리턴..");
      return;
    }
    double langtitude = result[0];
    double longtitude = result[1];
    final ReminderController reminderController = Get.put(ReminderController(), permanent: true);
    var uuid = const Uuid();
    String newUuid = uuid.v4();
    reminderController.addReminder(
      reminder: ReminderModel(
        id: newUuid,
        name: "Location 리마인더",
        icon: "",
        ifCondition: "{\"pos\": {\"langtitude\" : \"$langtitude\",\"longtitude\":\"$longtitude\"}}", // todo : JSON 등의 형식 하나 정해서 해놓기
        notifyCondition: "",
        pos: reminderController.reminderList.length,
      ),
    );
    // get current date
    var date = DateTime.now();
    // String title = date.toString();
    loadDBData();
    print("리턴값 : $result");
  }






}