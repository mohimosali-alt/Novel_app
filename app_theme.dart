import 'package:flutter/material.dart';

/// رنگ‌های اصلی برند - در هر دو حالت روشن و تیره ثابت می‌مانند
class AppAccent {
  static const rose = Color(0xFFB35A8A);
  static const blush = Color(0xFFF6B7C7);
  static const lavender = Color(0xFFB6A5CE);
  static const plum = Color(0xFF523F77);
  static const slate = Color(0xFF7880AE);
  static const powder = Color(0xFFA3BBD7);
}

class AppPalette {
  final Color bg;
  final Color card;
  final Color readBg;
  final Color text;
  final Color textDim;
  final Color readText;
  final Color headerBg;
  final Color headerText;
  final Color headerSub;
  final Color border;
  final Color inputBg;

  const AppPalette({
    required this.bg,
    required this.card,
    required this.readBg,
    required this.text,
    required this.textDim,
    required this.readText,
    required this.headerBg,
    required this.headerText,
    required this.headerSub,
    required this.border,
    required this.inputBg,
  });

  static const light = AppPalette(
    bg: Color(0xFFFAF7FB),
    card: Colors.white,
    readBg: Color(0xFFFFF9F2),
    text: AppAccent.plum,
    textDim: AppAccent.slate,
    readText: Color(0xFF3A2F44),
    headerBg: AppAccent.plum,
    headerText: Colors.white,
    headerSub: AppAccent.powder,
    border: Color(0x33B6A5CE),
    inputBg: Colors.white,
  );

  static const dark = AppPalette(
    bg: Color(0xFF191420),
    card: Color(0xFF241D2E),
    readBg: Color(0xFF1C1720),
    text: Color(0xFFF1E9F5),
    textDim: AppAccent.powder,
    readText: Color(0xFFE7DEE9),
    headerBg: Color(0xFF120E17),
    headerText: Colors.white,
    headerSub: AppAccent.blush,
    border: Color(0x2EB6A5CE),
    inputBg: Color(0xFF2B2334),
  );
}

/// گزینه‌های فونت قابل انتخاب کاربر
enum AppFontChoice { sans, serif, rounded }

extension AppFontChoiceX on AppFontChoice {
  String get label {
    switch (this) {
      case AppFontChoice.sans:
        return 'ساده';
      case AppFontChoice.serif:
        return 'کتابی';
      case AppFontChoice.rounded:
        return 'گرد';
    }
  }

  /// فونت‌های فارسی که باید در پوشه assets/fonts قرار بگیرند (راهنمای README را ببین)
  String get fontFamily {
    switch (this) {
      case AppFontChoice.sans:
        return 'Vazirmatn';
      case AppFontChoice.serif:
        return 'NotoSerifPersian';
      case AppFontChoice.rounded:
        return 'PeydaFaNum';
    }
  }
}

/// اندازه‌های متن قابل انتخاب کاربر (ضریب مقیاس)
enum AppTextScale { sm, md, lg, xl }

extension AppTextScaleX on AppTextScale {
  String get label {
    switch (this) {
      case AppTextScale.sm:
        return 'کوچک';
      case AppTextScale.md:
        return 'متوسط';
      case AppTextScale.lg:
        return 'بزرگ';
      case AppTextScale.xl:
        return 'خیلی بزرگ';
    }
  }

  double get value {
    switch (this) {
      case AppTextScale.sm:
        return 0.88;
      case AppTextScale.md:
        return 1.0;
      case AppTextScale.lg:
        return 1.18;
      case AppTextScale.xl:
        return 1.4;
    }
  }
}
