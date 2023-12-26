import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Palette.peepYellow400,
      ),
    );
  }
}