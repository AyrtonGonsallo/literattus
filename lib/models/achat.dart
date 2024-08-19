
// models/achat.dart
import 'package:uuid/uuid.dart';

enum AchatStatus { enCours, termine }


class Achat {
  final int id;
  final String title;
  final double prix;
  final String lieu;
   AchatStatus status;

  Achat({
    required this.id,
    required this.title,
    required this.prix,
    required this.lieu,
    required this.status,
  });
  // Constructeur sans ID
  Achat.withoutId({
    required this.title,
    required this.prix,
    required this.lieu,
    required this.status,
  }) : id = Uuid().v4().hashCode; // Générer un UUID et utiliser son hashcode comme ID



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'prix': prix,
      'lieu': lieu,
      'status': status.index, // Save enum as an integer
    };
  }

  static Achat fromMap(Map<String, dynamic> map) {
    return Achat(
      id: map['id'],
      title: map['title'],
      prix: map['prix'],
      lieu: map['lieu'],
      status: AchatStatus.values[map['status']],
    );
  }

}
