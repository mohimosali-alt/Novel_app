import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';

class BookGridItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final AppPalette palette;

  const BookGridItem({super.key, required this.book, required this.onTap, required this.palette});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 96 / 130,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [book.coverColor, AppAccent.plum],
                ),
              ),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(book.ageRating, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: palette.text, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.star, size: 11, color: AppAccent.rose),
              const SizedBox(width: 2),
              Text('${book.rating}', style: TextStyle(color: palette.textDim, fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Text('· ${book.typeLabel}', style: TextStyle(color: palette.textDim, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
