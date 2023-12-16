import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

class StrokeCard extends StatelessWidget {
  const StrokeCard({
    super.key,
    this.onTap,
    this.child,
  });

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    /// Body
    if (child != null) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(CSize.cardBorderRadius8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(CSize.cardBorderRadius8),
            ),
            child: child!,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
