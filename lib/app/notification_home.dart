import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'controllers/data/reminder_controller.dart';
import 'utils/reminder_utils/reminder_checker.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    Timer.periodic(Duration(seconds: 5), (Timer t) => checkForNotification());
  }

  Future<void> checkForNotification() async {
    if (await get_state()) {
      showNotification();
    }
  }

  // code20231218140119
  Future<bool> get_state() async {
    // Your implementation here
    var reminderController = Get.put(ReminderController());
    reminderController.loadReminderData();
    var reminders = reminderController.reminderList;
    for (var rm in reminders) {
      String? jsonStr = rm.ifCondition;
      bool isOk = await ReminderChecker.isReminderTime(jsonStr!);
      if (isOk) {
        Fluttertoast.showToast(
            msg: '리마인더 통과',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade300,
            textColor: Colors.black,
            fontSize: 16.0
        );
        return true;
      }
    }

    // Fluttertoast.showToast(
    //     msg: '5초 간격 토스트 메시지',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.grey.shade300,
    //     textColor: Colors.black,
    //     fontSize: 16.0
    // );
    return false; // Placeholder
  }

  Future<void> showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription:'channelDescription',
      importance: Importance.max,
    );
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Title',
      'Test Body',
      generalNotificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notification Demo'),
      ),
      body: Center(
        child: Text('Waiting for notifications...'),
      ),
    );
  }
}