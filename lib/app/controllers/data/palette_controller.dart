import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../core/base/base_controller.dart';
import '../../data/model/palette/color_model.dart';
import '../../data/model/palette/palette_model.dart';
import '../../data/services/palette_service.dart';

class PaletteController extends BaseController with PrefController {
  final PaletteService _service = Get.put(PaletteService());
  final keySelectedPaletteInx = 'selectedPaletteIndex';
  final keySelectedColorInx = 'selectedPrimaryColorIndex';

  // Data
  final RxList<PaletteModel> paletteData = <PaletteModel>[].obs;
  late final RxString selectedPalette;
  late final RxInt selectedPrimaryColor;

  PaletteController() {
    selectedPalette =
        (getString(keySelectedPaletteInx) ?? 'sweet_spring_day').obs;
    selectedPrimaryColor = (getInt(keySelectedColorInx) ?? 0).obs;
  }

  @override
  void onInit() {
    super.onInit();
    loadPalette();
  }

  /*
    Init Functions
   */
  void loadPalette() async {
    var data = await _service.getAllPalette();
    paletteData.value = data;
  }

  /*
    Read Functions
   */
  PaletteModel getSelectedPalette() {
    return paletteData
        .firstWhere((element) => element.name == selectedPalette.value);
  }

  int getSelectedPaletteIndex() {
    return paletteData
        .indexWhere((element) => element.name == selectedPalette.value);
  }

  List<ColorModel> getDefaultPalette() {
    if (paletteData.isEmpty) {
      return [
        for (int i = 0; i < 10; i++)
          ColorModel(id: 'temp$i', color: Palette.peepGray300)
      ];
    }

    List<ColorModel> defaultPalette = getSelectedPalette().colors;

    return defaultPalette;
  }

  Color getPriorityColor() {
    const initColor = 'initPriorityColor';

    if (paletteData.isEmpty) {
      final hexColor = getString(initColor);

      if (hexColor == null) {
        saveString(initColor, 'FF6D79');
        return const Color(0xFFFF6D79);
      } else {
        return Color(int.parse("0xFF$hexColor"));
      }
    } else {
      return getSelectedPalette()
          .colors[getSelectedPalette().primaryColor]
          .color;
    }
  }

  /*
    Update Funtions
   */
  Future<void> updatePriorityColor(int index) async {
    List<PaletteModel> newPaletteData = List.from(paletteData);

    var newSelectedPalette = newPaletteData
        .firstWhere((element) => element.name == selectedPalette.value);

    newSelectedPalette.primaryColor = index;

    // 옵저버 데이터 변경
    paletteData.value = newPaletteData;
    selectedPrimaryColor.value = index;

    // DB 저장
    saveInt(keySelectedColorInx, index);
    await _service.updatePalette(newSelectedPalette);
  }

  Future<void> updatePalette(String name) async {
    // 옵저버 데이터 변경
    selectedPalette.value = name;

    // DB 저장
    saveString(keySelectedPaletteInx, name);
  }
}

// List<PaletteModel> newPaletteData = List.from(paletteData);
//
// newPaletteData[selectedPalette.value].primaryColor = index;
//
// // 옵저버 데이터 변경
// paletteData.value = newPaletteData;
// selectedPalette.value = index;
//
// // DB 저장
// saveInt(keySelectedColorInx, index);
// await _service.updatePalette(newPaletteData[selectedPalette.value]);
