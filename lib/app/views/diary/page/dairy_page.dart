import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';

import '../../../controllers/page/diary_page_controller.dart';
import '../../../core/base/base_view.dart';
import '../widget/custom_checkbox_builder.dart';
import '../widget/peep_checked_todo.dart';

class DiaryPage extends BaseView<DiaryPageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        controller.createDiary();
        Get.toNamed(AppPages.DIARY_EDIT);
      },
      shape: const CircleBorder(),
      backgroundColor: defaultPalette.primaryColor.color,
      child: PeepIcon(
        Iconsax.edit,
        size: AppValues.baseIconSize,
        color: Palette.peepWhite,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: Center(
                    child: PeepAnimationEffect(
                  onTap: () {
                    controller.onMoveToday();
                  },
                  child: Text(
                    DateFormat('MM월 dd일').format(controller.getSelectedDate()),
                    style: PeepTextStyle.boldM(color: Palette.peepGray500),
                  ),
                )),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: PeepMiniCalendar(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _DiaryImage(
                        controller: controller,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding),
                        child: _DiaryText(
                          controller: controller,
                        ),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DiaryImage extends StatelessWidget {
  final DiaryPageController controller;

  const _DiaryImage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.getImagePath().isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: PeepAnimationEffect(
                    onLongPress: () {
                      controller.pickImage();
                    },
                    scale: 0.95,
                    child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.file(
                          File(controller.getImagePath()[0]),
                          fit: BoxFit.cover,
                        )),
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                  child: Stack(children: [
                    const Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Center(
                        child: Divider(
                          color: Palette.peepGray200,
                        ),
                      ),
                    ),
                    Center(
                      child: PeepAnimationEffect(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          color: Palette.peepWhite,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppValues.verticalMargin,
                                horizontal: AppValues.horizontalMargin),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PeepIcon(
                                  Iconsax.image,
                                  size: AppValues.miniIconSize,
                                  color: Palette.peepGray400,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppValues.innerMargin),
                                  child: Text(
                                    "사진 추가",
                                    style: PeepTextStyle.regularXS(
                                        color: Palette.peepGray400),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
        ),
      ],
    );
  }
}

class _DiaryText extends StatelessWidget {
  final DiaryPageController controller;

  const _DiaryText({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            placeholder: "일기가 없어요. 일기를 작성해주세요!",
            controller: controller.quillController.value,
            readOnly: true,
            autoFocus: false,
            showCursor: false,
            customStyles: DefaultStyles(
                lists: DefaultListBlockStyle(
                  PeepTextStyle.regularM(),
                  const VerticalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  const BoxDecoration(),
                  CustomCheckboxBuilder(),
                ),
                color: Palette.peepBlack,
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
      );
    });
  }
}
