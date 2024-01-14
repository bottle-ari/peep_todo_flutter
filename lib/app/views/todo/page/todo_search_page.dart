import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/search_item_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/custom_color_selection_handle.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../controllers/data/palette_controller.dart';

class TodoSearchPage extends BaseView<SearchItemController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    final SearchItemController searchItemController =
        Get.put(SearchItemController());
    final CategoryController categoryController = Get.put(CategoryController());
    final PaletteController paletteController = Get.find();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
          child: Container(
            width: AppValues.screenWidth - AppValues.screenPadding * 2,
            height: AppValues.largeItemHeight,
            decoration: BoxDecoration(
              color: Palette.peepGray50,
              borderRadius: BorderRadius.circular(AppValues.baseRadius),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PeepIcon(
                    Iconsax.calendarSearch,
                    size: AppValues.baseIconSize,
                    color: Palette.peepGray400,
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: paletteController
                              .getPriorityColor(), // works on iOS
                          selectionColor: paletteController
                              .getPriorityColor()
                              .withOpacity(
                                  AppValues.halfOpacity), // works on iOS
                          selectionHandleColor: paletteController
                              .getPriorityColor(), // not working on iOS
                        ),
                        cupertinoOverrideTheme: CupertinoThemeData(
                          primaryColor: paletteController
                              .getPriorityColor(), // alternative on iOS for "selectionHandleColor"
                        ),
                      ),
                      child: TextField(
                        controller: searchItemController.searchFieldController,
                        onChanged: (value) {
                          searchItemController.search();
                        },
                        style: PeepTextStyle.regularM(color: Palette.peepBlack),
                        autofocus: true,
                        selectionControls: CustomColorSelectionHandle(
                            paletteController.getPriorityColor()),
                        cursorColor: paletteController.getPriorityColor(),
                        decoration: InputDecoration(
                          border: InputBorder.none, // 밑줄 제거
                          hintText: '검색 할 키워드를 입력하세요',
                          hintStyle: PeepTextStyle.regularS(
                              color: Palette.peepGray300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () {
              final groupedItems = searchItemController.searchTodoList;

              return ListView.builder(
                itemCount: groupedItems.length,
                itemBuilder: (context, index) {
                  final group = groupedItems.entries.elementAt(index);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppValues.verticalMargin),
                        child: Text(
                          controller.checkYear(group.key),
                          style: PeepTextStyle.regularM(
                              color: Palette.peepGray500),
                        ),
                      ),
                      Column(
                        children: group.value.map((item) {
                          return Padding(
                            padding: EdgeInsets.all(
                                0.5 * AppValues.horizontalMargin),
                            child: PeepAnimationEffect(
                              scale: 0.95,
                              onTap: () async {
                                await controller.onTapSearchedTodo(item.date);
                              },
                              child: Container(
                                width: AppValues.screenWidth -
                                    AppValues.screenPadding * 2,
                                height: AppValues.largeItemHeight,
                                decoration: BoxDecoration(
                                  color: Palette.peepGray50,
                                  borderRadius:
                                      BorderRadius.circular(AppValues.baseRadius),
                                  border: Border.all(
                                    color:
                                        categoryController.getCategoryColorById(
                                            categoryId: item.categoryId),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppValues.screenPadding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 280.w,
                                        child: HighlightSearchText(
                                          text: item.name.length > 55
                                              ? '${item.name.substring(0, 54)}...'
                                              : item.name,
                                          searchKeyword:
                                              controller.searchKeyword.value,
                                        ),
                                      ),
                                      PeepIcon(
                                        Iconsax.export,
                                        size: AppValues.smallIconSize,
                                        color: categoryController
                                            .getCategoryColorById(
                                                categoryId: item.categoryId),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// 검색 highlighting RichText widget build
class HighlightSearchText extends StatelessWidget {
  final String text;
  final String searchKeyword;

  HighlightSearchText({required this.text, required this.searchKeyword});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _buildTextSpans(),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    int start = 0;

    while (start < text.length) {
      final index =
          text.toLowerCase().indexOf(searchKeyword.toLowerCase(), start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: PeepTextStyle.regularM(color: Palette.peepBlack),
        ));
        break;
      } else {
        if (index > start) {
          spans.add(TextSpan(
            text: text.substring(start, index),
            style: PeepTextStyle.regularM(color: Palette.peepBlack),
          ));
        }
        spans.add(TextSpan(
          text: text.substring(index, index + searchKeyword.length),
          style: PeepTextStyle.boldM(color: Palette.peepBlack),
        ));
        start = index + searchKeyword.length;
      }
    }

    return spans;
  }
}
