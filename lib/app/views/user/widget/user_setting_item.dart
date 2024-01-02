import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/provider/database/sharedpref_helper.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class UserSettingItem extends StatelessWidget {
  final Map<String, List<String>> itemList;
  final Map<String, List<String>> itemSubList;

  const UserSettingItem({
    Key? key,
    required this.itemList,
    required this.itemSubList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final group = itemList.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppValues.verticalMargin),
              child: Text(
                group.key,
                style: PeepTextStyle.boldL(color: Palette.peepGray500),
              ),
            ),
            Column(
              children: group.value.asMap().entries.map((entry) {
                int itemIndex = entry.key;
                String item = entry.value;
                String subItem = "";

                if (itemSubList[group.key] != null &&
                    itemSubList[group.key]!.isNotEmpty) {
                  subItem = itemSubList[group.key]![itemIndex];
                }

                return PeepAnimationEffect(
                  onTap: () {
                    Get.toNamed(AppPages.FONTPAGE);
                    },
                  child: Padding(
                    padding: EdgeInsets.all(0.5 * AppValues.horizontalMargin),
                    child: Container(
                      width: AppValues.screenWidth - AppValues.screenPadding * 2,
                      height: AppValues.largeItemHeight,
                      decoration: BoxDecoration(
                        color: Palette.peepGray50,
                        borderRadius: BorderRadius.circular(AppValues.baseRadius),
                        border: Border.all(color: Palette.peepGray100),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item,
                                    style: PeepTextStyle.regularM(
                                        color: Palette.peepBlack),
                                  ),
                                  if (subItem.isNotEmpty)
                                    Text(
                                      subItem,
                                      style: PeepTextStyle.regularXS(
                                          color: Palette.peepGray400),
                                    ),
                                ],
                              ),
                            ),
                            PeepIcon(
                              Iconsax.arrowright,
                              size: AppValues.smallIconSize,
                              color: Palette.peepGray500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
