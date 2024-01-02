import 'dart:developer';

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

class TodoSearchPage extends BaseView<SearchItemController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    final SearchItemController searchItemController =
        Get.put(SearchItemController());
    final CategoryController categoryController = Get.put(CategoryController());

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(0.5 * AppValues.horizontalMargin),
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
                    color: Palette.peepPurple,
                  ),
                  SizedBox(
                    width: 300.w,
                    child: TextField(
                      controller: searchItemController.searchFieldController,
                      onChanged: (value) {
                        searchItemController.search();
                      },
                      style: PeepTextStyle.regularM(color: Palette.peepBlack),
                      decoration: InputDecoration(
                        border: InputBorder.none, // 밑줄 제거
                        hintText: '검색 할 키워드를 입력하세요',
                        hintStyle:
                            PeepTextStyle.regularS(color: Palette.peepGray300),
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
                            child: Container(
                              width: AppValues.screenWidth -
                                  AppValues.screenPadding * 2,
                              height: AppValues.largeItemHeight,
                              decoration: BoxDecoration(
                                color: Palette.peepGray50,
                                borderRadius:
                                    BorderRadius.circular(AppValues.baseRadius),
                                border: Border.all(
                                  color: categoryController
                                      .getCategoryById(
                                          categoryId: item.categoryId)
                                      .color,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppValues.horizontalMargin),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.selectedDay(item.date);
                                    Get.toNamed(AppPages.INITIAL);
                                    controller.initSearchFunction();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 300.w,
                                        child: HighlightSearchText(
                                          text: item.name,
                                          searchKeyword:
                                              controller.searchKeyword.value,
                                        ),
                                      ),
                                      PeepIcon(
                                        Iconsax.export,
                                        size: AppValues.smallIconSize,
                                        color: categoryController
                                            .getCategoryById(
                                                categoryId: item.categoryId)
                                            .color,
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
