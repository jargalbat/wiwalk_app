import 'package:flutter/material.dart';

class MiniCard extends StatelessWidget {
  const MiniCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
