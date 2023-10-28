import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';

class PeepTodoBase extends StatelessWidget {
  const PeepTodoBase({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class PeepSubTodoBaseItem extends StatelessWidget {
  const PeepSubTodoBaseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [PeepCheckButton(), ],);
  }

}