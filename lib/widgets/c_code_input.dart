import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

class CodeInputWidget extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;

  final FocusNode? focusNode;
  final bool enablePinAutofill;

  const CodeInputWidget({
    super.key,
    required this.controller,
    this.width = 56.0,
    required this.length,
    required this.onChanged,
    this.onCompleted,
    this.focusNode,
    this.enablePinAutofill = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length * (width + 8.0),
      child: PinCodeTextField(
        controller: controller,
        focusNode: focusNode,
        appContext: context,
        pastedTextStyle: TextStyle(
          color: context.colors.text,
          fontWeight: FontWeight.bold,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        scrollPadding: EdgeInsets.zero,
        length: length,
        enableActiveFill: true,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        enablePinAutofill: enablePinAutofill,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(CSize.inputBorderRadius8),
          fieldHeight: width,
          fieldWidth: width,
          borderWidth: 0.0,
          activeBorderWidth: 0.0,
          selectedBorderWidth: 0.0,
          inactiveBorderWidth: 0.0,
          disabledBorderWidth: 0.0,
          errorBorderWidth: 0.0,
          activeColor: Theme.of(context).cardColor,
          inactiveColor: Theme.of(context).cardColor,
          selectedColor: Theme.of(context).cardColor,
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
