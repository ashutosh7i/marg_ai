import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'preferred_language';
  final SharedPreferences prefs;
  Locale _currentLocale;

  LanguageProvider(this.prefs)
      : _currentLocale = Locale(prefs.getString(_languageKey) ?? 'en');

  Locale get currentLocale => _currentLocale;

  Future<void> setLocale(String languageCode) async {
    if (_currentLocale.languageCode != languageCode) {
      _currentLocale = Locale(languageCode);
      await prefs.setString(_languageKey, languageCode);
      notifyListeners();
    }
  }

  static List<Map<String, String>> get supportedLanguages => [
        {'code': 'en', 'name': 'English'},
        {'code': 'hi', 'name': 'हिंदी'},
        {'code': 'mr', 'name': 'मराठी'},
      ];
}
