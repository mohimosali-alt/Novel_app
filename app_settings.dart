import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

/// تنظیمات کلی اپ: حالت روشن/تیره، فونت، اندازه متن و نام نمایشی کاربر.
/// همه این‌ها روی خود گوشی ذخیره می‌شوند (نه سرور) — هماهنگ با تصمیم
/// «کامنت‌گذاری بدون نیاز به ثبت‌نام رسمی».
class AppSettings extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  AppFontChoice _font = AppFontChoice.sans;
  AppTextScale _textScale = AppTextScale.md;
  String _displayName = '';

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;
  AppFontChoice get font => _font;
  AppTextScale get textScale => _textScale;
  String get displayName => _displayName;

  AppPalette get palette => isDark ? AppPalette.dark : AppPalette.light;

  static const _kTheme = 'settings_theme_dark';
  static const _kFont = 'settings_font';
  static const _kScale = 'settings_scale';
  static const _kName = 'settings_display_name';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = (prefs.getBool(_kTheme) ?? false) ? ThemeMode.dark : ThemeMode.light;
    _font = AppFontChoice.values[prefs.getInt(_kFont) ?? 0];
    _textScale = AppTextScale.values[prefs.getInt(_kScale) ?? 1];
    _displayName = prefs.getString(_kName) ?? '';
    notifyListeners();
  }

  Future<void> setDark(bool dark) async {
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kTheme, dark);
  }

  Future<void> setFont(AppFontChoice f) async {
    _font = f;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kFont, f.index);
  }

  Future<void> setTextScale(AppTextScale s) async {
    _textScale = s;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kScale, s.index);
  }

  Future<void> setDisplayName(String name) async {
    _displayName = name;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
  }
}
