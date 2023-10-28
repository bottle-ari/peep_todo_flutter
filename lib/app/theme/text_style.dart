import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class PeepTextStyle {
  static TextStyle regularXS(Color? color) {
    return PeepTextStyleBase.baseRegularXS.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle regularS(Color? color) {
    return PeepTextStyleBase.baseRegularS.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle regularM(Color? color) {
    return PeepTextStyleBase.baseRegularM.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle regularL(Color? color) {
    return PeepTextStyleBase.baseRegularL.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle regularXL(Color? color) {
    return PeepTextStyleBase.baseRegularXL.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle boldXS(Color? color) {
    return PeepTextStyleBase.baseBoldXS.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle boldS(Color? color) {
    return PeepTextStyleBase.baseBoldS.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle boldM(Color? color) {
    return PeepTextStyleBase.baseBoldM.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle boldL(Color? color) {
    return PeepTextStyleBase.baseBoldL.copyWith(color: color ?? Palette.peepBlack);
  }

  static TextStyle boldXL(Color? color) {
    return PeepTextStyleBase.baseBoldXL.copyWith(color: color ?? Palette.peepBlack);
  }
}

abstract class PeepTextStyleBase {
  static TextStyle baseRegularXS = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle baseRegularS = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle baseRegularM = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle baseRegularL = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle baseRegularXL = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle baseBoldXS = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseBoldS = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseBoldM = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseBoldL = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseBoldXL = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
}