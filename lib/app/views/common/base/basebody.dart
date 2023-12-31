import 'package:flutter/material.dart';

import '../../../theme/app_values.dart';

class BaseBody extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> widgetList;

  const BaseBody({
    this.scrollController,
    required this.widgetList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        width: double.infinity,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgetList,
          ),
        ),
      ),
    );
  }
}
