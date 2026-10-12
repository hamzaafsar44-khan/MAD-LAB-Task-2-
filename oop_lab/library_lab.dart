

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

// Step 6: Enhanced enum
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

// Step 2 and Step 9: Abstract class
abstract class LibraryItem {
  final String title;
  final int year;

  // Step 9: Shared counter
  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  String describe() => '$title ($year)';

  int lateFee(int days);

  // Step 9: Fee cap helper
  static int capFee(int fee) {
    return fee > feeCap ? feeCap : fee;
  }
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

// Book
class Book extends LibraryItem
    with Renewable
    implements Borrowable {
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

// Magazine
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

// DVD
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}


class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine o) {
    return Fine(amount + o.amount);
  }

  bool operator >(Fine o) {
    return amount > o.amount;
  }

  @override
  bool operator ==(Object other) {
    return other is Fine && other.amount == amount;
  }

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
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

  return Dvd(
    titles[i],
    yearOf(i),
    90 + seed % 40,
  );
}

// Step 7: Extension methods
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials {
    return split(' ').map((w) => w[0]).join();
  }
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) {
    return fold(
      0,
      (sum, item) => sum + item.lateFee(days),
    );
  }
}

// Step 1
void step1() {
  print('--- Step 1 ---');
  print('Step 1: Seed = $seed');
  print('Step 1: t = $t, u = $u');
}

// Step 2
void step2() {
  print('--- Step 2 ---');

  Book book = mainBook();
  Magazine magazine = mainMagazine();

  print('Step 2: ${book.describe()}');
  print('Step 2: ${magazine.describe()}');
}

// Step 3
void step3() {
  print('--- Step 3 ---');

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

// Step 4
void step4() {
  print('--- Step 4 ---');

  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? '
      '${item is Borrowable}',
    );
  }
}

// Step 5
void step5() {
  print('--- Step 5 ---');

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

// Step 6
void step6() {
  print('--- Step 6 ---');

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

// Step 7
void step7() {
  print('--- Step 7 ---');

  MemberType type = MemberType.values[seed % 3];
  Book book = mainBook();
  int fee = book.lateFee(daysLate);
  int discountedFee = type.applyDiscount(fee);

  print('Step 7: ${discountedFee.rs}');

  print(
    'Step 7: initials of "${titles[u]}" = '
    '${titles[u].initials}',
  );

  List<LibraryItem> shelf = [
    mainBook(),
    mainMagazine(),
    mainDvd(),
  ];

  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );
}

// Step 8
void step8() {
  print('--- Step 8 ---');

  Book book = mainBook();
  Magazine magazine = mainMagazine();

  Fine f1 = Fine(book.lateFee(daysLate));
  Fine f2 = Fine(magazine.lateFee(daysLate));

  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');

  print(
    'Step 8: set size = '
    '${{f1, Fine(f1.amount), f2}.length}',
  );
}

// Step 9.2: Create shelfSize items
List<LibraryItem> buildShelf() {
  List<LibraryItem> shelf = [];

  for (int k = 0; k < shelfSize; k++) {
    int i = (u + k) % 10;

    if (k % 3 == 0) {
      shelf.add(
        Book(titles[i], yearOf(i), 100 + 3 * seed),
      );
    } else if (k % 3 == 1) {
      shelf.add(
        Magazine(titles[i], yearOf(i), 1 + (t + k) % 12),
      );
    } else {
      shelf.add(
        Dvd(titles[i], yearOf(i), 90 + seed % 40),
      );
    }
  }

  return shelf;
}

// Step 9
void step9() {
  print('--- Step 9 ---');

  LibraryItem.created = 0;

  buildShelf();
  List<LibraryItem> shelf = buildShelf();

  print('Step 9: items created = ${LibraryItem.created}');

  int cappedFee =
      LibraryItem.capFee(shelf.first.lateFee(daysBig));

  print(
    'Step 9: capped fee = $cappedFee (cap $feeCap)',
  );

  print(
    'Step 9: const copies identical? '
    '${identical(const Fine(10), const Fine(10))}',
  );

  print(
    'Step 9: new copies identical? '
    '${identical(Fine(10), Fine(10))}',
  );


}

// Main: Steps 1 to 9 only
void main() {
  print('Seed: $seed (t=$t, u=$u)');

  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
}
