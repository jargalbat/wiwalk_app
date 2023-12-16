import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';

class CIconButton extends StatelessWidget {
  const CIconButton({
    super.key,
    this.onTap,
    this.imageAsset,
    this.svgAsset,
  });

  final VoidCallback? onTap;
  final String? imageAsset;
  final String? svgAsset;

  double get _iconSize => CSize.icon24;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_iconSize),
      child: _child(context),
    );
  }

  Widget _child(BuildContext context) {
    if (imageAsset != null) {
      return Image.asset(
        imageAsset!,
        height: _iconSize,
        width: _iconSize,
        fit: BoxFit.scaleDown,
        color: context.colors.icon,
      );
    } else if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        height: _iconSize,
        width: _iconSize,
        fit: BoxFit.scaleDown,
        theme: SvgTheme(
          currentColor: context.colors.icon ?? Colors.black,
        ),
      );
    } else {
      return Container();
    }
  }
}
