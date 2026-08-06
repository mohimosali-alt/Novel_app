import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';

/// این فایل فقط دیتای نمونه است تا اپ قابل تست باشد.
/// بعداً این‌ها با درخواست واقعی به بک‌اند PHP جایگزین می‌شوند (services/api_service.dart).

const List<Book> sampleLibrary = [
  Book(id: '1', title: 'سایه‌های نیمه‌شب', genre: 'عاشقانه', ageRating: '۱۵+', rating: 4.7, type: WorkType.novel, coverColor: AppAccent.rose),
  Book(id: '2', title: 'پروانه‌های آهنی', genre: 'فانتزی', ageRating: '۱۲+', rating: 4.3, type: WorkType.comic, coverColor: AppAccent.slate),
  Book(id: '3', title: 'ملکه‌ی بی‌تاج', genre: 'درام', ageRating: '۱۶+', rating: 4.9, type: WorkType.novel, coverColor: AppAccent.lavender),
  Book(id: '4', title: 'شهر بی‌خواب', genre: 'معمایی', ageRating: '۱۸+', rating: 4.1, type: WorkType.novel, coverColor: AppAccent.plum),
  Book(id: '5', title: 'خط سرخ', genre: 'اکشن', ageRating: '۱۵+', rating: 4.5, type: WorkType.comic, coverColor: AppAccent.powder),
  Book(id: '6', title: 'باغ کاغذی', genre: 'عاشقانه', ageRating: '۱۲+', rating: 4.6, type: WorkType.novel, coverColor: AppAccent.blush),
];

const List<ReadingProgress> sampleContinueReading = [
  ReadingProgress(bookId: '1', chapterIndex: 7, percent: 62),
  ReadingProgress(bookId: '2', chapterIndex: 3, percent: 30),
  ReadingProgress(bookId: '3', chapterIndex: 20, percent: 85),
];

const List<String> genres = ['همه', 'عاشقانه', 'فانتزی', 'درام', 'معمایی', 'اکشن'];

const String sampleChapterText = '''فصل هفتم

باد سرد از لای پنجره‌ی نیمه‌باز می‌گذشت و شمع روی میز را می‌لرزاند. او دفتر را بست و به دیوار خیره شد؛ انگار جوابی که دنبالش بود آن‌جا نوشته شده باشد.

صدای قدم‌ها از راهرو نزدیک‌تر می‌شد. قلبش تندتر زد. این بار فرقی نداشت چه کسی پشت در باشد؛ او تصمیمش را گرفته بود.

- «اگر برنگردم...» زمزمه کرد، «این دفتر را برای کسی نگه دار که بداند چطور بخواندش.»

در باز شد. نور کم‌سوی راهرو داخل اتاق افتاد.''';

final List<Comment> sampleComments = [
  const Comment(name: 'ندا', text: 'توصیف صحنه‌ی آخر عالی بود، دلم لرزید.'),
  const Comment(name: 'آرمین', text: 'پیچش داستان این فصل غیرمنتظره بود!'),
];

Book bookById(String id) => sampleLibrary.firstWhere((b) => b.id == id);
