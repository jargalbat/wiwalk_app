import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';
import 'c_colors.dart';
import 'c_font_size.dart';
import 'c_size.dart';
import 'c_text_styles.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
      : super((sharedPref.getString(SharedPrefKeys.themeMode) ??
                    ThemeMode.light.name) ==
                ThemeMode.light.name
            ? ThemeMode.light
            : ThemeMode.dark);

  ///
  /// Light theme
  ///
  static final lightTheme = ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      CColors(
        primaryLight: const Color(0xFFE2F5FA),
        green: const Color(0xFF34C750),
        red: _red,
        // red: const Color(0xFFff3b30),
        orange: const Color(0xFFFFAF27),
        // orange: const Color(0xFFFF9500),
        mint: const Color(0xFF0DC9C9),
        // mint: const Color(0xFF00c7be),
        black: Colors.black,
        purple: const Color(0xFF9462CF),
        // purple: const Color(0xFFAF52DE),
        teal: const Color(0xFF30B0C7),
        gift: const Color(0xFFED6C54),
        rental: const Color(0xFF285FF6),
        // rental: const Color(0xFF030142),
        promo: const Color(0xFFEB4462),
        gray40: _gray40Light,
        gray60: _gray60Light,
        gray80: const Color(0xFFd1d1d6),
        gray100: _gray100Light,
        gray120: _gray120Light,
        gray140: _gray140Light,
        text: Colors.black,
        text2: _text2Light,
        text3: _text3Light,
        text4: const Color(0xFFD8D8D9),
        text5: Colors.white,
        icon: _gray120Light,
        icon2: _gray100Light,
        icon3: Colors.white,
        cardShadow: _cardShadow,
        tint: const Color(0xFFC9DBFB),
        imageBorder: _gray140Light.withOpacity(0.2),
      ),
      const CTextStyles(
        bigTitle: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.bigTitle,
          fontWeight: FontWeight.bold,
        ),
        heading20: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.heading20,
          fontWeight: FontWeight.bold,
        ),
        heading16: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.heading16,
        ),
        body14: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.body14,
        ),
        body12: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.body12,
        ),
        caption: TextStyle(
          color: Colors.black,
          fontSize: CFontSize.caption,
        ),
      ),
    ],

    /// Main
    brightness: Brightness.light,
    primaryColor: _primary,
    fontFamily: 'Manrope',
    indicatorColor: _primary,
    dividerColor: _gray100Light,

    /// Background
    // backgroundColor: _backgroundLight, // deprecated covertted into ColorScheme
    scaffoldBackgroundColor: _primaryBgLight,

    ///Bottom app bar color
    // bottomAppBarColor: backgroundLight,

    /// Icon
    primaryIconTheme: const IconThemeData(color: _primary),
    iconTheme: const IconThemeData(color: _gray100Light),

    /// App bar
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: _primaryBgLight,
      //Colors.white\
      iconTheme: IconThemeData(
        color: _primary,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    ),

    /// Card
    cardTheme: const CardTheme(color: _secondaryBgLight),
    cardColor: _secondaryBgLight,

    /// TextField
    textSelectionTheme: const TextSelectionThemeData(),
    hintColor: _text3Light,
    // errorColor: _red, // deprecated covertted into ColorScheme

    /// Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: _gray100Light.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
    ),

    /// Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        // primary: gray100Light.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSize.buttonBorderRadius8),
        ),
        elevation: 0.0,
      ),
    ),

    /// Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // padding: const EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
        side: const BorderSide(width: 1.0, color: _primary),
        elevation: 0.0,
        // primary: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSize.buttonBorderRadius8),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return _primary;
          } else {
            return _gray100Light;
          }
        },
      ),
    ),

    /// Tabbar
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      labelStyle:
          const TextStyle(color: Colors.black, fontSize: CFontSize.body14),
      // indicator: UnderlineTabIndicator(
      //   borderSide: BorderSide(color: primary),
      // ),
      indicator: BoxDecoration(
        color: _gray60Light.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      error: _red,
      background: _primaryBgLight,
      primary: _primary,
    ),

    /// Outlined button
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     primary: Colors.black87,
    //     // minimumSize: const Size(88, 32),
    //     padding: const EdgeInsets.all(10.0),
    //     side: const BorderSide(width: 1.0, color: primaryColor),
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(10),
    //       ),
    //     ),
    //   ),
    // ),

    /// Text
    // textTheme: GoogleFonts.manropeTextTheme(),
  );

  ///
  /// Dark theme
  ///
  static final darkTheme = ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      CColors(
        primaryLight: const Color(0xFFE2F5FA),
        green: const Color(0xFF30D158),
        red: _red,
        // red: const Color(0xFFff3b30),
        orange: const Color(0xFFFFAF27),
        // orange: const Color(0xFFFF9F0A),
        mint: const Color(0xFF0DC9C9),
        // mint: const Color(0xFF66d4cf),
        black: const Color(0xFF1F1F1F),
        purple: const Color(0xFF9462CF),
        // purple: const Color(0xFFBF5AF2),
        teal: const Color(0xFF40C8E0),
        gift: const Color(0xFFED6C54),
        rental: const Color(0xFF285FF6),
        // rental: const Color(0xFF030142),
        promo: const Color(0xFFEB4462),
        gray40: _gray40Dark,
        gray60: _gray60Dark,
        gray80: const Color(0xFF3a3a3c),
        gray100: _gray100Dark,
        gray120: _gray120Dark,
        gray140: const Color(0xFF8e8e93),
        text: Colors.white,
        text2: _text2Dark,
        text3: _text3Dark,
        text4: const Color(0xFF505055),
        text5: Colors.black,
        icon: _text2Dark,
        icon2: _gray100Dark,
        icon3: Colors.black,
        cardShadow: _cardShadow,
        tint: const Color(0xFFC9DBFB),
        imageBorder: _gray140Dark.withOpacity(0.2),
      ),
      const CTextStyles(
        bigTitle: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.bigTitle,
          fontWeight: FontWeight.bold,
        ),
        heading20: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.heading20,
          fontWeight: FontWeight.bold,
        ),
        heading16: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.heading16,
        ),
        body14: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.body14,
        ),
        body12: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.body12,
        ),
        caption: TextStyle(
          color: Colors.white,
          fontSize: CFontSize.caption,
        ),
      ),
    ],

    /// Main
    brightness: Brightness.dark,
    primaryColor: _primary,
    fontFamily: 'Manrope',
    indicatorColor: _primary,
    dividerColor: _gray100Dark,

    /// Background
    // backgroundColor: _backgroundDark, deprecated converted into ColorScheme
    scaffoldBackgroundColor: _primaryBgDark,

    ///Bottom app bar color
    // bottomAppBarColor: backgroundDark,

    /// Icon
    primaryIconTheme: const IconThemeData(color: _primary),
    iconTheme: const IconThemeData(color: _gray100Dark),

    /// App bar
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: _primaryBgDark,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    ),

    /// Card
    cardTheme: const CardTheme(color: _secondaryBgDark),
    cardColor: _secondaryBgDark,

    /// TextField
    textSelectionTheme: const TextSelectionThemeData(),
    hintColor: _text3Dark,
    // errorColor: _red, deprecated covnverted into ColorScheme
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: _secondaryBgLight,
    ),

    /// Buttons
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: _gray100Dark.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        // primary: gray100Dark.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSize.buttonBorderRadius8),
        ),
        elevation: 0.0,
      ),
    ),

    /// Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // padding: const EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
        side: const BorderSide(width: 1.0, color: _primary),
        elevation: 0.0,
        // primary: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSize.buttonBorderRadius8),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return _primary;
          } else {
            return _gray100Dark;
          }
        },
      ),
    ),

    tabBarTheme: TabBarTheme(
      // labelColor: Colors.black,
      // labelStyle:
      //     const TextStyle(color: Colors.black, fontSize: CFontSize.body14),
      // indicator: UnderlineTabIndicator(
      //   borderSide: BorderSide(color: primary),
      // ),
      indicator: BoxDecoration(
        color: _gray60Dark.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      error: _red,
      background: _primaryBgDark,
      primary: _primary,
      // secondary: Colors.white,
    ),

    /// Text
    // textTheme: GoogleFonts.manropeTextTheme(),
  );

  void toggleTheme() {
    // Current
    String themeModeName =
        sharedPref.getString(SharedPrefKeys.themeMode) ?? ThemeMode.light.name;

    ThemeMode themeMode = themeModeName == ThemeMode.light.name
        ? ThemeMode.light
        : ThemeMode.dark;

    // Toggle
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    // Change theme
    emit(themeMode);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness:
            themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.light : Brightness.light,
      ),
    );

    // Cache
    sharedPref.setString(
      SharedPrefKeys.themeMode,
      themeMode == ThemeMode.light ? ThemeMode.light.name : ThemeMode.dark.name,
    );
  }

  /// Note: Эдгээр өнгөнүүдийг зөвхөн theme дотор ашиглана.
  /// Дурын газар хатуугаар бичиж ашиглахгүй болохыг анхаарна уу!
  /// Өнгөний нэршил: https://chir.ag/projects/name-that-color/
  static const _primary = Color(0xFF1797B2);

  static const _red = Color(0xFFFF555D);

  static const _gray40Light = Color(0xFFf2f2f7);
  static const _gray40Dark = Color(0xFF1c1c1e);
  static const _gray60Light = Color(0xFFe5e5ea);
  static const _gray60Dark = Color(0xFF2c2c2e);
  static const _gray100Light = Color(0xFFc7c7cc);
  static const _gray100Dark = Color(0xFF48484a);
  static const _gray120Light = Color(0xFFaeaeb2);
  static const _gray120Dark = Color(0xFF636366);
  static const _gray140Light = Color(0xFF8e8e93);
  static const _gray140Dark = Color(0xFF8e8e93);

  static const _text2Light = Color(0xFF505055);
  static const _text2Dark = Color(0xFFD8D8D9);
  static const _text3Light = Color(0xFF9E9EA1);
  static const _text3Dark = Color(0xFF9E9EA1);

  static const _primaryBgLight = Colors.white;
  static const _primaryBgDark = Colors.black;
  static const _secondaryBgLight = Color(0xFFF1F4F9);
  static const _secondaryBgDark = _gray40Dark;

  static final _cardShadow = const Color(0xFF48555C).withOpacity(0.1);
}
