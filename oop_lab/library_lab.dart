
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

// Step 5: Renewal settings
final int renewLimit = 2 + u % 3;
final int renewAttempts = 1 + seed % 5;

// Step 6.1: Enhanced enum
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) {
    return fee - (fee * discountPercent ~/ 100);
  }
}

// Step 3: Abstract class
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

// Step 4: Borrowable contract
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

// Step 5: Renewable mixin
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}

// Book implements Borrowable and uses Renewable
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

// Magazine does not use Renewable
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

// Dvd uses Renewable
class Dvd extends LibraryItem with Renewable {
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

void step4() {
  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd()
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? '
      '${item is Borrowable}',
    );
  }


}

void step5() {
  Book book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts '
    '(limit $renewLimit)',
  );

  print('Step 5: renew once more? ${book.renew(renewLimit)}');

  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  
}

// Step 6.2: Test enhanced enum
void step6() {
  MemberType type = MemberType.values[seed % 3];

  Book book = mainBook();
  int fee = book.lateFee(daysLate);

  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print(
    'Step 6: book fee $fee -> '
    '${type.applyDiscount(fee)} after discount',
  );

 
}

void main() {
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
}