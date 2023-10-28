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

  static TextStyle baseRegularS = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle baseRegularM = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle baseRegularL = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle baseRegularXL = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle baseBoldXS = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle baseBoldS = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle baseBoldM = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle baseBoldL = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle baseBoldXL = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
}