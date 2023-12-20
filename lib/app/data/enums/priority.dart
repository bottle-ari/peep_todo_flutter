import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

enum Priority {
  unspecified('중요도 미선택', Palette.peepGray400),
  low('중요도 낮음', Palette.peepGreen),
  medium('중요도 보통', Palette.peepYellow400),
  high('중요도 높음', Palette.peepRed);

  final String PriorityString;
  final Color PriorityColor;
  const Priority(this.PriorityString, this.PriorityColor);
}
