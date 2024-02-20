import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_font_size.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'button_settings.dart';

/// Secondary elevated button
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.settings,
    this.onPressed,
    this.text,
    this.textStyle,
    this.shape,
    this.elevation,
    this.width,
    this.margin,
    this.loading,
    this.loadingText,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final ButtonSettings settings;
  final VoidCallback? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final OutlinedBorder? shape;
  final double? elevation;
  final double? width;
  final EdgeInsets? margin;
  final bool? loading;
  final String? loadingText;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final String? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: (onPressed != null)
            ? () {
                if (loading ?? false) {
                  debugPrint('Loading... Please wait');
                  return;
                }

                onPressed?.call();
              }
            : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          // primary: Theme.of(context).buttonTheme.copyWith(
          //       buttonColor: Colors.red,
          //     ),
          backgroundColor: backgroundColor ?? Colors.white,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MButtonSize.borderRadius),
              ),
          elevation: elevation ?? settings.elevation,
          shadowColor: _shadowColor(),
        ),
        child: Container(
          height: settings.height,
          width: width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: CSize.spacing32),
          child: _child(context),
        ),
      ),
    );
  }

  Color? _shadowColor() {
    return settings == ButtonSettings.small ? Colors.transparent : null;
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
            child: CircularProgressIndicator(),
          ),
        );
      }
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Prefix icon
          if (prefixIcon != null)
            Container(
              margin: const EdgeInsets.only(right: CSize.spacing8),
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
              margin: const EdgeInsets.only(left: CSize.spacing8),
              child: SvgPicture.asset(suffixIcon!),
            ),
        ],
      );
    }
  }
}
