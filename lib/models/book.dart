// models/book.dart
class Book {
  final String title;
  final String imagePath;
  final double prix;
  final DateTime dateParution;
  final String auteur;
  final String type;
  // Update the constructor to accept all properties
  Book({
    required this.title,
    required this.imagePath,
    required this.prix,
    required this.dateParution,
    required this.auteur,
    required this.type,
  });
}