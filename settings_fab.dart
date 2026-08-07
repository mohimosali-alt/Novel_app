import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_settings.dart';
import '../theme/app_theme.dart';

/// دکمه شناور تنظیمات که روی همه صفحات (خانه، سرچ، پروفایل، خواندن) نمایش داده می‌شود.
class SettingsFab extends StatelessWidget {
  const SettingsFab({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final p = settings.palette;

    return Positioned(
      top: 14,
      left: 14,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => _openSheet(context, settings, p),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: p.card,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 14, offset: Offset(0, 4))],
            ),
            child: const Icon(Icons.settings_rounded, size: 18, color: AppAccent.rose),
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context, AppSettings settings, AppPalette p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: p.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Consumer<AppSettings>(
          builder: (ctx, s, _) {
            final pal = s.palette;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('نمایش و خواندن', style: TextStyle(color: pal.text, fontWeight: FontWeight.bold, fontSize: 14)),
                      IconButton(icon: Icon(Icons.close, size: 18, color: pal.textDim), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _label(pal, 'حالت نمایش'),
                  Row(
                    children: [
                      Expanded(
                        child: _choiceButton(
                          label: 'روشن', icon: Icons.light_mode_rounded, selected: !s.isDark, pal: pal,
                          onTap: () => s.setDark(false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _choiceButton(
                          label: 'تیره', icon: Icons.dark_mode_rounded, selected: s.isDark, pal: pal,
                          onTap: () => s.setDark(true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _label(pal, 'فونت'),
                  Row(
                    children: AppFontChoice.values.map((f) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: _choiceButton(label: f.label, selected: s.font == f, pal: pal, onTap: () => s.setFont(f)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  _label(pal, 'اندازه متن'),
                  Row(
                    children: AppTextScale.values.map((sc) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: _choiceButton(label: sc.label, selected: s.textScale == sc, pal: pal, onTap: () => s.setTextScale(sc), small: true),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _label(AppPalette pal, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 4),
        child: Text(text, style: TextStyle(color: pal.textDim, fontWeight: FontWeight.bold, fontSize: 11.5)),
      );

  Widget _choiceButton({
    required String label,
    IconData? icon,
    required bool selected,
    required AppPalette pal,
    required VoidCallback onTap,
    bool small = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: small ? 10 : 12),
        decoration: BoxDecoration(
          color: selected ? AppAccent.rose : pal.inputBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: selected ? Colors.white : pal.textDim),
              const SizedBox(width: 6),
            ],
            Text(label, style: TextStyle(fontSize: small ? 12 : 12.5, fontWeight: FontWeight.bold, color: selected ? Colors.white : pal.textDim)),
          ],
        ),
      ),
    );
  }
}
