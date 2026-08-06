import 'package:flutter/material.dart';

enum WorkType { novel, comic }

class Book {
  final String id;
  final String title;
  final String genre;
  final String ageRating;
  final double rating;
  final WorkType type;
  final Color coverColor;

  const Book({
    required this.id,
    required this.title,
    required this.genre,
    required this.ageRating,
    required this.rating,
    required this.type,
    required this.coverColor,
  });

  String get typeLabel => type == WorkType.novel ? 'رمان' : 'کامیک';
}

class ReadingProgress {
  final String bookId;
  final int chapterIndex;
  final int percent;

  const ReadingProgress({
    required this.bookId,
    required this.chapterIndex,
    required this.percent,
  });
}

class Comment {
  final String name;
  final String text;

  const Comment({required this.name, required this.text});
}
