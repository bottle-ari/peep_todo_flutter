import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

bool get isAndroid =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

double getKeyboardHeight(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom;
}
