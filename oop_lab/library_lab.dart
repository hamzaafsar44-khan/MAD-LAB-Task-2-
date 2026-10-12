
final String rollNo = '04072313001';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

final List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing'
];

int yearOf(int i) => 1995 + 2 * i + t;

final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;

// Step 3: LibraryItem is now an abstract class.
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  // Think: An abstract class cannot be instantiated directly
  // because it can contain methods without implementations.
  int lateFee(int days);
}

class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

// Step 3.2: New Dvd subclass.
class Dvd extends LibraryItem {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(
    titles[i],
    yearOf(i),
    1 + (t + u) % 12,
  );
}

// Step 3.2: Create the main DVD.
Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

void step1() {
  print('Step 1: Seed = $seed');
  print('Step 1: t = $t, u = $u');
}

void step2() {
  Book book = mainBook();
  Magazine magazine = mainMagazine();

  print('Step 2: ${book.describe()}');
  print('Step 2: ${magazine.describe()}');
}

void step3() {
  Book book = mainBook();
  Magazine magazine = mainMagazine();
  Dvd dvd = mainDvd();

  print(
    'Step 3: Book late fee for $daysLate days = '
    '${book.lateFee(daysLate)}',
  );

  print(
    'Step 3: Magazine late fee for $daysLate days = '
    '${magazine.lateFee(daysLate)}',
  );

  print(
    'Step 3: Dvd late fee for $daysLate days = '
    '${dvd.lateFee(daysLate)}',
  );

  print('Step 3: ${dvd.describe()}');
}

void main() {
  step1();
  step2();
  step3();
}