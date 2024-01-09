import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_values.dart';

class BubbleTopLeftPainter extends CustomPainter {
  final Color backgroundColor;

  BubbleTopLeftPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // 둥근 사각형 그리기
    var rect = Rect.fromLTWH(0, size.height * 0.125, size.width, size.height);
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(AppValues.baseRadius));
    canvas.drawRRect(rrect, paint);

    // 삼각형 그리기
    var path = Path();
    path.moveTo(size.height, 0);
    path.lineTo(size.height * 0.8, size.height * 0.2);
    path.lineTo(size.height * 1.2, size.height * 0.2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}