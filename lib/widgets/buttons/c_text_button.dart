import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_font_size.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'button_settings.dart';

/// Text button
class CTextButton extends StatelessWidget {
  const CTextButton({
    Key? key,
    required this.settings,
    this.onPressed,
    this.text,
    this.textStyle,
    this.width,
    this.margin,
    this.loading,
    this.loadingText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final ButtonSettings settings;
  final VoidCallback? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double? width;
  final EdgeInsets? margin;
  final bool? loading;
  final String? loadingText;
  final Widget? prefixIcon;
  final String? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: settings.height,
      child: InkWell(
        onTap: (onPressed != null)
            ? () {
                if (loading ?? false) {
                  debugPrint('Loading... Please wait');
                  return;
                }

                onPressed?.call();
              }
            : null,
        borderRadius: BorderRadius.circular(MButtonSize.borderRadius),
        child: SizedBox(
          width: width,
          child: _child(context),
        ),
      ),
    );
  }

  Widget _child(BuildContext context) {
    if (loading ?? false) {
      if (loadingText != null) {
        return Center(
          child: Text(loadingText ?? ''),
        );
      } else {
        return const Center(
          child: SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      }
    } else {
      return Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Prefix icon
          if (prefixIcon != null)
            Container(
              margin: const EdgeInsets.only(right: CSize.spacing4),
              child: prefixIcon,
            ),

          /// Button text
          Text(
            text ?? '',
            maxLines: 1,
            style: textStyle ??
                context.textStyles.heading16?.copyWith(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),

          /// Suffix icon
          if (suffixIcon != null)
            Container(
              margin: const EdgeInsets.only(left: CSize.spacing4),
              child: SvgPicture.asset(suffixIcon!),
            ),
        ],
      );
    }
  }
}
