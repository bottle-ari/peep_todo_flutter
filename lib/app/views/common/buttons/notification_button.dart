import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class NotificationButton extends StatelessWidget {
  final PeepIcon icon;
  final bool isNotified;
  final Function() onTapFunc;

  const NotificationButton({
    Key? key,
    required this.icon,
    required this.isNotified,
    required this.onTapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => onTapFunc(),
          icon: icon,
        ),
        if (isNotified)
          Positioned(
            top: 7, // 원의 상단 위치
            right: 7, // 원의 오른쪽 위치
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.peepRed,
              ),
              width: 9.r, // 빨간 원의 너비
              height: 9.r, // 빨간 원의 높이
            ),
          ),
      ],
    );
  }
}
