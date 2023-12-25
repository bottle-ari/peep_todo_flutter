import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/dairy_edit_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/peep_subpage_appbar.dart';

class DiaryEditPage extends BaseView<DiaryEditController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '일기 작성',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                },
                child: PeepIcon(
                  Iconsax.trash,
                  size: AppValues.baseIconSize,
                  color: Palette.peepRed,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }

}