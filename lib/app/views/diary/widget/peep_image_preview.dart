import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/diary_page_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/palette.dart';

class PeepImagePreview extends StatelessWidget {
  final DiaryPageController controller = Get.find();

  PeepImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(bottom: AppValues.verticalMargin * 2),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var imagePath in controller.getImagePath())
                Padding(
                  padding: EdgeInsets.only(right: AppValues.horizontalMargin),
                  child: PeepAnimationEffect(
                    onTap: () {
                      Get.dialog(
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.file(
                            File(imagePath),
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      controller.deleteImage(imagePath);
                    },
                    child: SizedBox(
                      width: AppValues.imagePreviewSize * 4 / 3,
                      height: AppValues.imagePreviewSize,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppValues.smallRadius),
                        child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                ),
              if (controller.getImagePath().length <= 4)
                PeepAnimationEffect(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Container(
                    width: AppValues.imagePreviewSize * 4 / 3,
                    height: AppValues.imagePreviewSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.peepGray300),
                      borderRadius:
                          BorderRadius.circular(AppValues.smallRadius),
                    ),
                    child: Center(
                      child: PeepIcon(
                        Iconsax.imageAdd,
                        size: AppValues.baseIconSize,
                        color: Palette.peepGray400,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: AppValues.horizontalMargin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
