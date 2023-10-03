import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckButton extends StatefulWidget {
  bool isCheck;
  bool isMain;
  Color color;
  final ValueChanged<bool> onCheckedChanged; // 콜백 함수 추가

  CheckButton({
    this.isCheck = false,
    this.isMain = true,
    required this.color,
    required this.onCheckedChanged, // 콜백 함수를 생성자로 전달
    Key? key,
  }) : super(key: key);

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.isCheck = !widget.isCheck;
          widget.onCheckedChanged(widget.isCheck); // 상태가 변경될 때 콜백 호출
        });
      },
      iconSize: widget.isMain ? 24 : 20,
      icon: widget.isCheck
          ? Icon(
        CupertinoIcons.check_mark_circled_solid,
        color: widget.color,
      )
          : Icon(
        CupertinoIcons.circle,
        color: widget.color,
      ),
    );
  }
}