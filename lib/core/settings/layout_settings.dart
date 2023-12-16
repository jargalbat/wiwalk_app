///
/// Note
/// 12 баганатай grid system
/// https://m2.material.io/design/layout/understanding-layout.html#layout-anatomy
///

enum LayoutSettings {
  /// Extra-small
  /// Column 4 (0-599dp)
  // iPhone5(width: 320.0, height: 568.0, columns: 4),
  // iPhone6(width: 375.0, height: 667.0, columns: 4),
  // iPhone8(width: 375.0, height: 667.0, columns: 4),
  // galaxyA52(width: 411.4, height: 899.4, columns: 4),
  // iPhone14Pro(width: , height: ), // 6.1-inch
  // iPhone14ProMax(width: 430.0, height: 932.0, columns: 4), // 6.69-inch
  phone(
    width: 599.0,
    height: 599.0,
    margin: 16.0,
    body: double.infinity,
    columns: 4,
  ),

  /// Small
  /// Column 8 (600-904)
  // iPadMini6(width: 744.0, height: 1133.0, columns: 8),
  smallTablet(
    width: 904.0,
    height: 904.0,
    margin: 32.0,
    body: double.infinity,
    columns: 8,
  ),

  /// Column 12 (905-1239)
  bigTablet(
    width: 1239.0,
    height: 1239.0,
    margin: double.infinity,
    body: 840.0,
    columns: 12,
  ),

  /// Medium
  /// Column 12 (1240-1439)
  laptop(
    width: 1439.0,
    height: 1439.0,
    margin: 200.0,
    body: double.infinity,
    columns: 12,
  ),
  // iPadPro5(width: 1024.0, height: 1366.0, columns: 12), // 12.9-inch

  /// Large
  /// Column 12 (1440+)
  desktop(
    width: 1440.0,
    // minimum width
    height: 1440.0,
    margin: double.infinity,
    body: 1040.0,
    columns: 12,
  ),
  ;

  final double height;
  final double width;
  final double margin;
  final double body;
  final int columns;

  const LayoutSettings({
    required this.height,
    required this.width,
    required this.margin,
    required this.body,
    required this.columns,
  });
}
