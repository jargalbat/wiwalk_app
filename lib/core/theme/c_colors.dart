import 'package:flutter/material.dart';

///
/// Note
/// Read more: https://developer.apple.com/design/human-interface-guidelines/foundations/color
///

@immutable
class CColors extends ThemeExtension<CColors> {
  const CColors({
    required this.green,
    required this.red,
    required this.orange,
    required this.mint,
    required this.black,
    required this.purple,
    required this.teal,
    required this.gift,
    required this.rental,
    required this.promo,
    required this.gray120,
    required this.gray60,
    required this.gray100,
    required this.gray40,
    required this.gray140,
    required this.gray80,
    required this.text,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.icon,
    required this.icon2,
    required this.icon3,
    required this.cardShadow,
    required this.tint,
    required this.imageBorder,
  });

  /// --------------------------------------------------------------------------
  /// System colors
  /// --------------------------------------------------------------------------
  final Color? green;

  /// ebook
  final Color? red;

  /// Audio book
  final Color? orange;

  /// Summary
  final Color? mint;

  final Color? black; // todo хасах

  /// Podcast
  final Color? purple;

  final Color? teal;

  // iOS colors
  // FF3B2F, FF9500, FFCD00, 35C759, 06C7BE, 30B0C7, 31AEE6, 007AFE, 5956D6, AE51DE, FF2C55, A2845D

  /// --------------------------------------------------------------------------
  /// Service color
  /// --------------------------------------------------------------------------

  /// Gift
  final Color? gift;

  /// Rental
  final Color? rental;

  /// Promo
  final Color? promo;

  /// --------------------------------------------------------------------------
  /// System gray colors
  /// --------------------------------------------------------------------------
  final Color? gray40; // Gray (6)
  final Color? gray60; // Gray (5)
  final Color? gray80; // Gray (4)
  final Color? gray100; // Gray (3)
  final Color? gray120; // Gray (2)
  final Color? gray140; // Gray

  /// --------------------------------------------------------------------------
  /// Text
  /// --------------------------------------------------------------------------

  /// Primary - Black
  final Color? text;

  /// Secondary - Gray
  final Color? text2;

  /// Tertiary - Gray
  final Color? text3;

  /// Quaternary - Gray
  final Color? text4;

  /// Quinary - White
  final Color? text5;

  /// --------------------------------------------------------------------------
  /// Icon
  /// --------------------------------------------------------------------------

  /// Primary - Blue
  final Color? icon;

  /// Secondary - Gray
  final Color? icon2;

  /// Tertiary - White
  final Color? icon3;

  /// --------------------------------------------------------------------------
  /// Component
  /// --------------------------------------------------------------------------
  final Color? cardShadow;
  final Color? tint; // Slider
  final Color? imageBorder;

  @override
  CColors copyWith({
    Color? brand,
    Color? green,
    Color? red,
    Color? orange,
    Color? mint,
    Color? black,
    Color? purple,
    Color? teal,
    Color? gift,
    Color? rental,
    Color? promo,
    Color? gray40,
    Color? gray60,
    Color? gray80,
    Color? gray100,
    Color? gray120,
    Color? gray140,
    Color? text,
    Color? text2,
    Color? text3,
    Color? text4,
    Color? text5,
    Color? icon,
    Color? icon2,
    Color? icon3,
    Color? component,
    Color? cardShadow,
    Color? tint,
    Color? imageBorder,
  }) {
    return CColors(
      green: green ?? this.green,
      red: red ?? this.red,
      orange: orange ?? this.orange,
      mint: mint ?? this.mint,
      black: black ?? this.black,
      purple: purple ?? this.purple,
      teal: teal ?? this.teal,
      gift: gift ?? this.gift,
      rental: rental ?? this.rental,
      promo: promo ?? this.promo,
      gray40: gray40 ?? this.gray40,
      gray60: gray60 ?? this.gray60,
      gray80: gray80 ?? this.gray80,
      gray100: gray100 ?? this.gray100,
      gray120: gray120 ?? this.gray120,
      gray140: gray140 ?? this.gray140,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      text4: text4 ?? this.text4,
      text5: text5 ?? this.text5,
      icon: icon ?? this.icon,
      icon2: icon2 ?? this.icon2,
      icon3: icon3 ?? this.icon3,
      cardShadow: cardShadow ?? this.cardShadow,
      tint: tint ?? this.tint,
      imageBorder: imageBorder ?? this.imageBorder,
    );
  }

  @override
  CColors lerp(ThemeExtension<CColors>? other, double t) {
    if (other is! CColors) {
      return this;
    }
    return CColors(
      green: Color.lerp(green, other.green, t),
      red: Color.lerp(red, other.red, t),
      orange: Color.lerp(orange, other.orange, t),
      mint: Color.lerp(mint, other.mint, t),
      black: Color.lerp(black, other.black, t),
      purple: Color.lerp(purple, other.purple, t),
      teal: Color.lerp(teal, other.teal, t),
      gift: Color.lerp(gift, other.gift, t),
      rental: Color.lerp(rental, other.rental, t),
      promo: Color.lerp(promo, other.promo, t),
      gray40: Color.lerp(gray40, other.gray40, t),
      gray60: Color.lerp(gray60, other.gray60, t),
      gray80: Color.lerp(gray80, other.gray80, t),
      gray100: Color.lerp(gray100, other.gray100, t),
      gray120: Color.lerp(gray120, other.gray120, t),
      gray140: Color.lerp(gray140, other.gray140, t),
      text: Color.lerp(text, other.text, t),
      text2: Color.lerp(text2, other.text2, t),
      text3: Color.lerp(text3, other.text3, t),
      text4: Color.lerp(text4, other.text4, t),
      text5: Color.lerp(text5, other.text5, t),
      icon: Color.lerp(icon, other.icon, t),
      icon2: Color.lerp(icon2, other.icon2, t),
      icon3: Color.lerp(icon3, other.icon3, t),
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t),
      tint: Color.lerp(tint, other.tint, t),
      imageBorder: Color.lerp(imageBorder, other.imageBorder, t),
    );
  }

  // Optional
  @override
  String toString() => '''
    MyColors(
      green: $green,
      red: $red,
      orange: $orange,
      mint: $mint,
      black: $black,
      purple: $purple,
      teal: $teal,
      gift: $gift,
      rental: $rental,
      promo: $promo,
      gray40: $gray40,
      gray60: $gray60,
      gray80: $gray80,
      gray100: $gray100,
      gray120: $gray120,      
      gray140: $gray140,
      text: $text,
      text2: $text2,
      text3: $text3,
      text4: $text4,
      text5: $text5,
      icon: $icon,
      icon2: $icon2,
      icon3: $icon3,
      cardShadow: $cardShadow,
      tint: $tint,
      imageBorder: $imageBorder,
    )
  ''';
}
