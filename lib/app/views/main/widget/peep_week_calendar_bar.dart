import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/week_calendar_controller.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_scheduled_todo_app_bar.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';

class ringPainter extends CustomPainter {
  final List<int> itemRanks;
  final List<Color> itemColors;
  final List<double> itemCounts;

  ringPainter(this.itemRanks, this.itemColors, this.itemCounts);

  @override
  void paint(Canvas canvas, Size size) {
    final double total = 9 / 2;

    final double startAngle = -pi / 2;

    double currentAngle = startAngle;

    for (int rank in itemRanks) {
      final sweepAngle = ((itemCounts[rank - 1] / total) * pi); // 아이템 수에 따른 각도
      final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      );

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0
        ..color = itemColors[rank - 1]; // 아이템 순위에 해당하는 색상 사용

      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);

      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PeepWeekCalendarBar extends StatelessWidget {
  final WeekCalendarController calendarController =
      Get.put(WeekCalendarController());
  final List<DropdownMenuItemData> dropdownMenuItems;
  final Function(String) onMenuItemSelected;
  final Function() onTapClock;

  PeepWeekCalendarBar({
    Key? key,
    required this.dropdownMenuItems,
    required this.onMenuItemSelected,
    required this.onTapClock,
  }) : super(key: key);

  Widget customDowBuilder(BuildContext context, DateTime day) {
    final text = DateFormat.E('ko_KR').format(day);
    final isSelected = calendarController.selectedDay.value;
    final isToday = isSameDay(day, calendarController.toDay.value);
    return Center(
      child: Stack(
        children: [
          if (isToday)
            if (isSameDay(day, isSelected))
              Container(
                width: 44.w, // Container의 너비
                height: 40.h, // Container의 높이
                decoration: BoxDecoration(
                  color: Palette.peepYellow50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppValues.smallRadius),
                    topRight: Radius.circular(AppValues.smallRadius),
                  ),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Palette.peepYellow400, // 배경색 설정
                  borderRadius:
                      BorderRadius.circular(AppValues.tinyRadius), // 모서리 라운딩 설정
                ),
                padding: EdgeInsets.all(AppValues.innerMargin), // 텍스트 주위의 여백 설정
                child: Text(text,
                    style: PeepTextStyle.boldXS(color: Palette.peepWhite)),
              )
          else
            Container(
              padding: EdgeInsets.all(AppValues.innerMargin), // 텍스트 주위의 여백 설정
              child: Text(text,
                  style: day.weekday == DateTime.sunday
                      ? PeepTextStyle.regularXS(color: Palette.peepRed)
                      : day.weekday == DateTime.saturday
                          ? PeepTextStyle.regularXS(color: Palette.peepBlue)
                          : PeepTextStyle.regularXS(
                              color: Palette.peepGray400)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> itemRanks = [3, 2, 1]; // 아이템 순위 (1부터 시작)
    List<Color> itemColors = [
      Palette.peepBlue,
      Palette.peepRed,
      Palette.peepGreen
    ]; // 아이템 색상
    List<double> itemCounts = [1, 3, 5];

    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Range'),
      ),
      body: Obx(() => TableCalendar(
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (context, day, focusedDay) {
                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //CustomPaint(
                      //  size: Size(32.w, 32.h),
                      //  painter: ringPainter(itemRanks, itemColors, itemCounts),
                      //),
                      Text(
                        DateFormat.d().format(day),
                        style:
                            PeepTextStyle.regularXS(color: Palette.peepGray400),
                      ),
                    ],
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
                            bottomLeft: Radius.circular(AppValues.smallRadius),
                            bottomRight: Radius.circular(AppValues.smallRadius),
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: Size(32.w, 32.h), // CustomPaint의 크기 고정
                        painter: ringPainter(itemRanks, itemColors, itemCounts),
                      ),
                      Center(
                        child: Text(
                          DateFormat.d().format(selectedDay),
                          style:
                              PeepTextStyle.regularXS(color: Palette.peepBlack),
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
                      CustomPaint(
                        size: Size(32.w, 32.h),
                        painter: ringPainter(itemRanks, itemColors, itemCounts),
                      ),
                      Text(
                        DateFormat.d().format(day),
                        style:
                            PeepTextStyle.regularXS(color: Palette.peepBlack),
                      ),
                    ],
                  ),
                );
              },
              headerTitleBuilder: (context, day) {
                return PeepScheduledTodoAppBar(
                    selectedDate: DateFormat.MMMEd('ko_KR')
                        .format(calendarController.selectedDay.value),
                    dropdownMenuItems: dropdownMenuItems,
                    onMenuItemSelected: onMenuItemSelected,
                    onTapClock: onTapClock,
                    onTapToday: () => calendarController.onMoveToday());
              },
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
              headerMargin: EdgeInsets.all(2 * AppValues.horizontalMargin),
              headerPadding:
                  EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: PeepTextStyleBase.baseRegularM,
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.smallRadius),
                  // 좌하단 반지름 값
                  bottomRight:
                      Radius.circular(AppValues.smallRadius), // 우하단 반지름 값
                ),
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.smallRadius),
                  // 좌하단 반지름 값
                  bottomRight:
                      Radius.circular(AppValues.smallRadius), // 우하단 반지름 값
                ),
                color: null,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.smallRadius),
                  bottomRight: Radius.circular(AppValues.smallRadius),
                ),
                color: Palette.peepYellow100,
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.smallRadius),
                  bottomRight: Radius.circular(AppValues.smallRadius),
                ),
                color: Palette.peepYellow100,
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.smallRadius),
                  // 좌하단 반지름 값
                  bottomRight:
                      Radius.circular(AppValues.smallRadius), // 우하단 반지름 값
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
            daysOfWeekHeight: 24.h,
            rowHeight: 60.h,
            locale: 'ko_KR',
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: calendarController.focusedDay.value,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(calendarController.selectedDay.value, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              calendarController.onDaySelected(selectedDay, focusedDay);
            },
            calendarFormat: CalendarFormat.week,
            //onFormatChanged: (format) {
            //  calendarController.onFormatChanged(format);
            //},
            rangeSelectionMode: RangeSelectionMode.disabled,
          )),
    );
  }
}
