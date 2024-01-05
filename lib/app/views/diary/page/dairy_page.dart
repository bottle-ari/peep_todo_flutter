import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
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
import '../../../utils/peep_calendar_util.dart';
import '../widget/custom_checkbox_builder.dart';
import '../widget/peep_checked_todo.dart';

class DiaryPage extends BaseView<DiaryPageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget? floatingActionButton() {
    return Obx(
      () => FloatingActionButton(
        onPressed: () {
          controller.createDiary();
          Get.toNamed(AppPages.DIARY_EDIT);
        },
        shape: const CircleBorder(),
        backgroundColor: controller.paletteController.getPriorityColor(),
        child: PeepIcon(
          Iconsax.edit,
          size: AppValues.baseIconSize,
          color: Palette.peepWhite,
        ),
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
                child: PageView.builder(
                  itemCount:
                      calendarEndDate.difference(calendarStartDate).inDays,
                  controller: controller.pageController,
                  onPageChanged: (int index) {
                    controller.onPageChange(getDateFromPageIndex(index));
                  },
                  itemBuilder: (BuildContext context, int index) {
                    DateTime currentDate = getDateFromPageIndex(index);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          _DiaryImage(
                            controller: controller,
                            selectedDate: currentDate,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppValues.screenPadding),
                            child: PeepCheckedTodo(
                              selectedDate: currentDate,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppValues.screenPadding),
                            child: PeepCheckedTodoFoldDivider(
                              selectedDate: currentDate,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppValues.screenPadding),
                            child: _DiaryText(
                              controller: controller,
                              selectedDate: currentDate,
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    );
                  },
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
  final DateTime selectedDate;

  const _DiaryImage({required this.controller, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.getImagePath(selectedDate).isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: CarouselSlider(
                    items: [
                      for (var imagePath
                          in controller.getImagePath(selectedDate))
                        AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            ))
                    ],
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      onPageChanged:
                          (int page, CarouselPageChangedReason reason) {},
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                )
              : SizedBox(
                  height: AppValues.verticalMargin,
                ),
        ),
      ],
    );
  }
}

class _DiaryText extends StatelessWidget {
  final DiaryPageController controller;
  final DateTime selectedDate;

  const _DiaryText({required this.controller, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            placeholder: "일기가 없어요. 일기를 작성해주세요!",
            controller: controller.quillController[
                    DateFormat('yyyyMMdd').format(selectedDate)] ??
                QuillController.basic(),
            readOnly: true,
            autoFocus: false,
            showCursor: false,
            customStyles: DefaultStyles(
              lists: DefaultListBlockStyle(
                PeepTextStyle.regularM().copyWith(
                    fontFamily:
                        Get.textTheme.bodyMedium?.fontFamily ?? "Pretendard"),
                VerticalSpacing(4.h, 4.h),
                VerticalSpacing(4.h, 4.h),
                const BoxDecoration(),
                CustomCheckboxBuilder(),
              ),
              paragraph: DefaultTextBlockStyle(
                  PeepTextStyle.regularM().copyWith(
                      fontFamily:
                          Get.textTheme.bodyMedium?.fontFamily ?? "Pretendard"),
                  VerticalSpacing(2.h, 2.h),
                  VerticalSpacing(2.h, 2.h),
                  const BoxDecoration()),
              code: DefaultTextBlockStyle(
                  PeepTextStyle.regularM(color: Palette.peepPriorityLow)
                      .copyWith(
                          fontFamily: Get.textTheme.bodyMedium?.fontFamily ??
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
      );
    });
  }
}
