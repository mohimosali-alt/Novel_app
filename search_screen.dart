import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../models/book.dart';
import '../state/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/book_grid_item.dart';

class SearchScreen extends StatefulWidget {
  final ValueChanged<Book> onOpenBook;
  const SearchScreen({super.key, required this.onOpenBook});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AppSettings>().palette;
    final results = query.trim().isEmpty
        ? <Book>[]
        : sampleLibrary.where((b) => b.title.contains(query) || b.genre.contains(query)).toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          color: p.headerBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('جست‌وجو', style: TextStyle(color: p.headerText, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, size: 18, color: p.headerSub),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onChanged: (v) => setState(() => query = v),
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'نام رمان، کامیک یا ژانر...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    if (query.isNotEmpty)
                      InkWell(onTap: () { controller.clear(); setState(() => query = ''); }, child: const Icon(Icons.close, size: 16, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: query.trim().isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Icon(Icons.search_rounded, size: 30, color: p.border.withOpacity(1)),
                      const SizedBox(height: 8),
                      Text('برای شروع، نام اثر یا ژانر را بنویس', style: TextStyle(color: p.textDim, fontSize: 13)),
                    ],
                  ),
                )
              : results.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text('چیزی با این عنوان پیدا نشد', textAlign: TextAlign.center, style: TextStyle(color: p.textDim, fontSize: 13)),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                      child: GridView.builder(
                        itemCount: results.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.6,
                        ),
                        itemBuilder: (ctx, i) => BookGridItem(book: results[i], onTap: () => widget.onOpenBook(results[i]), palette: p),
                      ),
                    ),
        ),
      ],
    );
  }
}
