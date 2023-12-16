import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

enum DialogType { info, warning, success, error }

Future<void> showCustomDialog(
  BuildContext context, {
  bool? barrierDismissible,
  DialogType? dialogType,
  String? asset,
  Color? assetColor,
  String? title,
  String? text,
  Widget? child,
  String? button1Text,
  Color? button1Color,
  VoidCallback? onPressedButton1,
  String? button2Text,
  Color? button2Color,
  VoidCallback? onPressedButton2,
}) {
  double circleHeight = 24.0;

  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible ?? true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => barrierDismissible ?? true,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          content: SizedBox(
            width: 376,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    color: context.theme.cardColor,
                  ),
                  padding: const EdgeInsets.only(
                      top: CSize.spacing12,
                      left: CSize.spacing24,
                      right: CSize.spacing24,
                      bottom: CSize.spacing28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        height: circleHeight,
                        width: circleHeight,
                        asset ?? dialogAsset(dialogType),
                        color: assetColor ?? dialogColor(dialogType),
                      ),

                      /// Title
                      if (title != null)
                        Text(
                          title,
                          style: context.textStyles.heading16
                              ?.copyWith(fontWeight: FontWeight.bold),
                          // TextStyle(
                          //   fontSize: 18.0,
                          //   color: dialogColor(dialogType),
                          // ),
                          textAlign: TextAlign.center,
                        ),

                      /// Text
                      if (text != null)
                        Container(
                          margin: const EdgeInsets.only(top: CSize.spacing8),
                          child: Text(
                            text,
                            style: context.textStyles.body14,
                            textAlign: TextAlign.center,
                          ),
                        ),

                      /// Custom child
                      if (child != null) child,

                      const SizedBox(height: CSize.spacing16),

                      /// Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (button1Text != null)
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      button1Color ?? context.colors.gray120,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30.0,
                                  child: Text(
                                    button1Text,
                                    style: context.textStyles.body14?.copyWith(
                                      color: Colors.white,
                                    ),
                                    // style:
                                    //     TextStyle(color: context.colors.text),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (onPressedButton1 != null) {
                                    onPressedButton1();
                                  }
                                },
                              ),
                            ),
                          if (button1Text != null) const SizedBox(width: 20.0),
                          if (button2Text != null)
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  elevation: 0.0,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30.0,
                                  child: Text(
                                    button2Text,
                                    style: context.textStyles.body14?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  if (onPressedButton2 != null) {
                                    onPressedButton2();
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Color dialogColor(DialogType? dialogType) {
  Color? res;
  switch (dialogType) {
    case DialogType.success:
      res = Colors.green;
      break;
    case DialogType.warning:
      res = Colors.orange;
      break;
    case DialogType.error:
      res = Colors.red;
      break;
    case DialogType.info:
    default:
      res = Colors.blue;
      break;
  }

  return res;
}

String dialogAsset(DialogType? dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return 'assets/images/core/close.svg';
    case DialogType.warning:
    case DialogType.error:
      return 'assets/images/core/close.svg';
    case DialogType.info:
    default:
      return 'assets/images/core/close.svg';
  }
}
