import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/palette/color_model.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';

import '../provider/database/palette_provider.dart';

class PaletteService extends GetxService {
  final PaletteProvider _provider = PaletteProvider();

  /*
    READ DATA
   */
  Future<List<PaletteModel>> getAllPalette() async {
    final List<Map<String, dynamic>> paletteMaps =
    await _provider.getAllPalette();

    List<PaletteModel> paletteList = [];

    for (var paletteMap in paletteMaps) {
      PaletteModel palette = PaletteModel.fromMap(paletteMap);
      final List<Map<String, dynamic>> colorMaps =
      await _provider.getColors(palette.id);
      palette.colors = colorMaps.map((e) => ColorModel.fromMap(e)).toList();

      paletteList.add(palette);
    }

    return paletteList;
  }

  Future<PaletteModel> getPalette({required String paletteId}) async {
    Map<String, dynamic> paletteMap = await _provider.getPalette(paletteId: paletteId);
    PaletteModel palette = PaletteModel.fromMap(paletteMap);

    final List<Map<String, dynamic>> colorMaps =
    await _provider.getColors(palette.id);

    palette.colors = colorMaps.map((e) => ColorModel.fromMap(e)).toList();

    return palette;
  }

  /*
    Update Functions
   */
  Future<void> updatePalette(PaletteModel palette) async {
    var row = await _provider.updatePalette(palette.toMap());

    log("update $row rows.");
  }
}
