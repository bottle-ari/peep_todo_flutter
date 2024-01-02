import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/quill_toolbar_enum.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import '../data/diary_controller.dart';
import '../data/todo_controller.dart';

class DiaryEditController extends BaseController {
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

  final RxDouble toolbarHeight = 48.h.obs;

  final RxString fontSizeText = "보통".obs;
  final Rx<Color> fontColor = Palette.peepBlack.obs;

  @override
  void onInit() {
    loadContent();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  void clearText() {
    var diary = _controller.diaryData.value;

    diary.memo = '';

    _controller.updateDiary(diary: diary);

    final newDocument = Document();

    quillController = QuillController(
        document: newDocument,
        selection: const TextSelection.collapsed(offset: 0));
  }

  void loadContent() {
    final String savedJson = _controller.diaryData.value.memo;

    if(savedJson.isEmpty) return;

    final Delta delta = Delta.fromJson(jsonDecode(savedJson));

    quillController = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void onEditingDone() {
    var diary = _controller.diaryData.value;

    final Delta delta = quillController.document.toDelta();
    final String json = jsonEncode(delta.toJson());

    diary.memo = json;

    _controller.updateDiary(diary: diary);
  }

  void onTapFontSizeButton() async {
    if (quillToolbarState.value == QuillToolbarEnum.size) {
      toolbarHeight.value = 48.h;
      quillToolbarState.value = QuillToolbarEnum.none;
    } else {
      toolbarHeight.value = 96.h;
      await Future.delayed(const Duration(milliseconds: 100));
      quillToolbarState.value = QuillToolbarEnum.size;
    }
  }

  void onTapFontColorButton() async {
    if (quillToolbarState.value == QuillToolbarEnum.color) {
      toolbarHeight.value = 48.h;
      quillToolbarState.value = QuillToolbarEnum.none;
    } else {
      toolbarHeight.value = 96.h;
      await Future.delayed(const Duration(milliseconds: 100));
      quillToolbarState.value = QuillToolbarEnum.color;
    }
  }

  void updateFontSizeText(double fontSize) {
    quillController
        .formatSelection(Attribute.clone(Attribute.size, fontSize.sp));

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
    if(color == null) {
      quillController.formatSelection(ColorAttribute(null));
      fontColor.value = Palette.peepBlack;
    } else {
      var hex = colorToHex(color);
      hex = '#$hex';
      quillController.formatSelection(ColorAttribute(hex));

      fontColor.value = color;
    }

    onTapFontColorButton();
  }
}
