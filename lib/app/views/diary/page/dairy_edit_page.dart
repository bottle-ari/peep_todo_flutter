import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/dairy_edit_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/quill_toolbar_enum.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/diary/widget/peep_image_preview.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/peep_subpage_appbar.dart';
import '../../common/popup/peep_confirm_popup.dart';
import '../widget/custom_checkbox_builder.dart';
import '../widget/peep_checked_todo.dart';

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
                  Get.dialog(PeepConfirmPopup(
                      icon: Iconsax.trashBold,
                      text: '삭제',
                      confirmText: '확인',
                      hintText: '일기 내용이 모두 삭제 돼요',
                      hintColor: Palette.peepRed,
                      color: Palette.peepRed,
                      func: () {
                        controller.clearText();
                      }));
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
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: PeepImagePreview(
              selectedDate: controller.getSelectedDate(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: PeepCheckedTodo(
              selectedDate: controller.getSelectedDate(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: PeepCheckedTodoFoldDivider(
              selectedDate: controller.getSelectedDate(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.screenPadding,
                  vertical: AppValues.verticalMargin),
              child: QuillEditor.basic(
                focusNode: controller.focusNode,
                configurations: QuillEditorConfigurations(
                  placeholder: "${controller.date}의 일기를 입력하세요!",
                  controller: controller.quillController,
                  readOnly: false,
                  autoFocus: true,
                  customStyles: DefaultStyles(
                    lists: DefaultListBlockStyle(
                      PeepTextStyle.regularM().copyWith(
                          fontFamily: Get.textTheme.bodyMedium?.fontFamily ??
                              "Pretendard"),
                      VerticalSpacing(4.h, 4.h),
                      VerticalSpacing(4.h, 4.h),
                      const BoxDecoration(),
                      CustomCheckboxBuilder(),
                    ),
                    paragraph: DefaultTextBlockStyle(
                        PeepTextStyle.regularM().copyWith(
                            fontFamily: Get.textTheme.bodyMedium?.fontFamily ??
                                "Pretendard"),
                        VerticalSpacing(2.h, 2.h),
                        VerticalSpacing(2.h, 2.h),
                        const BoxDecoration()),
                    code: DefaultTextBlockStyle(
                        PeepTextStyle.regularM(color: Palette.peepPriorityLow)
                            .copyWith(
                                fontFamily:
                                    Get.textTheme.bodyMedium?.fontFamily ??
                                        "Pretendard"),
                        VerticalSpacing(2.h, 2.h),
                        VerticalSpacing(2.h, 2.h),
                        BoxDecoration(
                            color: Palette.peepGray100,
                            borderRadius:
                                BorderRadius.circular(AppValues.smallRadius))),
                  ),
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('ko'),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: _QuillToolBar(
                controller: controller,
              )),
        ],
      ),
    );
  }
}

class _QuillToolBar extends StatelessWidget {
  final DiaryEditController controller;

  const _QuillToolBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: controller.toolbarHeight.value,
        decoration: BoxDecoration(
          color: Palette.peepWhite,
          boxShadow: [
            BoxShadow(
              color: Palette.peepBlack.withOpacity(AppValues.shadowOpacity),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppValues.baseRadius),
              topLeft: Radius.circular(AppValues.baseRadius)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppValues.horizontalMargin,
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppValues.innerMargin,
              ),
              SizedBox(
                height: 48.h,
                child: QuillToolbar(
                  configurations: const QuillToolbarConfigurations(
                      sharedConfigurations: QuillSharedConfigurations(
                        locale: Locale('ko'),
                      ),
                      buttonOptions: QuillSimpleToolbarButtonOptions()),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        QuillToolbarClearFormatButton(
                          controller: controller.quillController,
                          options: const QuillToolbarBaseButtonOptions(
                            iconData: PeepIconData.erase,
                          ),
                        ),
                        const VerticalDivider(
                          color: Palette.peepGray200,
                        ),
                        QuillToolbarCustomButton(
                          controller: controller.quillController,
                          options: QuillToolbarCustomButtonOptions(
                              icon: Row(
                                children: [
                                  const Icon(PeepIconData.text),
                                  SizedBox(
                                    width: AppValues.innerMargin,
                                  ),
                                  Text(controller.fontSizeText.value),
                                ],
                              ),
                              onPressed: () =>
                                  controller.onTapFontSizeButton()),
                        ),
                        QuillToolbarCustomButton(
                          controller: controller.quillController,
                          options: QuillToolbarCustomButtonOptions(
                              icon: Icon(
                                PeepIconData.pen,
                                color: controller.fontColor.value,
                              ),
                              onPressed: () =>
                                  controller.onTapFontColorButton()),
                        ),
                        QuillToolbarCustomButton(
                          controller: controller.quillController,
                          options: QuillToolbarCustomButtonOptions(
                              icon: Icon(
                                PeepIconData.brush,
                                color: controller.fontBackgroundColor.value ==
                                        Palette.peepWhite
                                    ? Palette.peepBlack
                                    : controller.fontBackgroundColor.value,
                              ),
                              onPressed: () =>
                                  controller.onTapFontBackgroundColorButton()),
                        ),
                        QuillToolbarToggleStyleButton(
                          controller: controller.quillController,
                          attribute: Attribute.bold,
                          options: const QuillToolbarToggleStyleButtonOptions(
                              iconData: PeepIconData.textBold),
                        ),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.italic,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.textItalic)),
                        const VerticalDivider(
                          color: Palette.peepGray200,
                        ),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.unchecked,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.checkBox)),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.ul,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.list)),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.ol,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.listNum)),
                        QuillToolbarIndentButton(
                          controller: controller.quillController,
                          isIncrease: true,
                          options: const QuillToolbarIndentButtonOptions(
                              iconData: PeepIconData.arrowRight),
                        ),
                        QuillToolbarIndentButton(
                          controller: controller.quillController,
                          isIncrease: false,
                          options: const QuillToolbarIndentButtonOptions(
                              iconData: PeepIconData.arrowLeft),
                        ),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.codeBlock,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.codeBlock)),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.blockQuote,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.quote)),
                        const VerticalDivider(
                          color: Palette.peepGray200,
                        ),
                        QuillToolbarHistoryButton(
                          controller: controller.quillController,
                          isUndo: true,
                          options: const QuillToolbarHistoryButtonOptions(
                              iconData: PeepIconData.undo),
                        ),
                        QuillToolbarHistoryButton(
                          controller: controller.quillController,
                          isUndo: false,
                          options: const QuillToolbarHistoryButtonOptions(
                              iconData: PeepIconData.redo),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppValues.innerMargin,
              ),
              if (controller.quillToolbarState.value == QuillToolbarEnum.size)
                _QuillFontSizeSelector(
                  controller: controller,
                )
              else if (controller.quillToolbarState.value ==
                  QuillToolbarEnum.color)
                _QuillFontColorSelector(
                  controller: controller,
                )
              else if (controller.quillToolbarState.value ==
                  QuillToolbarEnum.background)
                _QuillFontBackgroundColorSelector(
                  controller: controller,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _QuillFontSizeSelector extends StatelessWidget {
  final DiaryEditController controller;

  const _QuillFontSizeSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            color: Palette.peepGray100),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(-1);
                    },
                    child: Text(
                      'h1',
                      style: controller.fontSizeText.value == "h1"
                          ? PeepTextStyle.boldM(color: Palette.peepBlack)
                          : PeepTextStyle.regularM(color: Palette.peepBlack),
                    )),
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(-2);
                    },
                    child: Text(
                      'h2',
                      style: controller.fontSizeText.value == "h2"
                          ? PeepTextStyle.boldM(color: Palette.peepBlack)
                          : PeepTextStyle.regularM(color: Palette.peepBlack),
                    )),
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(-3);
                    },
                    child: Text(
                      'h3',
                      style: controller.fontSizeText.value == "h3"
                          ? PeepTextStyle.boldM(color: Palette.peepBlack)
                          : PeepTextStyle.regularM(color: Palette.peepBlack),
                    )),
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(12);
                    },
                    child: Text(
                      '작게',
                      style: controller.fontSizeText.value == "작게"
                          ? PeepTextStyle.boldXS(color: Palette.peepBlack)
                          : PeepTextStyle.regularXS(color: Palette.peepBlack),
                    )),
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(16);
                    },
                    child: Text(
                      '보통',
                      style: controller.fontSizeText.value == "보통"
                          ? PeepTextStyle.boldM(color: Palette.peepBlack)
                          : PeepTextStyle.regularM(color: Palette.peepBlack),
                    )),
                TextButton(
                    onPressed: () {
                      controller.updateFontSizeText(20);
                    },
                    child: Text(
                      '크게',
                      style: controller.fontSizeText.value == "크게"
                          ? PeepTextStyle.boldL(color: Palette.peepBlack)
                          : PeepTextStyle.regularL(color: Palette.peepBlack),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuillFontColorSelector extends StatelessWidget {
  final DiaryEditController controller;

  const _QuillFontColorSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 90.h,
        child: GridView.count(
          crossAxisCount: 6,
          childAspectRatio: 4 / 3,
          children: [
            Center(
              child: _PeepColorPickerItem(
                color: Palette.peepBlack,
                selected: Palette.peepBlack == controller.fontColor.value,
                onTap: () {
                  controller.updateFontColor(null);
                },
              ),
            ),
            for (var item in controller.paletteController.getDefaultPalette())
              Center(
                child: _PeepColorPickerItem(
                  color: item.color,
                  selected: item.color == controller.fontColor.value,
                  onTap: () {
                    controller.updateFontColor(item.color);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _QuillFontBackgroundColorSelector extends StatelessWidget {
  final DiaryEditController controller;

  const _QuillFontBackgroundColorSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 90.h,
        child: GridView.count(
          crossAxisCount: 6,
          childAspectRatio: 4 / 3,
          children: [
            Center(
              child: _PeepColorPickerItem(
                color: Palette.peepWhite,
                selected:
                    Palette.peepWhite == controller.fontBackgroundColor.value,
                onTap: () {
                  controller.updateFontBackgroundColor(null);
                },
              ),
            ),
            for (var item in controller.paletteController.getDefaultPalette())
              Center(
                child: _PeepColorPickerItem(
                  color: item.color,
                  selected: item.color == controller.fontBackgroundColor.value,
                  onTap: () {
                    controller.updateFontBackgroundColor(item.color);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PeepColorPickerItem extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _PeepColorPickerItem(
      {required this.color, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      child: Container(
        width: AppValues.largeIconSize,
        height: AppValues.largeIconSize,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: color == Palette.peepWhite
                  ? Palette.peepGray300
                  : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              PeepIcon(
                Iconsax.check,
                size: AppValues.smallIconSize,
                color: color == Palette.peepWhite
                    ? Palette.peepGray400
                    : Palette.peepWhite,
              ),
          ],
        ),
      ),
    );
  }
}
