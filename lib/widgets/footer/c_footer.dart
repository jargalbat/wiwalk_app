import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/c_text_button.dart';
import 'package:wiwalk_app/widgets/buttons/secondary_button.dart';

class CFooter extends StatelessWidget {
  const CFooter({
    super.key,
    this.button1Text,
    this.onPressedButton1,
    this.button2Text,
    this.onPressedButton2,
    this.loadingButton2,
    this.button2Width,
  });

  final String? button1Text;
  final VoidCallback? onPressedButton1;

  final String? button2Text;
  final VoidCallback? onPressedButton2;
  final bool? loadingButton2;
  final double? button2Width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 1.0],
          colors: [
            Color(0xFF106C80),
            Color(0xFF1AADCC),
          ],
        ),
      ),
      child: Column(
        children: [
          /// Body
          Container(
            padding: const EdgeInsets.fromLTRB(CSize.spacing24, CSize.spacing24,
                CSize.spacing24, CSize.spacing4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Button 1
                if (button1Text != null)
                  CTextButton(
                    onPressed: onPressedButton1,
                    settings: ButtonSettings.large,
                    text: button1Text,
                    textStyle: context.textStyles.heading16?.copyWith(
                      color: context.colors.text5,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon:
                        SvgPicture.asset('assets/images/core/arrow_prev.svg'),
                  ),

                /// Button 2
                if (button2Text != null)
                  SecondaryButton(
                    onPressed: onPressedButton2,
                    settings: ButtonSettings.large,
                    text: button2Text,
                    loading: loadingButton2,
                    width: button2Width,
                  ),
              ],
            ),
          ),

          /// Padding
          SizedBox(height: context.mediaQueryPadding.bottom),
        ],
      ),
    );
  }
}
