import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/controllers/widget/peep_date_picker_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/text_style.dart';

class PeepDatePicker extends StatelessWidget {
  final DateTime date;
  final Color color;
  final Function(DateTime) onConfirm;

  const PeepDatePicker(
      {super.key,
      required this.date,
      required this.color,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final PeepDatePickerController controller =
        Get.put(PeepDatePickerController(date: date));

    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(AppValues.baseRadius),
        ),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeepAnimationEffect(
                  onTap: () {
                    controller.toggleIsCalendar();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: PeepIcon(
                      Iconsax.calendar,
                      size: AppValues.mediumIconSize,
                      color: Palette.peepGray500,
                    ),
                  ),
                ),
                PeepAnimationEffect(
                  onTap: () {
                    controller.onMoveToday();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: Text(
                      DateFormat('yyyy년 MM월 dd일')
                          .format(controller.selectedDate.value),
                      style: PeepTextStyle.boldL(color: Palette.peepGray500),
                    ),
                  ),
                ),
                PeepAnimationEffect(
                  onTap: () {
                    onConfirm(controller.selectedDate.value);
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: PeepIcon(
                      Iconsax.checkBold,
                      size: AppValues.mediumIconSize,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            if (controller.isCalendar.value)
              _CalendarPicker(
                controller: controller,
                color: color,
              )
            else
              _DatePicker(controller: controller, color: color,),
            SizedBox(height: AppValues.verticalMargin),
          ],
        ),
      ),
    );
  }
}

Widget customDowBuilder(BuildContext context, DateTime day) {
  final text = DateFormat.E('ko_KR').format(day);
  return Center(
    child: Stack(
      children: [
        Positioned(
          top: 10.h,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              height: 24.w,
              width: 24.w,
              child: Center(
                child: Text(text,
                    style: day.weekday == DateTime.sunday
                        ? PeepTextStyle.regularXS(color: Palette.peepRed)
                        : day.weekday == DateTime.saturday
                            ? PeepTextStyle.regularXS(color: Palette.peepBlue)
                            : PeepTextStyle.regularXS(
                                color: Palette.peepGray400)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _CalendarPicker extends StatelessWidget {
  final PeepDatePickerController controller;
  final MyPageController myPageController = Get.find();
  final Color color;

  _CalendarPicker({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        calendarBuilders: CalendarBuilders(
          outsideBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                DateFormat.d().format(day),
                style: PeepTextStyle.regularXS(color: Palette.peepGray400),
              ),
            );
          },
          selectedBuilder: (context, day, selectedDay) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 20.w, // Container의 너비
                    height: 20.w, // Container의 높이
                    decoration: BoxDecoration(
                      color: color.withOpacity(AppValues.halfOpacity),
                      borderRadius: BorderRadius.circular(AppValues.baseRadius),
                    ),
                  ),
                  Center(
                    child: Text(
                      DateFormat.d().format(selectedDay),
                      style: controller.isToday()
                          ? PeepTextStyle.boldXS(color: Palette.peepBlack)
                          : PeepTextStyle.regularXS(color: Palette.peepBlack),
                    ),
                  ),
                ],
              ),
            );
          },
          dowBuilder: customDowBuilder,
          defaultBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                DateFormat.d().format(day),
                style: PeepTextStyle.regularXS(color: Palette.peepBlack),
              ),
            );
          },
        ),
        headerVisible: false,
        calendarStyle: CalendarStyle(
            defaultTextStyle: PeepTextStyle.regularXS(color: Palette.peepBlack),
            todayTextStyle: PeepTextStyle.boldXS(color: Palette.peepBlack),
            selectedTextStyle: controller.isToday()
                ? PeepTextStyle.boldXS(color: Palette.peepBlack)
                : PeepTextStyle.regularXS(color: Palette.peepBlack),
            weekendTextStyle: PeepTextStyle.regularXS(color: Palette.peepBlack),
            outsideDaysVisible: true,
            todayDecoration: const BoxDecoration(color: Colors.transparent)),
        daysOfWeekHeight: 35.h,
        rowHeight: 50.h,
        locale: 'ko_KR',
        firstDay: DateTime.utc(1923, 1, 1),
        lastDay: DateTime.utc(2123, 12, 31),
        focusedDay: controller.focusedDate.value,
        startingDayOfWeek: myPageController.getStartingDayOfWeek(myPageController.startingDayOfWeek.value),
        selectedDayPredicate: (day) {
          return isSameDay(controller.selectedDate.value, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          controller.onDaySelected(selectedDay, focusedDay);
        },
        calendarFormat: CalendarFormat.month,
        rangeSelectionMode: RangeSelectionMode.disabled,
        onPageChanged: (focusedDay) {
          controller.onPageChanged(focusedDay);
        },
        pageJumpingEnabled: true,
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final PeepDatePickerController controller;
  final Color color;

  const _DatePicker({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ScrollDatePicker(
          selectedDate: controller.selectedDate.value,
          locale: const Locale('ko'),
          options: const DatePickerOptions(
              itemExtent: 70,
            diameterRatio: 10,
          ),
          maximumDate: DateTime(2100, 12, 31),
          indicator: Container(
            height: 36.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          ),
          scrollViewOptions: DatePickerScrollViewOptions(
            year: ScrollViewDetailOptions(
              alignment: Alignment.center,
              label: '년 ',
              selectedTextStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
              textStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
            ),
            month: ScrollViewDetailOptions(
              alignment: Alignment.center,
              label: '월 ',
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              selectedTextStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
              textStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
            ),
            day: ScrollViewDetailOptions(
              alignment: Alignment.center,
              label: '일 ',
              selectedTextStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
              textStyle: PeepTextStyle.boldXL(color: Palette.peepBlack),
            ),
          ),
          onDateTimeChanged: (DateTime date) =>
              controller.onDaySelected(date, date)),
    );
  }
}
