import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? '',
        textAlign: TextAlign.start,
        style: context.textStyles.heading16?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
