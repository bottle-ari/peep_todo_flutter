import 'package:get/get.dart';

import '../../data/services/pref_service.dart';

class PrefController extends GetxController {
  final PrefService _service = Get.put(PrefService());

  final RxMap<String, String> _data = <String, String>{}.obs;

  Map<String, String> get data => _data;

  void saveData(String key, String value) async {
    await _service.saveData(key, value);
    await updateData(key);
  }

  Future<void> updateData(String key) async {
    var value = await _service.loadData(key) ?? '';
    _data[key] = value;

    update();
  }
}
