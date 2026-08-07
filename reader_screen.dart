import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../models/book.dart';
import '../state/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/name_prompt_sheet.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final VoidCallback onBack;
  const ReaderScreen({super.key, required this.book, required this.onBack});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  bool showComments = false;
  int myRating = 0;
  final List<Comment> comments = List.of(sampleComments);
  final draftController = TextEditingController();

  void _postComment(AppSettings settings) {
    final text = draftController.text.trim();
    if (text.isEmpty) return;
    if (settings.displayName.isEmpty) {
      showNamePromptSheet(
        context: context,
        palette: settings.palette,
        onConfirm: (name) async {
          await settings.setDisplayName(name);
          setState(() {
            comments.insert(0, Comment(name: name, text: text));
            draftController.clear();
          });
        },
      );
      return;
    }
    setState(() {
      comments.insert(0, Comment(name: settings.displayName, text: text));
      draftController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final p = settings.palette;
    final scale = settings.textScale.value;

    return Column(
      children: [
        Container(
          color: p.headerBg,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              InkWell(
                onTap: widget.onBack,
                child: Row(children: [const Icon(Icons.chevron_right_rounded, size: 18, color: Colors.white), Text('بازگشت', style: TextStyle(color: Colors.white, fontSize: 13 * scale))]),
              ),
              Expanded(
                child: Text(widget.book.title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13 * scale)),
              ),
              InkWell(onTap: () => setState(() => showComments = true), child: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: AppAccent.blush)),
            ],
          ),
        ),
        Container(height: 3, color: p.border, child: FractionallySizedBox(alignment: Alignment.centerRight, widthFactor: 0.62, child: Container(color: AppAccent.rose))),
        Expanded(
          child: Container(
            color: p.readBg,
            child: showComments ? _commentsView(p, scale, settings) : _readingView(p, scale),
          ),
        ),
      ],
    );
  }

  Widget _readingView(AppPalette p, double scale) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sampleChapterText, style: TextStyle(color: p.readText, fontSize: 15 * scale, height: 2)),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: p.border))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('فصل هفتم از ۲۴', style: TextStyle(color: p.textDim, fontSize: 12 * scale)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppAccent.rose, foregroundColor: Colors.white, shape: const StadiumBorder()),
                  onPressed: () {},
                  child: Text('فصل بعد', style: TextStyle(fontSize: 12 * scale)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentsView(AppPalette p, double scale, AppSettings settings) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('امتیاز شما به این فصل', style: TextStyle(color: p.text, fontWeight: FontWeight.bold, fontSize: 13 * scale)),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (i) {
              final n = i + 1;
              return InkWell(
                onTap: () => setState(() => myRating = n),
                child: Icon(n <= myRating ? Icons.star_rounded : Icons.star_border_rounded, size: 26, color: AppAccent.rose),
              );
            }),
          ),
          const SizedBox(height: 18),
          Text('نظرات خوانندگان (${comments.length})', style: TextStyle(color: p.text, fontWeight: FontWeight.bold, fontSize: 13 * scale)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: comments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (ctx, i) {
                final c = comments[i];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: p.card, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name, style: TextStyle(color: AppAccent.rose, fontWeight: FontWeight.bold, fontSize: 12 * scale)),
                      const SizedBox(height: 4),
                      Text(c.text, style: TextStyle(color: p.textDim, fontSize: 12.5 * scale)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: draftController,
                  style: TextStyle(color: p.text, fontSize: 12.5 * scale),
                  decoration: InputDecoration(
                    hintText: settings.displayName.isEmpty ? 'نظرت را بنویس (اول نامت را می‌پرسیم)' : 'نظرت را بنویس...',
                    filled: true,
                    fillColor: p.inputBg,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide(color: p.border)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _postComment(settings),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppAccent.rose),
                  child: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppAccent.lavender, foregroundColor: AppAccent.plum, shape: const StadiumBorder()),
              onPressed: () => setState(() => showComments = false),
              child: Text('بازگشت به متن', style: TextStyle(fontSize: 13 * scale, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
