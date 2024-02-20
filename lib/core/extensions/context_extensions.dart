import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/settings/layout_settings.dart';
import 'package:wiwalk_app/core/theme/c_colors.dart';
import 'package:wiwalk_app/core/theme/c_text_styles.dart';

///
/// Note: get-4.6.3 - Сангийн context_extensions.dart санг хуулж оруулав
///
extension ContextExtensionss on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;

  /// Gives you the power to get a portion of the height.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the height
  ///
  /// [reducedBy] is a percentage value of how much of the height you want
  /// if you for example want 46% of the height, then you reduce it by 56%.
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (mediaQuerySize.height -
            ((mediaQuerySize.height / 100) * reducedBy)) /
        dividedBy;
  }

  /// Gives you the power to get a portion of the width.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the width
  ///
  /// [reducedBy] is a percentage value of how much of the width you want
  /// if you for example want 46% of the width, then you reduce it by 56%.
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (mediaQuerySize.width - ((mediaQuerySize.width / 100) * reducedBy)) /
        dividedBy;
  }

  /// Divide the height proportionally by the given value
  double ratio({
    double dividedBy = 1,
    double reducedByW = 0.0,
    double reducedByH = 0.0,
  }) {
    return heightTransformer(dividedBy: dividedBy, reducedBy: reducedByH) /
        widthTransformer(dividedBy: dividedBy, reducedBy: reducedByW);
  }

  /// similar to [MediaQuery.of(context).padding]
  ThemeData get theme => Theme.of(this);

  /// Custom colors
  CColors get colors => Theme.of(this).extension<CColors>()!;

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  /// similar to [MediaQuery.of(context).padding]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Custom text styles
  CTextStyles get textStyles => Theme.of(this).extension<CTextStyles>()!;

  /// similar to [MediaQuery.of(context).padding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// similar to [MediaQuery.of(context).padding]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  /// similar to [MediaQuery.of(context).viewInsets]
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  /// similar to [MediaQuery.of(context).orientation]
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// check if device is on landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// similar to [MediaQuery.of(this).textScaleFactor]
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if width be larger than 800
  bool get showNavbar => (width > 800);

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => (mediaQueryShortestSide < 600);

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  int get gridCrossAxisCount {
    if (width <= 475) {
      return 2;
    } else if (width > 475 && width <= 650) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
  T responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? watch,
  }) {
    var deviceWidth = mediaQuerySize.shortestSide;
    if (isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }
    if (deviceWidth >= 1200 && desktop != null) {
      return desktop;
    } else if (deviceWidth >= 600 && tablet != null) {
      return tablet;
    } else if (deviceWidth < 300 && watch != null) {
      return watch;
    } else {
      return mobile!;
    }
  }

  // Is Phone screen size is mini
  // iPhone 5s width = 320.0, height = 568.0
  // iPhone 6 width = 375.0, height = 667.0
  // iPhone 8 width = 375.0
  // iPad Pro 12.9-inch 5th gen
  bool get isMiniScreen =>
      MediaQuery.of(this).size.width <= 320.0 ||
      MediaQuery.of(this).size.height <= 568.0;

  ///
  /// Column count calculator
  /// Validation: 0 < [columnSpan] <= 4
  ///
  int columnCount(double columnSpan) {
    // Validation
    if (columnSpan <= 0 || columnSpan > 4) {
      return 1;
    }

    double columnCount = 1;
    double width = MediaQuery.of(this).size.width;

    if (width <= LayoutSettings.phone.width) {
      columnCount = LayoutSettings.phone.columns / columnSpan;
    } else if (width <= LayoutSettings.smallTablet.width) {
      columnCount = LayoutSettings.smallTablet.columns / columnSpan;
    } else {
      // Laptop, Desktop
      columnCount = LayoutSettings.bigTablet.columns / columnSpan;
    }

    return columnCount.floor();
  }

  double bottomPadding({double height = 24.0}) {
    if (Platform.isAndroid) {
      return mediaQueryPadding.bottom + height;
    } else {
      return mediaQueryPadding.bottom;
    }
  }
}
