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
    flexibleSpace: showBottomBorder
        ? Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context
                      .theme.dividerColor, // Use the borderColor parameter
                  width: 1.0, // Customize border width
                ),
              ),
            ),
          )
        : null,
    elevation: 0, // Remove shadow under AppBar
  );
}
