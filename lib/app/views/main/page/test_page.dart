import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

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
  int _batteryLevel = 0;

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
            Text('Battery Level: $_batteryLevel%'),
            ElevatedButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: Text('리마인더 테스트 페이지'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}