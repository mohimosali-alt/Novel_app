import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/book.dart';
import 'state/app_settings.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reader_screen.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/settings_fab.dart';

class NovelApp extends StatefulWidget {
  const NovelApp({super.key});

  @override
  State<NovelApp> createState() => _NovelAppState();
}

class _NovelAppState extends State<NovelApp> {
  String tab = 'home';
  Book? activeBook;

  void _openBook(Book b) => setState(() => activeBook = b);
  void _closeBook() => setState(() => activeBook = null);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final p = settings.palette;

    Widget body;
    if (activeBook != null) {
      body = ReaderScreen(book: activeBook!, onBack: _closeBook);
    } else {
      switch (tab) {
        case 'search':
          body = SearchScreen(onOpenBook: _openBook);
          break;
        case 'library':
          body = HomeScreen(onOpenBook: _openBook);
          break;
        case 'profile':
          body = const ProfileScreen();
          break;
        default:
          body = HomeScreen(onOpenBook: _openBook);
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: p.bg,
        body: Stack(
          children: [
            SafeArea(child: body),
            const SafeArea(child: SettingsFab()),
          ],
        ),
        bottomNavigationBar: activeBook == null
            ? AppBottomNav(active: tab, onChange: (t) => setState(() => tab = t), palette: p)
            : null,
      ),
    );
  }
}
