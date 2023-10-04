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

  // onTap 이벤트 handler
  void handleOnTap() {
    debugPrint("Tapped");
  }

  // onLongPress 이벤트 handler
  void handleOnLongPress() {
    debugPrint("Long Pressed");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      onLongPress: handleOnLongPress,
      child: Container(
        height: 34.0,
        decoration: BoxDecoration(
          color: Palette.peepButton300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Emoji
                  Text(emoji),
                  const SizedBox(
                    width: 3,
                  ),
                  // Category Name
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
              // Add Icon
              const Icon(
                Iconsax.add_circle5,
                color: Palette.peepYellow400,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
