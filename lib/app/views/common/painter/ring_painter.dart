import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/data/model/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:flutter/foundation.dart';

class RingPainter extends CustomPainter {
  final List<CategoryModel> categoryList;
  final List<double> itemCounts;

  RingPainter({required this.itemCounts, required this.categoryList});

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
    if (oldDelegate is RingPainter) {
      return !listEquals(itemCounts, oldDelegate.itemCounts) ||
          !listEquals(categoryList, oldDelegate.categoryList);
    }
    return true;
  }
}
