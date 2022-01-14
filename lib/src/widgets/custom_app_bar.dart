import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? widgetLeading;
  final List<Widget>? actionWidget;
  final String title;
  final String subtitle;

  CustomAppBar(
      {this.actionWidget,
      this.widgetLeading,
      required this.title,
      required this.subtitle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    TextStyle titleAppBarStyle = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.light,
        fontSize: 20,
        color: Colors.white);

    TextStyle subTitleAppBarStyle = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.light,
        fontSize: 18,
        color: ColorsApp.secondaryTextColor);

    return AppBar(
      elevation: 0,
      backgroundColor: ColorsApp.primaryBackgroundColor,
      leading: widgetLeading,
      centerTitle: true,
      title: Column(
        children: [
          Text(title, style: titleAppBarStyle),
          Text(subtitle, style: subTitleAppBarStyle),
        ],
      ),
      actions: actionWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
