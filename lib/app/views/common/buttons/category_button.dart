import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../../../theme/text_size.dart';

class CategoryButton extends StatelessWidget {
  final Color color;
  final String name;
  final String emoji;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CategoryButton({
    Key? key,
    required this.color,
    required this.name,
    required this.emoji,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
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
                Icons.add_circle,
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
