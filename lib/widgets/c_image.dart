import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';

class CImage extends StatelessWidget {
  const CImage({
    super.key,
    this.imageUrl,
    required this.height,
    required this.width,
  });

  final String? imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CSize.imageBorderRadius8),
        child: Container(
          height: height,
          width: width,
          color: context.colors.primaryLight,
          child: Func.isNotEmpty(imageUrl)
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      _imagePlaceHolder(context),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                  fadeInCurve: Curves.easeIn,
                )
              : _imagePlaceHolder(context),
        ),
      ),
    );
  }

  Widget _imagePlaceHolder(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/core/image_placeholder.svg',
        height: 20.0,
        width: 30.0,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
