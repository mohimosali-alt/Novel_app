import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_settings.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool editing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final name = context.read<AppSettings>().displayName;
    editing = name.isEmpty;
    controller = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final p = settings.palette;
    final name = settings.displayName;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          color: p.headerBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('پروفایل', style: TextStyle(color: p.headerText, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [AppAccent.rose, AppAccent.blush]),
                    ),
                    alignment: Alignment.center,
                    child: Text(name.isEmpty ? '؟' : name.characters.first, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: editing
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: 'نام نمایشی خود را بنویس',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.15),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppAccent.blush, foregroundColor: AppAccent.plum),
                                onPressed: () {
                                  final v = controller.text.trim();
                                  if (v.isEmpty) return;
                                  settings.setDisplayName(v);
                                  setState(() => editing = false);
                                },
                                child: const Text('ثبت', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                              InkWell(onTap: () => setState(() => editing = true), child: Icon(Icons.edit, size: 14, color: p.headerSub)),
                            ],
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('این نام زیر نظرات و امتیازهایت نمایش داده می‌شود', style: TextStyle(color: p.headerSub, fontSize: 11)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              Text('بدون نیاز به رمز عبور یا شماره موبایل — فقط یک نام برای شناخته‌شدن در نظرات',
                  style: TextStyle(color: p.textDim, fontSize: 11)),
              const SizedBox(height: 8),
              ...['در حال مطالعه (۳)', 'علاقه‌مندی‌ها', 'درباره ما'].map((item) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.border))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item, style: TextStyle(color: p.text, fontWeight: FontWeight.w600, fontSize: 13)),
                        Icon(Icons.chevron_left_rounded, size: 18, color: p.textDim),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
