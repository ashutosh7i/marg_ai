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
        {'code': 'en', 'name': 'English (English)'},
        {'code': 'hi', 'name': 'हिंदी (Hindi)'},
        {'code': 'mr', 'name': 'मराठी (Marathi)'},
        {'code': 'or', 'name': 'ଓଡ଼ିଆ (Odia)'},
        {'code': 'bg', 'name': 'বাংলা (Bengali)'},
        {'code': 'kn', 'name': 'kannad'},
        {'code': 'gu', 'name': 'ગુજરાતી (Gujarati)'},
        {'code': 'ml', 'name': 'മലയാളം (Malayalam)'},
        {'code': 'ne', 'name': 'नेपाली (Nepali)'},
        {'code': 'as', 'name': 'asmase'},
        {'code': 'ta', 'name': 'தமிழ் (Tamil)'},
        {'code': 'pa', 'name': 'panjabi'},
        {'code': 'te', 'name': 'తెలుగు (Telugu)'},
      ];
}
