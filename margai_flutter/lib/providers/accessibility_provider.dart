import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ColorBlindnessType {
  none,
  deuteranopia, // Red blindness
  protanopia, // Green blindness
  tritanopia, // Blue blindness
  monochromacy // Total color blindness
}

class AccessibilityProvider extends ChangeNotifier {
  static const String _highContrastKey = 'high_contrast_mode';
  static const String _largeTextKey = 'large_text_mode';
  static const String _reducedMotionKey = 'reduced_motion';
  static const String _textScaleKey = 'text_scale_factor';
  static const String _colorBlindnessKey = 'color_blindness_type';

  final SharedPreferences prefs;
  bool _highContrastMode;
  bool _largeTextMode;
  bool _reducedMotion;
  double _textScaleFactor;
  ColorBlindnessType _colorBlindnessType;

  AccessibilityProvider(this.prefs)
      : _highContrastMode = prefs.getBool(_highContrastKey) ?? false,
        _largeTextMode = prefs.getBool(_largeTextKey) ?? false,
        _reducedMotion = prefs.getBool(_reducedMotionKey) ?? false,
        _textScaleFactor = prefs.getDouble(_textScaleKey) ?? 1.0,
        _colorBlindnessType =
            ColorBlindnessType.values[prefs.getInt(_colorBlindnessKey) ?? 0];

  bool get highContrastMode => _highContrastMode;
  bool get largeTextMode => _largeTextMode;
  bool get reducedMotion => _reducedMotion;
  double get textScaleFactor => _textScaleFactor;
  ColorBlindnessType get colorBlindnessType => _colorBlindnessType;

  Future<void> toggleHighContrast() async {
    _highContrastMode = !_highContrastMode;
    await prefs.setBool(_highContrastKey, _highContrastMode);
    notifyListeners();
  }

  Future<void> toggleLargeText() async {
    _largeTextMode = !_largeTextMode;
    await prefs.setBool(_largeTextKey, _largeTextMode);
    if (_largeTextMode) {
      await setTextScale(1.2);
    } else {
      await setTextScale(1.0);
    }
    notifyListeners();
  }

  Future<void> toggleReducedMotion() async {
    _reducedMotion = !_reducedMotion;
    await prefs.setBool(_reducedMotionKey, _reducedMotion);
    notifyListeners();
  }

  Future<void> setTextScale(double scale) async {
    _textScaleFactor = scale;
    await prefs.setDouble(_textScaleKey, scale);
    notifyListeners();
  }

  Future<void> setColorBlindnessType(ColorBlindnessType type) async {
    _colorBlindnessType = type;
    await prefs.setInt(_colorBlindnessKey, type.index);
    notifyListeners();
  }

  // Color transformation for color blindness
  Color adaptColorForColorBlindness(Color color) {
    switch (_colorBlindnessType) {
      case ColorBlindnessType.deuteranopia:
        // Convert reds to more distinguishable colors
        return Color.fromRGBO(
          (color.red * 0.625 + color.green * 0.375).round(),
          (color.red * 0.7 + color.green * 0.3).round(),
          color.blue,
          color.opacity,
        );
      case ColorBlindnessType.protanopia:
        // Convert greens to more distinguishable colors
        return Color.fromRGBO(
          color.red,
          (color.green * 0.567 + color.blue * 0.433).round(),
          (color.green * 0.558 + color.blue * 0.442).round(),
          color.opacity,
        );
      case ColorBlindnessType.tritanopia:
        // Convert blues to more distinguishable colors
        return Color.fromRGBO(
          color.red,
          color.green,
          (color.blue * 0.95 + color.red * 0.05).round(),
          color.opacity,
        );
      case ColorBlindnessType.monochromacy:
        // Convert to grayscale
        int gray = ((color.red + color.green + color.blue) ~/ 3);
        return Color.fromRGBO(gray, gray, gray, color.opacity);
      default:
        return color;
    }
  }

  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  Color get backgroundColor => _highContrastMode ? Colors.black : Colors.white;
  Color get primaryTextColor => _highContrastMode ? Colors.yellow : Colors.black;
  Color get secondaryTextColor => _highContrastMode ? Colors.yellow.shade200 : Colors.grey[800]!;
  Color get surfaceColor => _highContrastMode ? Colors.grey[900]! : Colors.white;
  Color get borderColor => _highContrastMode ? Colors.yellow : Colors.grey[300]!;
  Color get inputFillColor => _highContrastMode ? Colors.grey[900]! : Colors.grey[50]!;

  ThemeData getTheme(BuildContext context, ThemeData baseTheme) {
    // Apply color blindness adaptations to colors
    final primaryColor = adaptColorForColorBlindness(Colors.blue);
    final accentColor = adaptColorForColorBlindness(Colors.orange);
    final errorColor = adaptColorForColorBlindness(Colors.red);

    // Create text theme with proper scaling
    final scaledTextTheme = baseTheme.textTheme.copyWith(
      displayLarge: baseTheme.textTheme.displayLarge?.copyWith(fontSize: 96 * _textScaleFactor),
      displayMedium: baseTheme.textTheme.displayMedium?.copyWith(fontSize: 60 * _textScaleFactor),
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(fontSize: 48 * _textScaleFactor),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(fontSize: 34 * _textScaleFactor),
      headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(fontSize: 24 * _textScaleFactor),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(fontSize: 20 * _textScaleFactor),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontSize: 16 * _textScaleFactor),
      titleSmall: baseTheme.textTheme.titleSmall?.copyWith(fontSize: 14 * _textScaleFactor),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(fontSize: 16 * _textScaleFactor),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(fontSize: 14 * _textScaleFactor),
      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(fontSize: 12 * _textScaleFactor),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(fontSize: 14 * _textScaleFactor),
      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(fontSize: 12 * _textScaleFactor),
      labelSmall: baseTheme.textTheme.labelSmall?.copyWith(fontSize: 11 * _textScaleFactor),
    );

    // Create base theme with adapted colors
    ThemeData theme = baseTheme.copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(primaryColor),
        accentColor: accentColor,
        errorColor: errorColor,
        brightness: _highContrastMode ? Brightness.dark : baseTheme.brightness,
      ),
      textTheme: scaledTextTheme,
      primaryTextTheme: scaledTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );

    // Apply high contrast if enabled
    if (_highContrastMode) {
      theme = theme.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: surfaceColor,
        dialogBackgroundColor: backgroundColor,
        popupMenuTheme: PopupMenuThemeData(
          color: surfaceColor,
          textStyle: TextStyle(color: primaryTextColor),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: backgroundColor,
          modalBackgroundColor: backgroundColor,
        ),
        textTheme: scaledTextTheme.apply(
          bodyColor: primaryTextColor,
          displayColor: primaryTextColor,
        ),
        primaryTextTheme: scaledTextTheme.apply(
          bodyColor: primaryTextColor,
          displayColor: primaryTextColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: inputFillColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryTextColor, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: TextStyle(
            color: primaryTextColor,
            fontSize: 16 * _textScaleFactor,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: borderColor,
        ),
        iconTheme: IconThemeData(color: primaryTextColor),
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: primaryTextColor,
          elevation: 4,
          shadowColor: primaryTextColor.withOpacity(0.5),
          iconTheme: IconThemeData(color: primaryTextColor),
          titleTextStyle: TextStyle(
            color: primaryTextColor,
            fontSize: 20 * _textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return theme;
  }

  // Animation duration based on reduced motion preference
  Duration getAnimationDuration(
      {Duration normal = const Duration(milliseconds: 300)}) {
    return _reducedMotion ? Duration.zero : normal;
  }

  // Helper method to get semantic label for screen readers
  String getSemanticLabel(String text) {
    return text;
  }
}
