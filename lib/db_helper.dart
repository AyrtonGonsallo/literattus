import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/achat.dart';
import 'models/book.dart';
import 'models/liste.dart';
import 'models/secteur.dart'; // Import your Liste model

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/litteratus.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            imagePath TEXT,
            prix REAL,
            dateParution TEXT,
            auteur TEXT,
            type TEXT,
            listId INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE listes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            date TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE achats(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            prix REAL,
            lieu TEXT,
            status INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE secteurs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            prix REAL
          )
        ''');

      },

    );
  }

  // Methods for Books
  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert('books', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> fetchBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }
  Future<List<Book>> fetchListBooks(int listeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'books',
      where: 'listId = ?', // Filter books by listId
      whereArgs: [listeId], // Pass the listId as a parameter
    );

    // Convert the list of maps to a list of Book objects
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }




  // Methods for Achats
  Future<void> insertAchat(Achat achat) async {
    final db = await database;
    await db.insert('achats', achat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteAchat(int id) async {
    final db = await database;
    await db.delete('achats', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Achat>> fetchAchats() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('achats');
    return List.generate(maps.length, (i) {
      return Achat.fromMap(maps[i]);
    });
  }

  Future<void> updateAchatStatus(int id, AchatStatus newStatus) async {
    final db = await database;
    await db.update(
      'achats',
      {'status': newStatus.index},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Methods for Listes
  Future<void> insertListe(Liste liste) async {
    final db = await database;
    await db.insert('listes', liste.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteListe(int id) async {
    final db = await database;
    await db.delete('listes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Liste>> fetchListes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('listes');
    return List.generate(maps.length, (i) {
      return Liste.fromMap(maps[i]);
    });
  }
  Future<Liste?> fetchListe(int listeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'listes',
      where: 'id = ?', // Filter by the liste ID
      whereArgs: [listeId], // Pass the listeId as a parameter
    );

    // Check if a list was found and convert it to a Liste object
    if (maps.isNotEmpty) {
      return Liste.fromMap(maps.first);
    } else {
      return null; // Return null if no list was found with the given ID
    }
  }

  // Methods for Secteurs
  Future<void> insertSecteur(Secteur secteur) async {
    final db = await database;
    await db.insert('secteurs', secteur.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteSecteur(int id) async {
    final db = await database;
    await db.delete('secteurs', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Secteur>> fetchSecteurs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('secteurs');
    return List.generate(maps.length, (i) {
      return Secteur.fromMap(maps[i]);
    });
  }

  // Fetch the 3 latest lists
  Future<List<Liste>> fetchLatestListes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'listes',
      orderBy: 'id DESC',
      limit: 3,
    );
    return List.generate(maps.length, (i) {
      return Liste.fromMap(maps[i]);
    });
  }

  // Fetch the 3 latest achats
  Future<List<Achat>> fetchLatestAchats() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'achats',
      orderBy: 'id DESC',
      limit: 3,
    );
    return List.generate(maps.length, (i) {
      return Achat.fromMap(maps[i]);
    });
  }

  // Fetch the 3 latest secteurs
  Future<List<Secteur>> fetchLatestSecteurs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'secteurs',
      orderBy: 'id DESC',
      limit: 3,
    );
    return List.generate(maps.length, (i) {
      return Secteur.fromMap(maps[i]);
    });
  }
  // Fetch the 3 latest secteurs
  Future<List<Book>> fetchLatestBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'books',
      orderBy: 'id DESC',
      limit: 3,
    );
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }


}