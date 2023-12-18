import 'package:network_info_plus/network_info_plus.dart';

class WifiInfo {
  String? ip;
  String? bssid;
  String? wifiName;

  WifiInfo({required this.ip, required this.bssid, required this.wifiName});

  factory WifiInfo.fromJson(Map<String, dynamic> json) {
    return WifiInfo(
      ip: json['ip'],
      bssid: json['bssid'],
      wifiName: json['wifi_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ip': ip,
    'bssid': bssid,
    'wifi_name': wifiName,
  };

  // make static method -> get current wifi
  static Future<WifiInfo> getCurrentWifiInfo() async {
    final info = NetworkInfo();
    return WifiInfo(
      ip: await info.getWifiIP(),
      bssid: await info.getWifiBSSID(),
      wifiName: await info.getWifiName(),
    );
  }

}