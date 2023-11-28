import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_manage_page_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:peep_todo_flutter/app/views/todo/widget/peep_button_textfield.dart';

class CategoryAddModalController extends GetxController {
  late RxString emoji;
  late Rx<Color> color;
  late RxBool emojiShowing;

  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emoji = "🤔".obs;
    emojiShowing = false.obs;
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0).obs;
  }

  void onTapEmojiPicker() {
    focusNode.unfocus();
    emojiShowing.value = true;
  }
}

class CategoryAddModal extends StatelessWidget {
  final CategoryAddModalController controller;
  final CategoryManagePageController categoryManagePageController;

  const CategoryAddModal({
    super.key,
    required this.categoryManagePageController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    // handle submit(TextField) & onTap(AddButton) event
    void handleAddButtonTap(String text) {
      if (text.trim().isNotEmpty) {
        // return category name, emoji, color
        categoryManagePageController.addCategory(
          controller.emoji.value,
          text,
          controller.color.value,
        );

        Navigator.of(context).pop();
      } else {
        textEditingController.text = "";
      }
    }

    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Palette.peepWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppValues.baseRadius),
              topRight: Radius.circular(AppValues.baseRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppValues.screenPadding,
                    ),
                    Text(
                      '카테고리 추가하기',
                      style: PeepTextStyle.boldL(color: Palette.peepGray400),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppValues.screenPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeepCategoryTextfield(
                            emoji: controller.emoji.value,
                            color: controller.color.value,
                            onTapEmoji: controller.onTapEmojiPicker,
                            onTapAddButton: handleAddButtonTap,
                            onLongPressAddButton: () {},
                            textEditingController: textEditingController,
                            focusNode: controller.focusNode,
                            onTapTextField: () {
                              controller.emojiShowing.value = false;
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: !controller.emojiShowing.value,
                child: SizedBox(
                  height: 300,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.emoji.value = emoji.emoji;
                      controller.emojiShowing.value = false;
                      controller.focusNode.requestFocus();
                    },
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 *
                          (foundation.defaultTargetPlatform == TargetPlatform.iOS
                              ? 1.30
                              : 1.0),
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: Palette.peepWhite,
                      indicatorColor: controller.color.value,
                      iconColor: Palette.peepGray500,
                      iconColorSelected: controller.color.value,
                      backspaceColor: controller.color.value,
                      skinToneDialogBgColor: Palette.peepWhite,
                      skinToneIndicatorColor: Palette.peepGray500,
                      enableSkinTones: true,
                      recentTabBehavior: RecentTabBehavior.RECENT,
                      recentsLimit: 28,
                      noRecents: const Text(
                        '최근에 사용한 이모지가 없어요.',
                        style: TextStyle(fontSize: 16, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      // Needs to be const Widget
                      loadingIndicator: const SizedBox.shrink(),
                      // Needs to be const Widget
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
