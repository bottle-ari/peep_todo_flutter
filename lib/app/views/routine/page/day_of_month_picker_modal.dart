import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class DayOfMonthPickerModal extends StatelessWidget {
  final Color color;
  final int currentDayValue;
  final Function(int) onDayPicked;

  const DayOfMonthPickerModal({
    super.key,
    required this.onDayPicked,
    required this.currentDayValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppValues.baseRadius),
            topLeft: Radius.circular(AppValues.baseRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppValues.verticalMargin,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppValues.verticalMargin,
              bottom: AppValues.verticalMargin,
              left: AppValues.screenPadding,
            ),
            child: Text(
              '주차 선택',
              style: PeepTextStyle.boldL(color: Palette.peepGray500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
              child: GridView.builder(
                // 그리드 아이템 개수
                itemCount: 32,
                // 그리드 뷰의 그리드 아이템을 생성하는 함수
                itemBuilder: (context, index) {
                  // 각 그리드 아이템에 대한 위젯을 반환
                  return GestureDetector(
                    onTap: (){
                      onDayPicked(index + 1);
                      Get.back();
                    },
                    child: Container(
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: (index + 1) == currentDayValue
                            ? color.withOpacity(AppValues.baseOpacity)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppValues.baseRadius),
                      ),
                      child: Center(
                        child: Text(
                          (index + 1) == 32 ? '마지막' : (index + 1).toString(),
                          style:
                              PeepTextStyle.regularS(color: Palette.peepBlack),
                        ),
                      ),
                    ),
                  );
                },
                // 그리드의 레이아웃을 결정하는 함수
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 열의 개수
                  crossAxisSpacing: 8.0, // 열 간의 간격
                  mainAxisSpacing: 8.0, // 행 간의 간격
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
