import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// نمایش پایین‌صفحه برای گرفتن نام نمایشی از کاربر - بدون رمز و بدون ثبت‌نام رسمی.
/// اگر کاربر نامی ثبت کند، مقدار true برمی‌گردد و نام روی گوشی ذخیره شده است.
Future<void> showNamePromptSheet({
  required BuildContext context,
  required AppPalette palette,
  required Future<void> Function(String name) onConfirm,
}) {
  final controller = TextEditingController();
  return showModalBottomSheet(
    context: context,
    backgroundColor: palette.card,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('یک نام برای خودت انتخاب کن',
                style: TextStyle(color: palette.text, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            Text('نیازی به ثبت‌نام یا رمز عبور نیست — همین نام زیر نظرات و امتیازهایت نمایش داده می‌شود',
                style: TextStyle(color: palette.textDim, fontSize: 11.5)),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'مثلاً: پرنیا',
                filled: true,
                fillColor: palette.inputBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide(color: palette.border)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('انصراف'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppAccent.rose, foregroundColor: Colors.white),
                    onPressed: () async {
                      final name = controller.text.trim();
                      if (name.isEmpty) return;
                      await onConfirm(name);
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('ثبت و ادامه'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
