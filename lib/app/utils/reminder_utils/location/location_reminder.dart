
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../reminder_interface.dart';

class LocationReminder implements ReminderInterface {
  @override
  String alarmMessage = "특정 위치 근처 도착";

  double langtitude = 0.0;
  double longtitude = 0.0;
  double meterBoundary = 0.0; // 몇 미터 이내에 도착하면 알람이 울릴지


  LocationReminder(double langtitude, double longtitude, double meterBoundary) {
    this.langtitude = langtitude;
    this.longtitude = longtitude;
    this.meterBoundary = meterBoundary;
  }

  @override
  String getAlarmMessage() {
    return alarmMessage;
  }

  // 나중에 LocationUtils로 추출하기
  static Future<LocationData> getCurrentLocationData() async {
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
    // debugPrint("로케이션 테스트 : "+locationData.toString());
    return locationData;
  }


  @override
  Future<bool> isTimeToAlarm() async {
    var langtitude = this.langtitude;
    var longtitude = this.longtitude;
    LocationData locationData = await getCurrentLocationData();
    var currentLangtitude = locationData.latitude;
    var currentLongtitude = locationData.longitude;

    // final distance = await Geolocator.distanceBetween(37.51227, 127.0954, langtitude, longtitude);
    final distance = await Geolocator.distanceBetween(
        currentLangtitude!, currentLongtitude!, langtitude, longtitude);
    // 참고로 실제 핸드폰이 아니라 에뮬레이터로 테스트 하면 위치가 미국으로 나올 수 있음 -> 직접 조정 필요
    Fluttertoast.showToast(
        msg: '테스트 -> 거리차이 : $distance미터',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        fontSize: 16.0
    );
    if (distance <= meterBoundary) {
      return true;
    }
    return false;
  }
}