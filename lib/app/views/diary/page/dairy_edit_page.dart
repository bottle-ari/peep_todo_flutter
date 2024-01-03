import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/dairy_edit_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/quill_toolbar_enum.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';
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
            padding: EdgeInsets.symmetric(
                horizontal: AppValues.screenPadding),
            child: PeepImagePreview(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppValues.screenPadding),
            child: PeepCheckedTodo(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppValues.screenPadding),
            child: PeepCheckedTodoFoldDivider(),
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
                        PeepTextStyle.regularM(),
                        const VerticalSpacing(0, 0),
                        const VerticalSpacing(0, 0),
                        const BoxDecoration(),
                        CustomCheckboxBuilder(),
                      ),
                      paragraph: DefaultTextBlockStyle(
                          PeepTextStyle.regularM(),
                          VerticalSpacing(2.h, 2.h),
                          VerticalSpacing(2.h, 2.h),
                          const BoxDecoration())),
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
                height: 38.h,
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
                        QuillToolbarCustomButton(
                          controller: controller.quillController,
                          options: QuillToolbarCustomButtonOptions(
                              icon: Row(
                                children: [
                                  const Icon(PeepIconData.textClear),
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
                                PeepIconData.colorBox,
                                color: controller.fontColor.value,
                              ),
                              onPressed: () =>
                                  controller.onTapFontColorButton()),
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
                            attribute: Attribute.ul,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.task)),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.ol,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.taskNum)),
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.inlineCode,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.code)),
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
                        QuillToolbarToggleStyleButton(
                            controller: controller.quillController,
                            attribute: Attribute.unchecked,
                            options: const QuillToolbarToggleStyleButtonOptions(
                                iconData: PeepIconData.checkBox)),
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
              Divider(
                color: Palette.peepGray200,
                height: 1.h,
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
      () => SizedBox(
        height: 48.h,
        child: Row(
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
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PeepColorPickerItem(
              color: Palette.peepBlack,
              selected: Palette.peepBlack == controller.fontColor.value,
              onTap: () {
                controller.updateFontColor(null);
              },
            ),
            for (var item in defaultPalette.colors)
              _PeepColorPickerItem(
                color: item.color,
                selected: item.color == controller.fontColor.value,
                onTap: () {
                  controller.updateFontColor(item.color);
                },
              ),
            PeepAnimationEffect(
              //TODO : 테마 넣기
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppValues.horizontalMargin,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.peepGray500),
                    borderRadius: BorderRadius.circular(AppValues.tinyRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppValues.horizontalMargin,
                        vertical: AppValues.innerMargin),
                    child: Text(
                      '테마 변경',
                      style: PeepTextStyle.boldXS(color: Palette.peepGray500),
                    ),
                  ),
                ),
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
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              PeepIcon(
                Iconsax.check,
                size: AppValues.smallIconSize,
                color: Palette.peepWhite,
              ),
          ],
        ),
      ),
    );
  }
}
