import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

class CodeInputWidget extends StatelessWidget {
  final double inputWidth;
  final TextEditingController controller;
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;

  final FocusNode? focusNode;
  final bool enablePinAutofill;

  const CodeInputWidget({
    super.key,
    required this.inputWidth,
    required this.controller,
    required this.length,
    required this.onChanged,
    this.onCompleted,
    this.focusNode,
    this.enablePinAutofill = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: CSize.spacing10,
        horizontal: CSize.spacing20,
      ),
      child: PinCodeTextField(
        controller: controller,
        focusNode: focusNode,
        appContext: context,
        pastedTextStyle: TextStyle(
          color: context.colors.text,
          fontWeight: FontWeight.bold,
        ),
        length: length,
        enableActiveFill: true,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        enablePinAutofill: enablePinAutofill,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(CSize.inputBorderRadius8),
          fieldHeight: inputWidth,
          fieldWidth: inputWidth,
          activeColor: Theme.of(context).dividerColor,
          inactiveColor: Theme.of(context).dividerColor,
          selectedColor: Theme.of(context).primaryColor,
          activeFillColor: Theme.of(context).cardColor,
          selectedFillColor: Theme.of(context).cardColor,
          inactiveFillColor: Theme.of(context).cardColor,
        ),
        cursorColor: context.colors.text2,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        onCompleted: onCompleted,
        onChanged: onChanged,
        beforeTextPaste: (text) {
          debugPrint("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
