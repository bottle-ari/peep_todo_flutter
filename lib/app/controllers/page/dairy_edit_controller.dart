import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/quill_toolbar_enum.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import '../data/diary_controller.dart';
import '../data/todo_controller.dart';

class DiaryEditController extends BaseController {
  final PaletteController paletteController = Get.find();
  final TodoController _todoController = Get.find();
  final DiaryController _controller = Get.find();

  late final RxString date;

  final FocusNode focusNode = FocusNode();

  DiaryEditController() {
    date = DateFormat('yyyy년 MM월 dd일')
        .format(_todoController.selectedDate.value)
        .obs;
  }

  // Quill
  QuillController quillController = QuillController.basic();
  final Rx<QuillToolbarEnum> quillToolbarState = QuillToolbarEnum.none.obs;

  final RxDouble toolbarHeight = 60.h.obs;

  final RxString fontSizeText = "보통".obs;
  final Rx<Color> fontColor = Palette.peepBlack.obs;
  final Rx<Color> fontBackgroundColor = Palette.peepWhite.obs;

  @override
  void onInit() {
    loadContent();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });

    quillController.addListener(() {
      onSelect();
    });

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  void clearText() {
    var diary = _controller.diaryData[_todoController.getSelectedTodoKey()];

    if (diary == null) return;

    diary.memo = '';
    diary.image = [];

    _controller.updateDiary(diary: diary);

    final newDocument = Document();

    quillController = QuillController(
        document: newDocument,
        selection: const TextSelection.collapsed(offset: 0));
  }

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  void onSelect() {
    Style selectedStyle = quillController.getSelectionStyle();

    if(selectedStyle.containsKey('color')) {
      String? colorHex = selectedStyle.attributes['color']?.value;

      if(colorHex != null) {
        fontColor.value = Color(int.parse(colorHex.replaceFirst('#', ''), radix: 16));
      } else {
        fontColor.value = Palette.peepBlack;
      }
    } else {
      fontColor.value = Palette.peepBlack;
    }

    if(selectedStyle.containsKey('background')) {
      String? colorHex = selectedStyle.attributes['background']?.value;

      if(colorHex != null) {
        fontBackgroundColor.value = Color(int.parse(colorHex.replaceFirst('#', ''), radix: 16)).withOpacity(1);
      } else {
        fontBackgroundColor.value = Palette.peepWhite;
      }
    } else {
      fontBackgroundColor.value = Palette.peepWhite;
    }

    bool headerFlag = false;
    bool sizeFlag = false;

    if(selectedStyle.containsKey('size')) {
      double? val = selectedStyle.attributes['size']?.value;

      if(val != null) {
        if(val == 12.sp) {
          fontSizeText.value = "작게";
        } else if(val == 16.sp) {
          fontSizeText.value = "보통";
        } else if (val == 20.sp) {
          fontSizeText.value = "크게";
        }
      } else {
        sizeFlag = true;
      }
    } else {
      sizeFlag = true;
    }

    if(selectedStyle.containsKey('header')) {
      int? val = selectedStyle.attributes['header']?.value;

      if(val != null) {
        fontSizeText.value = "h$val";
      } else {
        headerFlag = true;
      }
    } else {
      headerFlag = true;
    }

    if(headerFlag && sizeFlag) {
      fontSizeText.value = "보통";
    }
  }

  void loadContent() {
    final String savedJson =
        _controller.diaryData[_todoController.getSelectedTodoKey()]?.memo ?? '';

    if (savedJson.isEmpty) return;

    final Delta delta = Delta.fromJson(jsonDecode(savedJson));

    quillController = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );

    quillController.moveCursorToEnd();

    onSelect();
  }

  void onEditingDone() {
    var diary = _controller.diaryData[_todoController.getSelectedTodoKey()];

    log(diary.toString());

    if (diary == null) return;

    final Delta delta = quillController.document.toDelta();
    final String json = jsonEncode(delta.toJson());

    diary.memo = json;

    _controller.updateDiary(diary: diary);
  }

  void onTapFontSizeButton() async {
    if (quillToolbarState.value == QuillToolbarEnum.size) {
      toolbarHeight.value = 60.h;
      quillToolbarState.value = QuillToolbarEnum.none;
    } else {
      toolbarHeight.value = 160.h;
      await Future.delayed(const Duration(milliseconds: 100));
      quillToolbarState.value = QuillToolbarEnum.size;
    }
  }

  void onTapFontColorButton() async {
    if (quillToolbarState.value == QuillToolbarEnum.color) {
      toolbarHeight.value = 60.h;
      quillToolbarState.value = QuillToolbarEnum.none;
    } else {
      toolbarHeight.value = 160.h;
      await Future.delayed(const Duration(milliseconds: 100));
      quillToolbarState.value = QuillToolbarEnum.color;
    }
  }

  void onTapFontBackgroundColorButton() async {
    if (quillToolbarState.value == QuillToolbarEnum.background) {
      toolbarHeight.value = 60.h;
      quillToolbarState.value = QuillToolbarEnum.none;
    } else {
      toolbarHeight.value = 160.h;
      await Future.delayed(const Duration(milliseconds: 100));
      quillToolbarState.value = QuillToolbarEnum.background;
    }
  }

  void updateFontSizeText(double fontSize) {
    if (fontSize < 0) {
      if (fontSizeText.value == '작게' ||
          fontSizeText.value == '보통' ||
          fontSizeText.value == '크게') {
        quillController.formatSelection(Attribute.clone(Attribute.size, null));
      }
      switch (fontSize) {
        case -1:
          if (fontSizeText.value != 'h1') {
            quillController.formatSelection(Attribute.h1);
            fontSizeText.value = "h1";
          } else {
            quillController
                .formatSelection(Attribute.clone(Attribute.h1, null));
            fontSizeText.value = "보통";
          }
          break;
        case -2:
          if (fontSizeText.value != 'h2') {
            quillController.formatSelection(Attribute.h2);
            fontSizeText.value = "h2";
          } else {
            quillController
                .formatSelection(Attribute.clone(Attribute.h2, null));
            fontSizeText.value = "보통";
          }
          break;
        case -3:
          if (fontSizeText.value != 'h3') {
            quillController.formatSelection(Attribute.h3);
            fontSizeText.value = "h3";
          } else {
            quillController
                .formatSelection(Attribute.clone(Attribute.h3, null));
            fontSizeText.value = "보통";
          }
          break;
        default:
          break;
      }
    } else {
      if (fontSizeText.value == 'h1') {
        quillController.formatSelection(Attribute.clone(Attribute.h1, null));
      } else if (fontSizeText.value == 'h2') {
        quillController.formatSelection(Attribute.clone(Attribute.h2, null));
      } else if (fontSizeText.value == 'h3') {
        quillController.formatSelection(Attribute.clone(Attribute.h3, null));
      }
      quillController
          .formatSelection(Attribute.clone(Attribute.size, fontSize.sp));
    }

    switch (fontSize) {
      case 12:
        fontSizeText.value = "작게";
        break;
      case 16:
        fontSizeText.value = "보통";
        break;
      case 20:
        fontSizeText.value = "크게";
        break;
      default:
        break;
    }

    onTapFontSizeButton();
  }

  void updateFontColor(Color? color) {
    if (color == null) {
      quillController.formatSelection(const ColorAttribute(null));
      fontColor.value = Palette.peepBlack;
    } else {
      var hex = colorToHex(color);
      hex = '#$hex';
      quillController.formatSelection(ColorAttribute(hex));

      fontColor.value = color;
    }

    onTapFontColorButton();
  }

  void updateFontBackgroundColor(Color? color) {
    if (color == null) {
      quillController.formatSelection(const BackgroundAttribute(null));
      fontBackgroundColor.value = Palette.peepWhite;
    } else {
      var hex = colorToHex(color.withOpacity(AppValues.quarterOpacity));
      hex = '#$hex';
      quillController.formatSelection(BackgroundAttribute(hex));

      fontBackgroundColor.value = color;
    }

    onTapFontBackgroundColorButton();
  }
}
