
const String rollNo = '04072313001';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;

final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;
final int daysBig = 10 + u;
final int feeCap = 150 + 10 * t;
final int renewLimit = 1 + t % 3;
final int renewAttempts = 2 + u;
final int shelfSize = 3 + u % 4;

class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);
}

class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
}

void step1() {
  print('--- Step 1 ---');

  final Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item.pages causes an error because LibraryItem
  // does not have a pages property.
}