import 'package:flutter/material.dart';

@immutable
class CTextStyles extends ThemeExtension<CTextStyles> {
  const CTextStyles({
    required this.bigTitle,
    required this.heading20,
    required this.heading16,
    required this.body14,
    required this.body12,
    required this.caption,
  });

  final TextStyle? bigTitle;
  final TextStyle? heading20;
  final TextStyle? heading16;
  final TextStyle? body14;
  final TextStyle? body12;
  final TextStyle? caption;

  @override
  CTextStyles copyWith({
    TextStyle? bigTitle,
    TextStyle? heading20,
    TextStyle? heading16,
    TextStyle? body14,
    TextStyle? body12,
    TextStyle? caption,
  }) {
    return CTextStyles(
      bigTitle: bigTitle ?? this.bigTitle,
      heading20: heading20 ?? this.heading20,
      heading16: heading16 ?? this.heading16,
      body14: body14 ?? this.body14,
      body12: body12 ?? this.body12,
      caption: caption ?? this.caption,
    );
  }

  @override
  CTextStyles lerp(ThemeExtension<CTextStyles>? other, double t) {
    if (other is! CTextStyles) {
      return this;
    }
    return CTextStyles(
      bigTitle: TextStyle.lerp(bigTitle, other.bigTitle, t),
      heading20: TextStyle.lerp(heading20, other.heading20, t),
      heading16: TextStyle.lerp(heading16, other.heading16, t),
      body14: TextStyle.lerp(body14, other.body14, t),
      body12: TextStyle.lerp(body12, other.body12, t),
      caption: TextStyle.lerp(caption, other.caption, t),
    );
  }

  // Optional
  @override
  String toString() => '''
    MTextStyles(
      bigTitle: $bigTitle,
      heading20: $heading20,
      heading16: $heading16, 
      body14: $body14,
      body12: $body12, 
      caption: $caption, 
    )
  ''';
}
