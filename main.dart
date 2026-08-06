import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'state/app_settings.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = AppSettings();
  await settings.load();
  runApp(
    ChangeNotifierProvider.value(
      value: settings,
      child: const RootApp(),
    ),
  );
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    return MaterialApp(
      title: 'کتاب‌یار',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: settings.font.fontFamily,
        colorSchemeSeed: AppAccent.rose,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: settings.font.fontFamily,
        colorSchemeSeed: AppAccent.rose,
        brightness: Brightness.dark,
      ),
      themeMode: settings.themeMode,
      home: const NovelApp(),
    );
  }
}
