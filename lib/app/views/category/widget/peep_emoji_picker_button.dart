import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/app_values.dart';
import '../../../utils/device_util.dart';

class PeepEmojiPickerButton extends StatelessWidget {
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  final Function(String) onSelected;

  const PeepEmojiPickerButton({
    Key? key,
    required this.emoji,
    required this.onTap,
    required this.color,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: () {
        onTap();
        Get.bottomSheet(_PeepEmojiPicker(
          color: color, onSelected: onSelected,
        ));
      },
      child: emoji == ""
          ? PeepIcon(
              Iconsax.emoji,
              color: Palette.peepYellow400,
              size: 30.w,
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
              child: Text(
                emoji,
                style: PeepTextStyle.regularXL(color: null),
              ),
            ),
    );
  }
}

class _PeepEmojiPicker extends StatelessWidget {
  final Color color;
  final Function(String) onSelected;

  const _PeepEmojiPicker({required this.color, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Palette.peepWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppValues.baseRadius),
                    topRight: Radius.circular(AppValues.baseRadius))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppValues.screenPadding,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                  child: Text(
                    '이모지 선택하기',
                    style: PeepTextStyle.regularL(color: Palette.peepGray400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 270.h,
            child: EmojiPicker(
              onEmojiSelected: (Category? category, Emoji emoji) {
                onSelected(emoji.emoji);
              },
              config: Config(
                columns: 6,
                emojiSizeMax:
                    AppValues.largeIconSize * (isAndroid ? 1.0 : 1.30),
                // Issue: https://github.com/flutter/flutter/issues/28894
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: Palette.peepWhite,
                indicatorColor: color,
                iconColor: Palette.peepGray400,
                iconColorSelected: color,
                backspaceColor: color,
                skinToneDialogBgColor: Palette.peepWhite,
                skinToneIndicatorColor: Palette.peepGray400,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 24,
                noRecents: Text(
                  '최근 사용한 이모지가 없어요',
                  style: PeepTextStyle.regularM(color: Palette.peepGray300),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: const SizedBox.shrink(),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          ),
          Container(
            color: Palette.peepWhite,
            height: 20.h,
          )
        ],
      ),
    );
  }
}
