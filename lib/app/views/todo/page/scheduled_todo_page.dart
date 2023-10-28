import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/icons.dart';
import '../../common/base/basebody.dart';

class ScheduledTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBody(widgetList: [
      Text("Scheduled Todo Page"),
      PeepIcon(Iconsax.calendar, size: 32)
    ]);
  }
}
