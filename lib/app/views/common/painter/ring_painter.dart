import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';

class RingPainter extends CustomPainter {
  final Map<String, double> itemCounts;
  final CategoryController controller = Get.find();

  RingPainter({required this.itemCounts});

  @override
  void paint(Canvas canvas, Size size) {
    const double startAngle = -pi / 2;

    double currentAngle = startAngle;

    if (itemCounts.isEmpty) return;

    debugPrint("ITEM COUNTS :");
    debugPrint(itemCounts.toString());

    // 만약 체크되지 않은 투두가 존재한다면 flag = true;
    bool flag = true;
    Color? firstColor;
    for (var category in controller.categoryList) {
      if(itemCounts[category.id] == null) {
        continue;
      } else if(itemCounts[category.id] == 0) {
        firstColor ??= category.color;
        continue;
      }

      flag = false;

      final sweepAngle =
      ((itemCounts[category.id] ?? 0) * pi * 2); // 아이템 수에 따른 각도
      final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      );

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0
        ..color = category.color
            .withOpacity(AppValues.baseOpacity); // 아이템 순위에 해당하는 색상 사용

      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);

      currentAngle += sweepAngle;
    }

    if(flag) {
      final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = firstColor!;

      final center = Offset(size.width / 2, size.height / 2 - 14.h);

      canvas.drawCircle(center, 2.w, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is RingPainter) {
      // Map의 키와 값 모두를 비교하기 위한 함수
      bool mapsEqual(Map<String, double> a, Map<String, double> b) {
        if (a.length != b.length) return false;
        for (String key in a.keys) {
          if (b.containsKey(key) && b[key] == a[key]) continue;
          return false;
        }
        return true;
      }

      return !mapsEqual(itemCounts, oldDelegate.itemCounts);
    }
    return true;
  }
}
