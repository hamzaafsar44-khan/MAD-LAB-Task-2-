
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

// Parent class
class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  // Step 2: describe method
  String describe() => '$title ($year)';
}

// Child class Book
class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);

  // Step 2: override describe method
  @override
  String describe() => '${super.describe()}, $pages pages';
}

// Step 2: Magazine class
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';
}

// Main book
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// Step 2: Main magazine
Magazine mainMagazine() {
  final int i = (u + 1) % 10;

  return Magazine(
    titles[i],
    yearOf(i),
    1 + (t + u) % 12,
  );
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');

  step1();
  step2();
}

// Step 1
void step1() {
  print('--- Step 1 ---');

  final Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

// Step 2
void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}
.