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

  // Data
  final RxList<PaletteModel> paletteData = <PaletteModel>[].obs;
  final RxInt selectedPalette = 0.obs; // TODO : Pref에 저장하고 값 초기화 필요

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
  List<ColorModel> getDefaultPalette() {
    if (paletteData.isEmpty) {
      return [
        for (int i = 0; i < 10; i++)
          ColorModel(id: 'temp$i', color: Palette.peepGray300)
      ];
    }

    List<ColorModel> defaultPalette = paletteData[selectedPalette.value].colors;

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
      return paletteData[selectedPalette.value]
          .colors[paletteData[selectedPalette.value].primaryColor]
          .color;
    }
  }

  /*
    Update Funtions
   */
  void updateDefaultColor(int index) async {
    List<PaletteModel> newPaletteData = List.from(paletteData);

    newPaletteData[selectedPalette.value].primaryColor = index;

    // 옵저버 데이터 변경
    paletteData.value = newPaletteData;

    // DB 저장
    await _service.updatePalette(newPaletteData[selectedPalette.value]);
  }
}
