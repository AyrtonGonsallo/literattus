// models/book.dart
import 'package:uuid/uuid.dart';

class Book {
  final int id;
  final String title;
  final String imagePath;
  final double prix;
  final DateTime dateParution;
  final String auteur;
  final String type;
  // Update the constructor to accept all properties
  Book({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.prix,
    required this.dateParution,
    required this.auteur,
    required this.type,
  });
  // Constructeur sans ID
  Book.withoutId({
    required this.title,
    required this.imagePath,
    required this.prix,
    required this.dateParution,
    required this.auteur,
    required this.type,
  }) : id = Uuid().v4().hashCode; // Générer un UUID et utiliser son hashcode comme ID

  // Convertir un Map en Book
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String? ?? '',
      imagePath: map['imagePath'] as String? ?? 'augusteclaute.webp',
      prix: map['prix'] as double? ?? 0.0,
      dateParution: DateTime.parse(map['dateParution'] as String? ?? DateTime.now().toIso8601String()),
      auteur: map['auteur'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }

  // Convertir un Book en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'prix': prix,
      'dateParution': dateParution.toIso8601String(),
      'auteur': auteur,
      'type': type,
    };
  }
}