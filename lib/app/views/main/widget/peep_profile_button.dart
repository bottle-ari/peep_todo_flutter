import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/app_string.dart';

class PeepProfileButton extends StatelessWidget {
  ImageProvider<Object> getProfileImage() {
    String? imageUrl = null;

    if (imageUrl != null && isValidUrl(imageUrl)) {
      try {
        return NetworkImage(imageUrl);
      } catch (e) {
        return const AssetImage(AppString.defaultImage);
      }
    } else {
      return const AssetImage(AppString.defaultImage);
    }
  }

  bool isValidUrl(String url) {
    var pattern = r'^(?:http|ftp)s?://' // http:// or https://
        r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+' // domain
        r'(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' // domain name
        r'localhost|' // localhost
        r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|' // ...or ipv4
        r'\[?[A-F0-9]*:[A-F0-9:]+\]?)' // ...or ipv6
        r'(?::\d+)?' // optional port
        r'(?:/?|[/?]\S+)$';
    RegExp regExp = RegExp(pattern, caseSensitive: false);

    return regExp.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: () {
        Get.toNamed(AppPages.MYPAGE);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.tinyRadius),
        child: Image(
          image: getProfileImage(),
          width: AppValues.mediumIconSize,
          height: AppValues.mediumIconSize,
        ),
      ),
    );
  }
}
