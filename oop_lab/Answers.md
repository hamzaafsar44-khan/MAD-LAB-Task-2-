Name: Hamza Afsar
Roll Number: 04072313001

Q1. What can a subclass using extends use for free that a class using implements has to write itself?

A class using extends can use the parent class's methods and properties. A class using implements must write its own implementation of all the required methods and properties.

Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?

I use a mixin when different classes need the same feature, like renewal. I use an abstract parent class when different classes share common properties and methods.

Q3. Why must you override hashCode whenever you override ==?

If two objects are equal, they must have the same hashCode. This helps Dart work correctly with sets and maps.

Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

Dart allows extension methods to add new features to existing types without changing them. But String is a final class, so we cannot extend it using a subclass.