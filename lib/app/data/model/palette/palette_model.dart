import 'dart:ui';

import 'package:peep_todo_flutter/app/data/model/palette/color_model.dart';

class PaletteModel {
  final String id;
  int primaryColor;
  List<ColorModel> colors;

  PaletteModel({
    required this.id,
    required this.primaryColor,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'primary_color': primaryColor,
    };
  }

  factory PaletteModel.fromMap(Map<String, dynamic> map) {
    return PaletteModel(
        id: map['id'],
        primaryColor: map['primary_color'],
        colors: [],);
  }
}
