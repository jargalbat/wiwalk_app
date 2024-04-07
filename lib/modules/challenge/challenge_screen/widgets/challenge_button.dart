import 'package:flutter/material.dart';

class ChallengeButton extends StatelessWidget {
  const ChallengeButton({
    super.key,
    this.backgroundColor,
    this.text1,
    this.text2,
  });

  final Color? backgroundColor;
  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(),
    );
  }
}
