import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../../controllers/todo_controller.dart';
import '../../../data/model/category_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';

class ringPainter extends CustomPainter {
  final List<CategoryModel> categoryList;
  final List<double> itemCounts;

  ringPainter({required this.itemCounts, required this.categoryList});

  @override
  void paint(Canvas canvas, Size size) {
    const double total = 1 / 2;
    const double startAngle = -pi / 2;

    double currentAngle = startAngle;

    if (itemCounts.isEmpty) return;

    for (int i = 0; i < categoryList.length; i++) {
      final sweepAngle = ((itemCounts[i] / total) * pi); // 아이템 수에 따른 각도
      final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      );

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0
        ..color = categoryList[i]
            .color
            .withOpacity(AppValues.halfOpacity); // 아이템 순위에 해당하는 색상 사용

      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);

      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is ringPainter) {
      return !listEquals(itemCounts, oldDelegate.itemCounts) ||
          !listEquals(categoryList, oldDelegate.categoryList);
    }
    return true;
  }
}

class PeepMiniCalendar extends StatelessWidget {
  final ScheduledTodoController controller;
  final TodoController todoController = Get.find();

  PeepMiniCalendar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  Widget customDowBuilder(BuildContext context, DateTime day) {
    final text = DateFormat.E('ko_KR').format(day);
    final isSelected = todoController.selectedDate.value;
    final isToday = isSameDay(day, DateTime.now());
    return Center(
      child: Stack(
        children: [
          if (isToday)
            if (isSameDay(day, isSelected))
              Stack(
                children: [
                  Positioned(
                    top: 5.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 44.w, // Container의 너비
                        height: 40.h, // Container의 높이
                        decoration: BoxDecoration(
                          color: Palette.peepYellow50,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(AppValues.calendarItemRadius),
                            topRight:
                                Radius.circular(AppValues.calendarItemRadius),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 24.w,
                        width: 24.w,
                        decoration: BoxDecoration(
                          color: Palette.peepYellow400, // 배경색 설정
                          borderRadius: BorderRadius.circular(
                              AppValues.tinyRadius), // 모서리 라운딩 설정
                        ),
                        child: Center(
                          child: Text(text,
                              style: PeepTextStyle.boldXS(
                                  color: Palette.peepWhite)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            else
              Positioned(
                top: 10.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 24.w,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: Palette.peepYellow400, // 배경색 설정
                      borderRadius: BorderRadius.circular(
                          AppValues.tinyRadius), // 모서리 라운딩 설정
                    ), // 텍스트 주위의 여백 설정
                    child: Center(
                      child: Text(text,
                          style:
                              PeepTextStyle.boldXS(color: Palette.peepWhite)),
                    ),
                  ),
                ),
              )
          else if (isSameDay(day, isSelected))
            Stack(
              children: [
                Positioned(
                  top: 5.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 44.w, // Container의 너비
                      height: 40.h, // Container의 높이
                      decoration: BoxDecoration(
                        color: Palette.peepYellow50,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(AppValues.calendarItemRadius),
                          topRight:
                              Radius.circular(AppValues.calendarItemRadius),
                        ),
                      ),
                    ),
                  ),
                ),
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
                                ? PeepTextStyle.regularXS(
                                    color: Palette.peepRed)
                                : day.weekday == DateTime.saturday
                                    ? PeepTextStyle.regularXS(
                                        color: Palette.peepBlue)
                                    : PeepTextStyle.regularXS(
                                        color: Palette.peepGray400)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
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
                                ? PeepTextStyle.regularXS(
                                    color: Palette.peepBlue)
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

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: Palette.peepWhite,
              borderRadius: BorderRadius.circular(AppValues.baseRadius)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
            child: TableCalendar(
              calendarBuilders: CalendarBuilders(
                outsideBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      DateFormat.d().format(day),
                      style:
                          PeepTextStyle.regularXS(color: Palette.peepGray400),
                    ),
                  );
                },
                selectedBuilder: (context, day, selectedDay) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 44.w, // Container의 너비
                          height: 70.h, // Container의 높이
                          decoration: BoxDecoration(
                            color: Palette.peepYellow50,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(AppValues.calendarItemRadius),
                              bottomRight:
                                  Radius.circular(AppValues.calendarItemRadius),
                            ),
                          ),
                        ),
                        // Obx(()=>
                        //   CustomPaint(
                        //     size: Size(32.w, 32.h), // CustomPaint의 크기 고정
                        //     painter:
                        //         ringPainter(itemCounts: controller.calendarItemCounts[DateFormat('yyyyMMdd').format(day)] ?? [], categoryList: controller.getCategoryList()),
                        //   ),
                        // ),
                        Center(
                          child: Text(
                            DateFormat.d().format(selectedDay),
                            style: PeepTextStyle.regularXS(
                                color: Palette.peepBlack),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                dowBuilder: customDowBuilder,
                defaultBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Obx(()=>
                        //   CustomPaint(
                        //     size: Size(32.w, 32.h),
                        //     painter:
                        //     ringPainter(itemCounts: controller.calendarItemCounts[DateFormat('yyyyMMdd').format(day)] ?? [], categoryList: controller.getCategoryList()),
                        //   ),
                        // ),
                        Text(
                          DateFormat.d().format(day),
                          style:
                              PeepTextStyle.regularXS(color: Palette.peepBlack),
                        ),
                      ],
                    ),
                  );
                },
              ),
              headerVisible: false,
              calendarStyle: CalendarStyle(
                defaultTextStyle: PeepTextStyleBase.baseRegularM,
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppValues.calendarItemRadius),
                    // 좌하단 반지름 값
                    bottomRight: Radius.circular(
                        AppValues.calendarItemRadius), // 우하단 반지름 값
                  ),
                ),
                outsideDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppValues.calendarItemRadius),
                    // 좌하단 반지름 값
                    bottomRight: Radius.circular(
                        AppValues.calendarItemRadius), // 우하단 반지름 값
                  ),
                  color: null,
                ),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppValues.calendarItemRadius),
                    bottomRight: Radius.circular(AppValues.calendarItemRadius),
                  ),
                  color: Palette.peepYellow100,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppValues.calendarItemRadius),
                    bottomRight: Radius.circular(AppValues.calendarItemRadius),
                  ),
                  color: Palette.peepYellow100,
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppValues.calendarItemRadius),
                    // 좌하단 반지름 값
                    bottomRight: Radius.circular(
                        AppValues.calendarItemRadius), // 우하단 반지름 값
                  ),
                  color: null,
                ),
                isTodayHighlighted: false,
                todayTextStyle: PeepTextStyleBase.baseRegularM,
                selectedTextStyle: PeepTextStyleBase.baseRegularM,
                weekendTextStyle: PeepTextStyleBase.baseRegularM,
                outsideDaysVisible: false,
              ),

              daysOfWeekStyle: const DaysOfWeekStyle(
                  //weekdayStyle: TextStyle(color: P),
                  //decoration: Decoration()

                  ),
              daysOfWeekHeight: 35.h,
              rowHeight: 50.h,
              locale: 'ko_KR',
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2123, 12, 31),
              focusedDay: todoController.focusedDate.value,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(todoController.selectedDate.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                controller.onDaySelected(selectedDay, focusedDay);
              },
              calendarFormat: CalendarFormat.week,
              //onFormatChanged: (format) {
              //  controller.onFormatChanged(format);
              //},
              rangeSelectionMode: RangeSelectionMode.disabled,
              onPageChanged: (focusedDay) {
                controller.onPageChanged(focusedDay);
              },
            ),
          ),
        ));
  }
}
