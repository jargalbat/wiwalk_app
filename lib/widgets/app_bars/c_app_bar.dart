// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

import '../buttons/c_icon_button.dart';

AppBar CAppBar({
  required BuildContext context,
  Color? backgroundColor,
  Widget? leading,
  String? title,
  bool showBottomBorder = true,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    leading: leading ??
        CIconButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          svgAsset: Assets.arrowLeft,
        ),
    title: Text(title ?? ''),
    flexibleSpace: showBottomBorder ? appBarBottomBorder(context) : null,
    elevation: 0, // Remove shadow under AppBar
  );
}

Widget appBarBottomBorder(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: context.theme.dividerColor,
          width: 1.0,
        ),
      ),
    ),
  );
}
