import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class PeepTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool autoFocus;
  final Color color;
  final FocusNode focusNode;
  final Function(String) func;

  const PeepTextField(
      {required this.hintText,
      required this.controller,
      required this.inputType,
      required this.autoFocus,
      super.key,
      required this.color,
      required this.func,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      keyboardType: inputType,
      cursorColor: color,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Palette.peepGray300),
        border: InputBorder.none,
      ),
      autofocus: autoFocus,
      onSubmitted: func,
    );
  }
}
