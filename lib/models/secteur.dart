
// models/secteur.dart
import 'package:uuid/uuid.dart';



class Secteur {
  final int id;
  final String title;
  final double prix;

  Secteur({
    required this.id,
    required this.title,
    required this.prix,
  });
  // Constructeur sans ID
  Secteur.withoutId({
    required this.title,
    required this.prix,
  }) : id = Uuid().v4().hashCode; // Générer un UUID et utiliser son hashcode comme ID



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'prix': prix,
    };
  }

  static Secteur fromMap(Map<String, dynamic> map) {
    return Secteur(
      id: map['id'],
      title: map['title'],
      prix: map['prix'],
    );
  }

}
