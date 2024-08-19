// models/liste.dart
import 'package:uuid/uuid.dart';

class Liste {
  final int id;
  final String title;
  final DateTime date;
  // Update the constructor to accept all properties
  Liste({
    required this.id,
    required this.title,
    required this.date,
  });
  // Constructeur sans ID
  Liste.withoutId({
    required this.title,
    required this.date,
  }) : id = Uuid().v4().hashCode; // Générer un UUID et utiliser son hashcode comme ID

  // Convertir un Map en Book
  factory Liste.fromMap(Map<String, dynamic> map) {
    return Liste(
      id: map['id'] as int,
      title: map['title'] as String? ?? '',
      date: DateTime.parse(map['date'] as String? ?? DateTime.now().toIso8601String()),

    );
  }

  // Convertir un Book en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}