import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavItem {
  final String id;
  final String label;
  final IconData icon;
  const BottomNavItem(this.id, this.label, this.icon);
}

const bottomNavItems = [
  BottomNavItem('home', 'خانه', Icons.home_rounded),
  BottomNavItem('search', 'جست‌وجو', Icons.search_rounded),
  BottomNavItem('library', 'کتابخانه', Icons.menu_book_rounded),
  BottomNavItem('profile', 'پروفایل', Icons.person_rounded),
];

class AppBottomNav extends StatelessWidget {
  final String active;
  final ValueChanged<String> onChange;
  final AppPalette palette;

  const AppBottomNav({super.key, required this.active, required this.onChange, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: palette.card,
        border: Border(top: BorderSide(color: palette.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bottomNavItems.map((it) {
          final isActive = it.id == active;
          final color = isActive ? AppAccent.rose : palette.textDim;
          return InkWell(
            onTap: () => onChange(it.id),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(it.icon, size: 20, color: color),
                const SizedBox(height: 2),
                Text(it.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
