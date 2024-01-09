import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/painter/ring_painter.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controllers/data/palette_controller.dart';
import '../../../controllers/data/todo_controller.dart';
import '../../../controllers/widget/peep_mini_calendar_controller.dart';
import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';

class PeepDiaryMiniCalendar extends StatelessWidget {
  final PaletteController paletteController = Get.find();
  final TodoController controller = Get.find();
  final PeepMiniCalendarController peepMiniCalendarController = Get.find();

  PeepDiaryMiniCalendar({
    Key? key,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        child: Container(
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
                        Obx(
                          () => Container(
                            width: 24.w, // Container의 너비
                            height: 24.w, // Container의 높이
                            child: PeepIcon(
                              Iconsax.egg,
                              size: AppValues.largeIconSize,
                              color: paletteController
                                  .getPriorityColor()
                                  .withOpacity(AppValues.halfOpacity),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            DateFormat.d().format(selectedDay),
                            style: peepMiniCalendarController.isToday()
                                ? PeepTextStyle.boldXS(color: Palette.peepBlack)
                                : PeepTextStyle.regularXS(
                                    color: Palette.peepBlack),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                dowBuilder: customDowBuilder,
                todayBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => Container(
                            width: 24.w, // Container의 너비
                            height: 24.w, // Container의 높이
                            child: PeepIcon(
                              Iconsax.egg,
                              size: AppValues.largeIconSize,
                              color: peepMiniCalendarController.isDiaryData(day)
                                  ? Palette.peepGray200
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat.d().format(day),
                          style: PeepTextStyle.boldXS(color: Palette.peepBlack),
                        ),
                      ],
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => Container(
                            width: 24.w, // Container의 너비
                            height: 24.w, // Container의 높이
                            child: PeepIcon(
                              Iconsax.egg,
                              size: AppValues.largeIconSize,
                              color: peepMiniCalendarController.isDiaryData(day)
                                  ? Palette.peepGray200
                                  : Colors.transparent,
                            ),
                          ),
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
              ),
              headerVisible: false,
              calendarStyle: CalendarStyle(
                  defaultTextStyle:
                      PeepTextStyle.regularXS(color: Palette.peepBlack),
                  todayTextStyle:
                      PeepTextStyle.boldXS(color: Palette.peepBlack),
                  selectedTextStyle: peepMiniCalendarController.isToday()
                      ? PeepTextStyle.boldXS(color: Palette.peepBlack)
                      : PeepTextStyle.regularXS(color: Palette.peepBlack),
                  weekendTextStyle:
                      PeepTextStyle.regularXS(color: Palette.peepBlack),
                  outsideDaysVisible: true,
                  todayDecoration:
                      const BoxDecoration(color: Colors.transparent)),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  //weekdayStyle: TextStyle(color: P),
                  //decoration: Decoration()

                  ),
              daysOfWeekHeight: 35.h,
              rowHeight: 50.h,
              locale: 'ko_KR',
              firstDay: DateTime.utc(1923, 1, 1),
              lastDay: DateTime.utc(2123, 12, 31),
              focusedDay: controller.focusedDate.value,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDate.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                peepMiniCalendarController.onDaySelected(
                    selectedDay, focusedDay);
              },
              calendarFormat: peepMiniCalendarController.calendarFormat.value,
              onFormatChanged: (format) {
                peepMiniCalendarController.calendarFormat.value = format;
              },
              rangeSelectionMode: RangeSelectionMode.disabled,
              onPageChanged: (focusedDay) {
                peepMiniCalendarController.onPageChanged(focusedDay);
              },
              pageJumpingEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}
