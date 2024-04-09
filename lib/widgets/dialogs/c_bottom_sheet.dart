import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

class BottomSheetBuilder extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final String? title;

  const BottomSheetBuilder({
    super.key,
    required this.child,
    this.title,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSize.spacing20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Scroll тэмдэг
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: context.colors.icon,
                color: const Color(0xFFCDCFD0),
              ),
              height: 3,
              width: 45,
            ),
          ),

          /// Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Back button etc...
                    if (leading != null) leading!,

                    /// Title
                    Padding(
                      padding: const EdgeInsets.only(left: CSize.spacing4),
                      child: Text(
                        title ?? '',
                        style: context.textStyles.heading16!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// Close button
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/images/core/close.svg',
                        // color: context.colors.icon,
                        // colorFilter:
                        // (context.colors.icon ?? context.theme.primaryColor)
                        //     .toColorFilterWithSrcIn,
                        fit: BoxFit.scaleDown,
                        width: CSize.icon24,
                        height: CSize.icon24,
                      ),
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   borderRadius: BorderRadius.circular(5.0),
                    //   child: SvgPicture.asset(
                    //     'assets/icons/global/x.svg',
                    //     color: context.colors.icon,
                    //     fit: BoxFit.scaleDown,
                    //     width: MSize.icon24,
                    //     height: MSize.icon24,
                    //   ),
                    // ),

                    // SquareButton(
                    //   onPressed: () => {Navigator.pop(context)},
                    //   asset: 'assets/icons/global/x.svg',
                    //   outlined: false,
                    //   smallButton: true,
                    // )
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: CSize.spacing20 / 2),

          /// Body
          Expanded(
            child: Container(
              alignment: context.isTablet ? Alignment.topCenter : null,
              child: SizedBox(
                width: context.isTablet ? 600.0 : null,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  double? height,
}) async {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: height != null,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return Container(
        color: context.theme.scaffoldBackgroundColor,
        height: height,
        child: child,
      );
    },
  );
}

Future<void> showRectangularBottomSheet({
  required BuildContext context,
  required Widget child,
  double? height,
}) async {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: height != null,
    builder: (context) {
      return SizedBox(
        height: height,
        child: child,
      );
    },
  );
}
