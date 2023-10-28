import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final RxInt _selectedIndexController = 0.obs;

  updateSelectedIndex(int index) => _selectedIndexController(index);

  int get selectedIndex => _selectedIndexController.value;
}
