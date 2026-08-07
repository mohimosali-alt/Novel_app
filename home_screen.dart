import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../models/book.dart';
import '../state/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/book_grid_item.dart';
import '../widgets/progress_ring.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<Book> onOpenBook;
  const HomeScreen({super.key, required this.onOpenBook});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String genre = 'همه';

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AppSettings>().palette;
    final filtered = genre == 'همه' ? sampleLibrary : sampleLibrary.where((b) => b.genre == genre).toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          color: p.headerBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('کتاب‌یار', style: TextStyle(color: p.headerText, fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('رمان و کامیک، دقیقاً از همان‌جا که رها کردی', style: TextStyle(color: p.headerSub, fontSize: 13)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 90),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 15, color: AppAccent.rose),
                    const SizedBox(width: 6),
                    Text('اخیراً خوانده‌اید', style: TextStyle(color: p.text, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              SizedBox(
                height: 78,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: sampleContinueReading.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (ctx, i) {
                    final rp = sampleContinueReading[i];
                    final book = bookById(rp.bookId);
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => widget.onOpenBook(book),
                      child: Container(
                        width: 190,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: p.card,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))],
                        ),
                        child: Row(
                          children: [
                            ProgressRing(percent: rp.percent, textColor: p.text, trackColor: p.border),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: p.text, fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 2),
                                  Text('${book.typeLabel} · ادامه مطالعه', style: TextStyle(color: p.textDim, fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: genres.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final g = genres[i];
                    final selected = g == genre;
                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => setState(() => genre = g),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? AppAccent.rose : p.card,
                          borderRadius: BorderRadius.circular(999),
                          border: selected ? null : Border.all(color: p.border),
                        ),
                        child: Text(g, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: selected ? Colors.white : p.textDim)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.6,
                  ),
                  itemBuilder: (ctx, i) => BookGridItem(book: filtered[i], onTap: () => widget.onOpenBook(filtered[i]), palette: p),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
