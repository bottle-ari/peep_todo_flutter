import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class CalendarPickerModalController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
}

class CalendarPickerModal extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const CalendarPickerModal({super.key, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    CalendarPickerModalController controller = CalendarPickerModalController();

    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppValues.baseRadius),
          topRight: Radius.circular(AppValues.baseRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text(
                      DateFormat('yyyy년 MM월')
                          .format(controller.selectedDate.value),
                      style: PeepTextStyle.boldL(color: Palette.peepBlack),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: PeepIcon(
                    Iconsax.checkTrue,
                    size: AppValues.largeIconSize,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 300,
            //   child: CupertinoDatePicker(
            //     mode: CupertinoDatePickerMode.date,
            //     initialDateTime: controller.selectedDate.value,
            //     minimumDate: DateTime.utc(1923, 1, 1),
            //     maximumDate: DateTime.utc(2123, 12, 31),
            //     dateOrder: DatePickerDateOrder.ymd,
            //     itemExtent: 50,
            //     onDateTimeChanged: (DateTime value) {
            //       controller.selectedDate.value = value;
            //     },
            //   ),
            // ),
            Obx(
              () => SizedBox(
                height: 250,
                child: ScrollDatePicker(
                  minimumDate: DateTime.utc(1923, 1, 1),
                  maximumDate: DateTime.utc(2123, 12, 31),
                  selectedDate: controller.selectedDate.value,
                  locale: const Locale('ko'),
                  scrollViewOptions: DatePickerScrollViewOptions(
                    year: ScrollViewDetailOptions(
                      label: '년',
                      alignment: Alignment.centerRight,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                      selectedTextStyle:
                          PeepTextStyle.boldL(color: Palette.peepBlack),
                      textStyle: PeepTextStyle.boldL(color: Palette.peepGray400),
                    ),
                    month: ScrollViewDetailOptions(
                      label: '월',
                      alignment: Alignment.centerRight,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                      selectedTextStyle:
                      PeepTextStyle.boldL(color: Palette.peepBlack),
                      textStyle: PeepTextStyle.boldL(color: Palette.peepGray400),
                    ),
                    day: ScrollViewDetailOptions(
                      label: '일',
                      alignment: Alignment.centerRight,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                      selectedTextStyle:
                      PeepTextStyle.boldL(color: Palette.peepBlack),
                      textStyle: PeepTextStyle.boldL(color: Palette.peepGray400),
                    ),
                  ),
                  onDateTimeChanged: (DateTime value) {
                    controller.selectedDate.value = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
