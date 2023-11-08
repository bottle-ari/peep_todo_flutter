import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

import 'package:peep_todo_flutter/app/theme/app_values.dart';

class DropdownMenuItemData {
  //
  final String value;
  final PeepIcon icon;
  final String text;

  DropdownMenuItemData(this.value, this.icon, this.text);
}

class PeepDropdownMenu extends StatelessWidget {
  final List<DropdownMenuItemData> menuItems;
  final Function(String) onMenuItemSelected;

  const PeepDropdownMenu({
    Key? key,
    required this.menuItems,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: PeepIcon(
        Iconsax.more,
        size: AppValues.baseIconSize,
        color: Palette.peepGray500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppValues.smallRadius), // 원하는 모서리 둥글기 설정
      ),
      onSelected: onMenuItemSelected,
      itemBuilder: (BuildContext context) {
        return menuItems
            .map((item) => PopupMenuItem<String>(
                  value: item.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            item.icon,
                            SizedBox(width: AppValues.horizontalMargin),
                            Text(item.text,
                                style: PeepTextStyle.regularXS(
                                    color: Palette.peepBlack)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList();
      },
    );
  }
}
