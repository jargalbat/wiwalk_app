enum ButtonSettings {
  small(height: MButtonSize.smallHeight, elevation: 0.0),
  medium(height: MButtonSize.mediumHeight, elevation: 0.0),
  large(height: MButtonSize.largeHeight, elevation: 0.0);

  final double height;
  final double elevation;

  const ButtonSettings({
    required this.height,
    required this.elevation,
  });
}

class MButtonSize {
  // Box decoration
  static const borderRadius = 8.0;

  // Default
  static const largeHeight = 52.0;
  static const mediumHeight = 44.0;
  static const smallHeight = 34.0;
}
