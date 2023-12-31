import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/assets.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: BoxFit.fill,
      height: context.height,
      width: context.width,
    );
  }
}
