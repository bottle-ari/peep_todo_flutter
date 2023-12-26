import 'dart:ui';

import 'package:peep_todo_flutter/app/data/model/palette/color_model.dart';
import 'package:uuid/uuid.dart';

class PaletteModel {
  final String paletteId;
  final ColorModel primaryColor;
  final List<ColorModel> colors;

  PaletteModel({
    required this.paletteId,
    required this.primaryColor,
    required this.colors,
  });
}

// TODO : default palette 저장해야 함.
var uuid = const Uuid();
String paletteModelColor1Id = uuid.v4();
String paletteModelColor2Id = uuid.v4();
String paletteModelColor3Id = uuid.v4();
String paletteModelColor4Id = uuid.v4();
String paletteModelColor5Id = uuid.v4();
String defaultPaletteId = uuid.v4();

final ColorModel paletteModelColor1 =
    ColorModel(colorId: paletteModelColor1Id, color: const Color(0xFFFF968A));
final ColorModel paletteModelColor2 =
    ColorModel(colorId: paletteModelColor1Id, color: const Color(0xFF88C9CE));
final ColorModel paletteModelColor3 =
    ColorModel(colorId: paletteModelColor1Id, color: const Color(0xFFAA82FF));
final ColorModel paletteModelColor4 =
    ColorModel(colorId: paletteModelColor1Id, color: const Color(0xFFFFD159));
final ColorModel paletteModelColor5 =
    ColorModel(colorId: paletteModelColor1Id, color: const Color(0xFF81E791));

final PaletteModel defaultPalette = PaletteModel(
    paletteId: defaultPaletteId,
    primaryColor: paletteModelColor1,
    colors: [
      paletteModelColor1,
      paletteModelColor2,
      paletteModelColor3,
      paletteModelColor4,
      paletteModelColor5,
    ]);
