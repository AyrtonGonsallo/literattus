import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:litteratus/widgets/book_card2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'db_helper.dart';
import 'models/achat.dart';
import 'models/book.dart';
import 'models/liste.dart';
import 'models/secteur.dart';
import 'widgets/book_card.dart';
import 'package:image_picker/image_picker.dart'; // Pour sélectionner une image
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Littératus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Littératus'),


    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Book>> _booksFuture;
  late Future<List<Liste>> _listsFuture;
  late Future<List<Achat>> _achatsFuture;
  late Future<List<Secteur>> _secteursFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _getLatestBooks();
    _listsFuture = _getLatestLists();
    _achatsFuture = _getLatestAchats();
    _secteursFuture = _getLatestSecteurs();
  }

  Future<List<Book>> _getLatestBooks() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchLatestBooks(); // Implement this in your DBHelper
  }

  Future<List<Liste>> _getLatestLists() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchLatestListes(); // Implement this in your DBHelper
  }

  Future<List<Achat>> _getLatestAchats() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchLatestAchats(); // Implement this in your DBHelper
  }

  Future<List<Secteur>> _getLatestSecteurs() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchLatestSecteurs(); // Implement this in your DBHelper
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_launcher.png', // Replace with your app icon path
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Littératus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Toutes les listes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Tous les achats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchatListePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text('Ajouter un achat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Répartition du budget'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart_outline_rounded),
              title: const Text('Ajouter un secteur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterSecteurPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildBoxSection('Derniers Livres', _booksFuture, ['id', 'title', 'prix', 'dateParution', 'auteur']),
            _buildBoxSection('Dernières Listes', _listsFuture, ['id', 'title', 'date']),
            _buildBoxSection('Derniers Achats', _achatsFuture, ['id', 'title', 'prix', 'lieu', 'status']),
            _buildBoxSection('Derniers Secteurs', _secteursFuture, ['id', 'title', 'prix']),
          ],
        ),
      ),
    );
  }
  Widget _buildBoxSection(String title, Future<List<dynamic>> future, List<String> fields) {
    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune donnée trouvée.'));
        }

        final data = snapshot.data!;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Customize the color here
                ),              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length > 3 ? 3 : data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: _getFormattedText(item, fields),
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<TextSpan> _getFormattedText(dynamic item, List<String> fields) {
    initializeDateFormatting("fr_FR", null);
    return fields.map((field) {
      if (field == 'title') return TextSpan(text: 'Titre: ${item.title}\n');
      if (field == 'id') return TextSpan(text: 'ID: ${item.id}  -  ');
      if (field == 'prix') return TextSpan(text: 'Prix: ${item.prix}  -  ');
      if (field == 'dateParution') return TextSpan(text: 'Date: ${DateFormat('dd MMM yyyy', 'fr_FR').format(item.dateParution)}\n');
      if (field == 'auteur') return TextSpan(text: 'Auteur: ${item.auteur}\n');
      if (field == 'lieu') return TextSpan(text: 'Lieu: ${item.lieu}\n');
      if (field == 'date') return TextSpan(text: 'Date: ${DateFormat('dd MMM yyyy', 'fr_FR').format(item.date)}\n');
      return TextSpan(text: '');
    }).toList();
  }
}



class BooksPage extends StatelessWidget {
  const BooksPage({super.key}
      );

  @override
  Widget build(BuildContext context) {
    // Define a static list of books with all properties
    final List<Book> books = [
      Book.withoutId(
        title: 'Le duel sous l\'Ancien Régime',
        imagePath: 'assets/duel.webp',
        prix: 9.99,
        dateParution: DateTime(1982, 1, 1),
        auteur: 'Micheline Cuénin, Yves-Marie Bercé, Jacques Callot, Evelyne Lever, Maurice Lever',
        type: 'ePub',
        description: 'Explore the intricate world of duels during the Ancien Régime, delving into their social and legal implications.',
      ),
      Book.withoutId(
        title: 'La femme et le soldat - Viols et violences de guerre du Moyen Age à nos jours',
        imagePath: 'assets/femmesoldat.webp',
        prix: 14.99,
        dateParution: DateTime(2012, 1, 21),
        auteur: 'Maurice Agulhon',
        type: 'PDF',
        description: 'An in-depth examination of the violence endured by women during wartime throughout history.',
      ),
      Book.withoutId(
        title: 'HISTOIRE DU VAGABONDAGE. Du Moyen Age à nos jours',
        imagePath: 'assets/vagabondage.webp',
        prix: 14.99,
        dateParution: DateTime(1998, 11, 18),
        auteur: 'Maurice Agulhon',
        type: 'ePub',
        description: 'A comprehensive history of vagrancy, tracing its evolution from the Middle Ages to modern times.',
      ),
      Book.withoutId(
        title: 'La mort, l\'au-delà et les autres mondes',
        imagePath: 'assets/mort.webp',
        prix: 15.99,
        dateParution: DateTime(2019, 2, 20),
        auteur: 'Claude Lecouteux',
        type: 'PDF',
        description: 'A journey through beliefs about death, the afterlife, and other worlds across various cultures.',
      ),
      Book.withoutId(
        title: 'Rabelais en Vendée',
        imagePath: 'assets/rabelais.webp',
        prix: 9.99,
        dateParution: DateTime(2004, 6, 1),
        auteur: 'Gilbert Prouteau',
        type: 'PDF',
        description: 'An exploration of the connections between Rabelais and the region of Vendée, rich in historical context.',
      ),
      Book.withoutId(
        title: 'Rire avec Dieu - L\'humour chez les chrétiens, les juifs et les musulmans',
        imagePath: 'assets/rire.webp',
        prix: 17.99,
        dateParution: DateTime(2019, 5, 9),
        auteur: 'Marc Lienhard',
        type: 'ePub',
        description: 'A lighthearted look at how humor is perceived and practiced in the three major monotheistic religions.',
      ),
      Book.withoutId(
        title: 'Vivre la misère au Moyen Age',
        imagePath: 'assets/misere.webp',
        prix: 17.99,
        dateParution: DateTime(2023, 4, 7),
        auteur: 'Jean-Louis Roch',
        type: 'ePub',
        description: 'This book paints a vivid picture of the harsh realities of poverty during the Middle Ages.',
      ),
      Book.withoutId(
        title: 'Brigands, bandits, malfaiteurs - Incroyables histoires des crapules, arsouilles, monte-en-l\'air, canailles et contrebandiers de tous les temps',
        imagePath: 'assets/brigants.webp',
        prix: 9.99,
        dateParution: DateTime(2017, 9, 11),
        auteur: 'Bernard Hautecloque',
        type: 'Multi-format',
        description: 'Thrilling tales of notorious outlaws and criminals from history, brought to life with vivid detail.',
      ),
      Book.withoutId(
        title: 'L\'amoureuse histoire d\'Auguste Comte et de Clotilde de Vaux',
        imagePath: 'assets/augusteclaute.webp',
        prix: 10.99,
        dateParution: DateTime(1917, 1, 1),
        auteur: 'Charles de Rouvre',
        type: 'ePub',
        description: 'A romantic and poignant account of the love between Auguste Comte and Clotilde de Vaux.',
      ),
      Book.withoutId(
        title: 'John Milton, poète combattant',
        imagePath: 'assets/milton.webp',
        prix: 9.99,
        dateParution: DateTime(1959, 1, 1),
        auteur: 'Emile Saillens',
        type: 'ePub',
        description: 'An exploration of John Milton’s life as a poet and his involvement in the political battles of his time.',
      ),
      Book.withoutId(
        title: 'Kierkegaard, écrire ou mourir',
        imagePath: 'assets/kierkegaard.webp',
        prix: 12.99,
        dateParution: DateTime(2015, 1, 1),
        auteur: 'Stéphane Vial',
        type: 'ePub',
        description: 'A deep dive into Kierkegaard’s philosophy, focusing on the existential themes of writing and mortality.',
      ),
      Book.withoutId(
        title: 'Esprit, es-tu là? Histoires du surnaturel, de l\'Antiquité à nos jours',
        imagePath: 'assets/surnaturel.webp',
        prix: 12.99,
        dateParution: DateTime(2013, 11, 8),
        auteur: 'Vivianne Perret',
        type: 'ePub',
        description: 'A fascinating look at the supernatural, spanning stories and beliefs from ancient times to the present.',
      ),
      Book.withoutId(
        title: 'Armageddon - Une histoire de la fin du monde',
        imagePath: 'assets/findumonde.webp',
        prix: 14.99,
        dateParution: DateTime(2024, 3, 6),
        auteur: 'Régis Burnet, Pierre-Edouard Detal',
        type: 'ePub',
        description: 'An insightful exploration of apocalyptic visions and the concept of the end of the world through history.',
      ),
      Book.withoutId(
        title: 'L\'Apologétique chrétienne - Expressions de la pensée religieuse, de l\'Antiquité à nos jours',
        imagePath: 'assets/apologetique.webp',
        prix: 11.99,
        dateParution: DateTime(2019, 9, 3),
        auteur: 'Didier Boisson, Elisabeth Pinto-Mathieu',
        type: 'Multi-format',
        description: 'A comprehensive guide to Christian apologetics, tracing its evolution from ancient times to modernity.',
      ),
      Book.withoutId(
        title: 'La Prostitution devant le philosophe',
        imagePath: 'assets/prostphil.webp',
        prix: 1.99,
        dateParution: DateTime(2016, 8, 5),
        auteur: 'Charles Richard',
        type: 'Multi-format',
        description: 'An intriguing philosophical discussion on the moral and social implications of prostitution.',
      ),
      Book.withoutId(
        title: 'Dis Socrate, c\'est quoi l\'amour ? - Quand les philosophes discutent du plus beau des sentiments',
        imagePath: 'assets/socrateamour.webp',
        prix: 13.99,
        dateParution: DateTime(2021, 10, 4),
        auteur: 'Nora Kreft',
        type: 'ePub',
        description: 'A philosophical exploration of love, guided by the thoughts and dialogues of Socrates and other great minds.',
      ),
      Book.withoutId(
        title: 'Le vrai métier des philosophes',
        imagePath: 'assets/vraimetier.webp',
        prix: 10.99,
        dateParution: DateTime(2024, 5, 29),
        auteur: 'Nassim El Kabli',
        type: 'ePub',
        description: 'An engaging discussion on the true role and profession of philosophers throughout history.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste statique des livres'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_launcher.png', // Replace with your app icon path
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Littératus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Toutes les listes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Tous les achats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchatListePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text('Ajouter un achat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Répartition du budget'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart_outline_rounded),
              title: const Text('Ajouter un secteur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterSecteurPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Parametres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Utilisez 840 pixels comme point de rupture
            int columns = constraints.maxWidth < 840 ? 3 : 4;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookCard(book: books[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});




  Future<void> _exportDatabase(BuildContext context) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export cancelled')),
        );
        return; // User canceled the picker
      }

      final exportPath = path.join(selectedDirectory, 'litteratus.db');

      final dbFile = File(await DBHelper().getDatabasePath());
      final exportFile = File(exportPath);

      await dbFile.copy(exportFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database exported to: $exportPath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error exporting database: $e')),
      );
    }
  }

  Future<void> _clearDatabase(BuildContext context) async {
    try {
      final db = await DBHelper().database;

      await db.delete('books');
      await db.delete('listes');
      await db.delete('achats');
      await db.delete('secteurs');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database cleared successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing database: $e')),
      );
    }
  }

  Future<void> _importDatabase(BuildContext context) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Import cancelled')),
        );
        return; // User canceled the picker
      }

      final importPath = path.join(selectedDirectory, 'litteratus.db');

      final importFile = File(importPath);
      final dbFile = File(await DBHelper().getDatabasePath());

      if (await importFile.exists()) {
        await importFile.copy(dbFile.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Database imported from: $importPath')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import file not found at: $importPath')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing database: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _exportDatabase(context),
              child: const Text('Exporter la base de données'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _clearDatabase(context),
              child: const Text('Éffacer la base de données'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _importDatabase(context),
              child: const Text('Importer la base de données'),
            ),
          ],
        ),
      ),
    );
  }
}



class PBooksPage extends StatefulWidget {
  const PBooksPage({super.key});

  @override
  _PBooksPageState createState() => _PBooksPageState();
}

class _PBooksPageState extends State<PBooksPage> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _getBooks();

  }

  Future<List<Book>> _getBooks() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchBooks();
  }

  void _deleteBook(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteBook(id);
    setState(() {
      _booksFuture = _getBooks(); // Update the book list after deletion
    });
  }


  void _seeBook(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewBookPage(bookId: id),
      ),
    );
  }

  void _updateBook(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateBookPage(bookId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des livres'),
        backgroundColor: Colors.blueAccent,
      ),drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/ic_launcher.png', // Replace with your app icon path
                  height: 72,
                  width: 72,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Littératus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_sharp),
            title: const Text('Tous les livres'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Toutes les listes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Tous les livres en db'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PBooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text('Ajouter un livre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddBookPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Tous les achats'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AchatListePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text('Ajouter un achat'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Parametres'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: _booksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Erreur lors du chargement des livres: ${snapshot.error}');
                    return const Center(child: Text('Erreur de chargement'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucun livre trouvé'));
                  }

                  final books = snapshot.data!;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = constraints.maxWidth < 840 ? 3 : 4;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return BookCard2(
                            book: books[index],
                            onDelete: () => _deleteBook(books[index].id),
                            onSee: () => _seeBook(books[index].id),
                            onUpdate: () => _updateBook(books[index].id),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddBookPage()), // Ensure AddBookPage exists
                  );
                },
                child: const Text('Ajouter un Livre'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class UpdateBookPage extends StatefulWidget {
  final int bookId;

  const UpdateBookPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _UpdateBookPageState createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  final _formKey = GlobalKey<FormState>();
  late Book _book;
  List<Liste> listes = [];
  int? selectedListId;
  final List<String> types = ['Epub', 'Pdf'];
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _fetchBookDetails();
    _fetchListes();
  }

  Future<void> _fetchListes() async {
    final dbHelper = DBHelper();
    final fetchedListes = await dbHelper.fetchListes();
    setState(() {
      listes = fetchedListes;
    });
  }

  Future<void> _fetchBookDetails() async {
    final book = await DBHelper().getBookById(widget.bookId);
    setState(() {
      _book = book;
      selectedType = book.type;
      selectedListId = book.listId; // Assuming Book has listId field
    });
  }

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedBook = _book.copyWith(
        type: selectedType!,
        listId: selectedListId, // Include listId if needed
      );

      await DBHelper().updateBook(updatedBook);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Book'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _book.title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _book = _book.copyWith(title: value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _book.description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _book = _book.copyWith(description: value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _book.prix.toString(),
                  decoration: const InputDecoration(labelText: 'Prix'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Veuillez entrer un prix valide';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _book = _book.copyWith(prix: double.tryParse(value!));
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _book.auteur,
                  decoration: const InputDecoration(labelText: 'Auteur'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un auteur';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _book = _book.copyWith(auteur: value!);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Type'),
                  value: selectedType,
                  items: types.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Liste'),
                  value: selectedListId,
                  items: listes.map((Liste liste) {
                    return DropdownMenuItem<int>(
                      value: liste.id,
                      child: Text(liste.title),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedListId = newValue;
                    });
                  },
                  validator: (value) {
                    // Optional: Add validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _updateBook,
                  child: const Text('Update Book'),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}






class ViewBookPage extends StatelessWidget {
  final int bookId;

  const ViewBookPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchBookAndListData(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Book not found'));
        }

        final book = snapshot.data!['book'] as Book;
        final listName = snapshot.data!['listName'] as String?;

        return Scaffold(
          appBar: AppBar(
            title: Text(book.title),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the book title
                Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline

                  ),
                ),
                const SizedBox(height: 16),
                // Display the book image
                Container(
                  width: double.infinity, // Make the container full width
                  height: 600, // Set a fixed height for the image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: book.imagePath.isNotEmpty
                          ? FileImage(File(book.imagePath))
                          : AssetImage('assets/augusteclaute.webp') as ImageProvider,
                      fit: BoxFit.cover, // Adjust the fit according to your needs
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Display the book description
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Text color
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 2,
                          width: 150, // Adjust width to match the text length
                          color: Colors.red, // Underline color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  ' ${book.description ?? 'No description available'}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                // Display the book details in a 3-column layout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'Author: ${book.auteur}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          'Date: ${DateFormat('dd MMM yyyy', 'fr_FR').format(book.dateParution)}',
                          style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Expanded(
                      child: Text(
                          'Type: ${book.type}',
                          style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          'Liste: ${listName}',
                          style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );


  }

  Future<Map<String, dynamic>> _fetchBookAndListData(int bookId) async {
    final book = await DBHelper().getBookById(bookId);
    final listName = book.listId != null ? await _fetchListName(book.listId!) : null;

    return {
      'book': book,
      'listName': listName,
    };
  }

  Future<String?> _fetchListName(int listId) async {
    final liste = await DBHelper().fetchListe(listId);
    return liste?.title;
  }
}




class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> types = ['Epub', 'Pdf'];
  String? selectedType;
  int? selectedListId;
  List<Liste> listes = [];
  String title = '';
  String imagePath = "";
  double prix = 0.0;
  DateTime? dateParution;
  String auteur = '';
  String type = '';
  String description = ''; // Champ de description

  @override
  void initState() {
    super.initState();
    _fetchListes();
  }

  Future<void> _fetchListes() async {
    final dbHelper = DBHelper();
    final fetchedListes = await dbHelper.fetchListes();
    setState(() {
      listes = fetchedListes;
    });
  }

  Future<void> _saveBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final book = Book.withoutId(
        title: title,
        imagePath: imagePath,
        prix: prix,
        dateParution: dateParution!,
        auteur: auteur,
        type: type,
        listId: selectedListId,
        description: description, // Save description
      );

      await DBHelper().insertBook(book);

      print('Book saved to the database');
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final directory = await getExternalStorageDirectory();
        final String customFolder = '${directory!.path}/Imageslivres';
        await Directory(customFolder).create(recursive: true);

        final fileName = path.basename(pickedFile.path);
        final filePath = '$customFolder/$fileName';

        final File imageFile = File(pickedFile.path);
        final File savedImage = await imageFile.copy(filePath);

        setState(() {
          imagePath = savedImage.path;
        });

        print('Image saved to: $imagePath');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dateParution) {
      setState(() {
        dateParution = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un livre'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Titre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      title = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(imagePath.isEmpty
                            ? 'Aucune image sélectionnée'
                            : 'Image: ${path.basename(imagePath)}'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Prix'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prix';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un prix valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      prix = double.parse(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(dateParution == null
                        ? 'Sélectionner une date de parution'
                        : 'Date de parution: ${dateParution!.toLocal()}'.split(' ')[0]),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Auteur'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un auteur';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      auteur = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      description = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Type'),
                    value: selectedType,
                    items: types.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez sélectionner un type';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      type = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Liste'),
                    value: selectedListId,
                    items: listes.map((Liste liste) {
                      return DropdownMenuItem<int>(
                        value: liste.id,
                        child: Text(liste.title),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedListId = newValue;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print('Titre: $title');
                        print('Image Path: $imagePath');
                        print('Prix: $prix');
                        print('Date de parution: $dateParution');
                        print('Auteur: $auteur');
                        print('Type: $type');
                        print('Liste ID: $selectedListId');
                        print('Description: $description'); // Print description
                        _saveBook();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PBooksPage()),
                        );
                      }
                    },
                    child: const Text('Ajouter le livre'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





class ToutesLesListesPage extends StatefulWidget {
  const ToutesLesListesPage({Key? key}) : super(key: key);

  @override
  _ToutesLesListesPageState createState() => _ToutesLesListesPageState();
}

class _ToutesLesListesPageState extends State<ToutesLesListesPage> {
  late Future<List<Liste>> _listesFuture;

  @override
  void initState() {
    super.initState();
    _listesFuture = _getListes();
  }

  Future<List<Liste>> _getListes() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchListes();
  }

  void _deleteListe(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteListe(id);
    setState(() {
      _listesFuture = _getListes(); // Update the list after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les Listes'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_launcher.png', // Replace with your app icon path
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Littératus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Toutes les listes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Tous les achats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchatListePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text('Ajouter un achat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Répartition du budget'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart_outline_rounded),
              title: const Text('Ajouter un secteur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterSecteurPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Parametres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Liste>>(
                future: _listesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Erreur lors du chargement des listes: ${snapshot.error}');
                    return const Center(child: Text('Erreur de chargement'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucune liste trouvée'));
                  }

                  final listes = snapshot.data!;

                  return ListView.builder(
                    itemCount: listes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listes[index].title),
                        subtitle: Text(DateFormat('dd MMM yyyy', 'fr_FR').format(listes[index].date)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListeDetailPage(
                                listeId: listes[index].id,
                              ),
                            ),
                          );
                        },

                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteListe(listes[index].id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AjouterListePage()),
                  );

                  if (result == true) {
                    setState(() {
                      _listesFuture = _getListes(); // Refresh the list if a new list was added
                    });
                  }
                },
                child: const Text('Ajouter une liste'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class AjouterListePage extends StatefulWidget {
  const AjouterListePage({super.key});

  @override
  _AjouterListePageState createState() => _AjouterListePageState();
}

class _AjouterListePageState extends State<AjouterListePage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _saveListe() async {
    final title = _titleController.text;
    final date = _selectedDate;

    if (title.isNotEmpty && date != null) {
      final nouvelleListe = Liste.withoutId(
        title: title,
        date: date, // Ensure the date is in ISO format
      );

      final dbHelper = DBHelper();
      await dbHelper.insertListe(nouvelleListe);

      // Optionally, show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Liste ajoutée avec succès!')),
      );

      Navigator.pop(context, true); // Pass true to indicate that a new list was added
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Liste'),
        backgroundColor: Colors.blue,
      ),
    body: Center(
    child: Container(
    width: 400,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(
    color: Colors.grey,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Colors.black12,
    blurRadius: 6,
    offset: Offset(0, 2),
    ),
    ],
    ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text(_selectedDate == null
                  ? 'Sélectionner la date'
                  : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveListe,
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    ));
  }
}

class ListeDetailPage extends StatefulWidget {
  final int listeId;

  const ListeDetailPage({Key? key, required this.listeId}) : super(key: key);

  @override
  _ListeDetailPageState createState() => _ListeDetailPageState();
}

class _ListeDetailPageState extends State<ListeDetailPage> {
  late Future<List<Book>> _booksFuture;
  late Future<Liste?> _listeFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _getListBooks(widget.listeId);
    _listeFuture = _getListe(widget.listeId);
  }

  Future<List<Book>> _getListBooks(int id) async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchListBooks(id);
  }

  Future<Liste?> _getListe(int listeId) async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchListe(listeId);
  }

  void _deleteBook(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteBook(id);
    setState(() {
      _booksFuture = _getListBooks(widget.listeId); // Update the book list after deletion
    });
  }



  void _seeBook(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewBookPage(bookId: id),
      ),
    );
  }

  void _updateBook(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateBookPage(bookId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Liste?>(
          future: _listeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Chargement...');
            } else if (snapshot.hasError) {
              return const Text('Erreur');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('Liste non trouvée');
            } else {
              final liste = snapshot.data!;
              return Text('Livres de la liste "${liste.title}"');
            }
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: _booksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Erreur lors du chargement des livres: ${snapshot.error}');
                    return const Center(child: Text('Erreur de chargement'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucun livre trouvé'));
                  }

                  final books = snapshot.data!;
                  final double totalPrix = books.fold(0.0, (sum, book) => sum + book.prix);

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = constraints.maxWidth < 840 ? 3 : 4;

                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: books.length,
                              itemBuilder: (context, index) {
                                return BookCard2(
                                  book: books[index],
                                  onDelete: () => _deleteBook(books[index].id),
                                  onSee: () => _seeBook(books[index].id),
                                  onUpdate: () => _updateBook(books[index].id),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${totalPrix.toStringAsFixed(2)} € (${(totalPrix*10).toStringAsFixed(2)} dh)',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}







class AchatListePage extends StatefulWidget {
  const AchatListePage({Key? key}) : super(key: key);

  @override
  _AchatListePageState createState() => _AchatListePageState();
}

class _AchatListePageState extends State<AchatListePage> {
  late Future<List<Achat>> _achatsFuture;

  @override
  void initState() {
    super.initState();
    _achatsFuture = _getAchats();
  }

  Future<List<Achat>> _getAchats() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchAchats();
  }

  void _deleteAchat(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteAchat(id);
    setState(() {
      _achatsFuture = _getAchats();
    });
  }

  void _changeStatus(Achat achat) async {
    final dbHelper = DBHelper();
    final newStatus = achat.status == AchatStatus.enCours ? AchatStatus.termine : AchatStatus.enCours;
    await dbHelper.updateAchatStatus(achat.id, newStatus);
    setState(() {
      achat.status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Achats'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_launcher.png', // Replace with your app icon path
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Littératus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Toutes les listes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Tous les achats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchatListePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text('Ajouter un achat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Répartition du budget'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart_outline_rounded),
              title: const Text('Ajouter un secteur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterSecteurPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Parametres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FutureBuilder<List<Achat>>(
            future: _achatsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucun achat trouvé.'));
              }

              final achats = snapshot.data!;
              final double totalPrix = achats
                  .where((achat) => achat.status == AchatStatus.enCours)
                  .fold(0.0, (sum, achat) => sum + achat.prix);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, // Enable vertical scrolling
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 16,
                          dataRowHeight: 64,
                          headingRowHeight: 56,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          columns: [
                            DataColumn(
                              label: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Titre',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Prix',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Lieu',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Statut',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Actions',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: achats.map((achat) {
                            return DataRow(
                              cells: [
                                DataCell(Text(achat.title)),
                                DataCell(Text('${achat.prix.toStringAsFixed(2)} dh')),
                                DataCell(Text(achat.lieu)),
                                DataCell(Text(achat.status == AchatStatus.enCours ? 'En cours' : 'Terminé')),
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          achat.status == AchatStatus.enCours ? Icons.check : Icons.cancel,
                                          color: achat.status == AchatStatus.enCours ? Colors.green : Colors.red,
                                        ),
                                        onPressed: () => _changeStatus(achat),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteAchat(achat.id),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total: ${totalPrix.toStringAsFixed(2)} dh',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
              );
            },
            child: const Text('Ajouter un achat'),
          ),
        ),
      ],
    ),
  ),
),

    );
  }
}




class AjouterAchatPage extends StatefulWidget {
  const AjouterAchatPage({super.key});

  @override
  _AjouterAchatPageState createState() => _AjouterAchatPageState();
}

class _AjouterAchatPageState extends State<AjouterAchatPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _prixController = TextEditingController();
  final _lieuController = TextEditingController();
  AchatStatus _status = AchatStatus.enCours;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Achat'),
        backgroundColor: Colors.blueAccent,

      ),
      body: Center(
        child: Container(
        width: 400,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
        color: Colors.grey,
        width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
        BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 2),
        ),
        ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Veuillez entrer un prix valide';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lieuController,
                decoration: const InputDecoration(labelText: 'Lieu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un lieu';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<AchatStatus>(
                value: _status,
                onChanged: (AchatStatus? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: AchatStatus.values.map((AchatStatus status) {
                  return DropdownMenuItem<AchatStatus>(
                    value: status,
                    child: Text(
                      status == AchatStatus.enCours ? 'En cours' : 'Terminé',
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Statut'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newAchat = Achat.withoutId(
                      title: _titleController.text,
                      prix: double.tryParse(_prixController.text) ?? 0.0,
                      lieu: _lieuController.text,
                      status: _status,
                    );
                    final dbHelper = DBHelper();
                    dbHelper.insertAchat(newAchat).then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AchatListePage()),
                      );                    }).catchError((error) {
                      // Handle database errors here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erreur lors de l\'ajout: $error')),
                      );
                    });
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}


class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}
class _BudgetPageState extends State<BudgetPage> {
  late Future<List<Secteur>> _secteursFuture;
  final double totalBudget = 5000.0; // Total budget

  @override
  void initState() {
    super.initState();
    _secteursFuture = _getSecteurs();
  }

  Future<List<Secteur>> _getSecteurs() async {
    final dbHelper = DBHelper();
    return await dbHelper.fetchSecteurs(); // Assuming you have a fetchSecteurs method in DBHelper
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Répartition du budget'),
          backgroundColor: Colors.blueAccent,
          bottom: const TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Liste des Secteurs'),
              Tab(text: 'Répartition'), // Replace with your second tab name
            ],
          ),
        ),drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_launcher.png', // Replace with your app icon path
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Littératus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Littératus')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Toutes les listes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToutesLesListesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Tous les achats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchatListePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text('Ajouter un achat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterAchatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Parametres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),

        body: TabBarView(
          children: [
            _buildSecteursTab(),
            _buildPieChartTab(),
          ],
        ),
      ),
    );
  }
  deleteSecteur(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteSecteur(id);
    setState(() {
      _secteursFuture = _getSecteurs();
    });
  }
  Widget _buildSecteursTab() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: FutureBuilder<List<Secteur>>(
              future: _secteursFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Aucun secteur trouvé.');
                }

                final secteurs = snapshot.data!;
                return Container(
                  width: 600,
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: secteurs.length,
                    itemBuilder: (context, index) {
                      final secteur = secteurs[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            secteur.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          subtitle: Text(
                            '${secteur.prix.toStringAsFixed(2)} dh',
                            textAlign: TextAlign.left,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await deleteSecteur(secteur.id);
                              setState(() {
                                _secteursFuture = _getSecteurs(); // Rafraîchir la liste après suppression
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjouterSecteurPage()),
              );
            },
            child: const Text('Ajouter un secteur'),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartTab() {
    return FutureBuilder<List<Secteur>>(
      future: _secteursFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun secteur trouvé.'));
        }

        final secteurs = snapshot.data!;
        double usedBudget = secteurs.fold(0.0, (sum, secteur) => sum + secteur.prix);
        double remainingBudget = totalBudget - usedBudget;

        List<PieChartSectionData> sections = secteurs.map((secteur) {
          double percentage = (secteur.prix / totalBudget) * 100;
          return PieChartSectionData(
            radius: 160,
            value: secteur.prix,
            title: '${secteur.title}',
            titleStyle: TextStyle(
              fontSize: 10, // Set the font size for the title
              fontWeight: FontWeight.bold, // Optional: Set font weight
              color: Colors.white, // Set the color of the title
            ),
            color: Colors.primaries[secteurs.indexOf(secteur) % Colors.primaries.length],
          );
        }).toList();

        if (remainingBudget > 0) {
          sections.add(PieChartSectionData(
            radius: 160,
            value: remainingBudget,
            title: 'Libre',
            titleStyle: TextStyle(
              fontSize: 10, // Set the font size for the title
              fontWeight: FontWeight.bold, // Optional: Set font weight
              color: Colors.white, // Set the color of the title
            ),
            color: Colors.grey,
          ));
        }

        return Column(
          children: [
            Center(
              child: Container(
                width: 800,
                height: 500,
                padding: const EdgeInsets.all(16.0),
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ),
            SizedBox(height:2), // Spacing between chart and legend
            Container(
              width: 600,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 16, // Spacing between columns
                runSpacing: 8, // Spacing between rows
                children: sections.map((section) {
                  return Container(
                    width:250,//Set width for each item (adjust based on your needs)
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: section.color,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${((section.value / totalBudget) * 100).toStringAsFixed(1)}% - ${section.title} :  ${section.value.toStringAsFixed(2)} dh',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20), // Spacing before total amount
            Text(
              'Total Budget: ${totalBudget.toStringAsFixed(2)} dh',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}




class AjouterSecteurPage extends StatefulWidget {
  const AjouterSecteurPage({Key? key}) : super(key: key);

  @override
  _AjouterSecteurPageState createState() => _AjouterSecteurPageState();
}

class _AjouterSecteurPageState extends State<AjouterSecteurPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _prixController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final secteur = Secteur.withoutId(
        title: _titleController.text,
        prix: double.tryParse(_prixController.text) ?? 0.0,
      );

      final dbHelper = DBHelper();
      await dbHelper.insertSecteur(secteur);

      // Redirection vers la page "Répartition du budget"
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BudgetPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un secteur'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _prixController,
                  decoration: const InputDecoration(
                    labelText: 'Prix',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Veuillez entrer un prix valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Ajouter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}