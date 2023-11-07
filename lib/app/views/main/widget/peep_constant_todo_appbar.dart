import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';

class PeepConstantTodoAppbar extends StatelessWidget {
  final List<DropdownMenuItemData> dropdownMenuItems;
  final Function(String) onMenuItemSelected;
  final Function() onTapClipboard;

  const PeepConstantTodoAppbar({
    Key? key,
    required this.dropdownMenuItems,
    required this.onMenuItemSelected,
    required this.onTapClipboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("상시 Todo",
              style: PeepTextStyle.boldXL(color: Palette.peepBlack)),
          Row(
            children: [
              InkWell(
                onTap: onTapClipboard,
                child: PeepIcon(
                  Iconsax.clipboardCheck,
                  size: AppValues.baseIconSize,
                  color: Palette.peepBlack,
                ),
              ),
              SizedBox(width: AppValues.horizontalMargin),
              PeepDropdownMenu(
                menuItems: dropdownMenuItems,
                onMenuItemSelected: onMenuItemSelected,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
