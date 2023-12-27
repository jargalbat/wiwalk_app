import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/router/custom_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final _size = 32.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(CSize.cardBorderRadius8),
        onTap: () {
          router.pushNamed(RouteNames.profile);
        },
        child: SvgPicture.asset(
          Assets.profile,
          fit: BoxFit.scaleDown,
          height: _size,
          width: _size,
        ),
      ),
    );
  }
}
