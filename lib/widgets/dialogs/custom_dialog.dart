import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';

void showCustomDialog(
  BuildContext context, {
  required Widget child,
  bool isDismissible = false,
}) {
  Func.hideKeyboard(context);

  showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () {
          if (isDismissible) {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: child,
      );
    },
  );
}

class CustomDialogBody extends StatelessWidget {
  final Color? primaryColor;
  final String? asset;
  final String? title;
  final String? text;
  final Widget? child;
  final String? buttonText;
  final String? button2Text;
  final VoidCallback? onPressedButton;
  final VoidCallback? onPressedButton2;

  const CustomDialogBody({
    Key? key,
    this.primaryColor,
    this.asset,
    this.title,
    this.text,
    this.buttonText,
    this.button2Text,
    this.onPressedButton,
    this.onPressedButton2,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: MediaQuery.of(context).viewInsets,
      decoration: BoxDecoration(
        // color: customColors.primaryBackground,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              children: [
                if (asset != null) _icon(),
                if (title != null) _title(context),
                if (text != null) _text(context),
                if (child != null) child!,
                _buttons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 50.0,
      width: 50.0,
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(26.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        // color: customColors.blueBackground.withOpacity(0.1),
      ),
      child: SvgPicture.asset(asset!),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      child: Text(
        title ?? '',
        maxLines: 2,
        style: context.textStyles.heading16?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.theme.primaryColor,
        ),
      ),
    );
  }

  Widget _text(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      child: Text(
        text ?? '',
        maxLines: 3,
        style: context.textStyles.body14?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Button1
        if (buttonText != null)
          PrimaryButton(
            settings: ButtonSettings.large,
            text: buttonText,
            onPressed: () {
              Navigator.pop(context);
              if (onPressedButton != null) onPressedButton!();
            },
            backgroundColor: primaryColor,
          ),

        // Margin
        if (buttonText != null && button2Text != null)
          const SizedBox(height: 30.0),

        /// Button2
        if (button2Text != null)
          PrimaryButton(
            settings: ButtonSettings.large,
            text: button2Text!,
            // fontSize: SizeHelper.fontSizeMedium,
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            onPressed: () {
              Navigator.pop(context);
              if (onPressedButton2 != null) onPressedButton2!();
            },
          ),
      ],
    );
  }
}
