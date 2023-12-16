import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.0, 0.4],
          colors: [
            Colors.red,
            Colors.blue,
          ],
        ),
      ),
      child: child,
    );
  }
}
