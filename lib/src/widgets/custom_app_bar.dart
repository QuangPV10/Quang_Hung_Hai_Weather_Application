import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? widgetLeading;
  final List<Widget>? actionWidget;
  final Widget title;

  CustomAppBar(
      {this.actionWidget,
      this.widgetLeading,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 60,
      elevation: 0,
      backgroundColor: ColorsApp.primary,
      leading: widgetLeading,
      centerTitle: true,
      title: title,
      actions: actionWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
