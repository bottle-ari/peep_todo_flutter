import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peep_todo_flutter/config/palette.dart';
import 'package:peep_todo_flutter/config/text_size.dart';

class CategoryButton extends StatelessWidget {
  final Color color;
  final String name;
  final String emoji;

  const CategoryButton({
    Key? key,
    required this.color,
    required this.name,
    required this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.0,
      decoration: BoxDecoration(
        color: Palette.peepButton300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // 이 부분을 추가
          children: [
            Row(
              children: [
                Text(emoji),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: color,
                      fontSize: TextSize.small,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Iconsax.add_circle5,
              color: Palette.peepYellow400,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
