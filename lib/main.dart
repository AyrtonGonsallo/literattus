import 'dart:io';

import 'package:flutter/material.dart';
import 'package:litteratus/widgets/book_card2.dart';
import 'package:path_provider/path_provider.dart';
import 'db_helper.dart';
import 'models/book.dart';
import 'widgets/book_card.dart';
import 'package:image_picker/image_picker.dart'; // Pour sélectionner une image
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Littératus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              leading: const Icon(Icons.book_rounded),
              title: const Text('Tous les livres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              title: const Text('Tous les livres en db'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PBooksPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

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
      ),
      Book.withoutId(
        title: 'La femme et le soldat - Viols et violences de guerre du Moyen Age à nos jours',
        imagePath: 'assets/femmesoldat.webp',
        prix: 14.99,
        dateParution: DateTime(2012, 1, 21),
        auteur: 'Maurice Agulhon',
        type: 'PDF',
      ),
      Book.withoutId(
        title: 'HISTOIRE DU VAGABONDAGE. Du Moyen Age à nos jours',
        imagePath: 'assets/vagabondage.webp',
        prix: 14.99,
        dateParution: DateTime(1998, 11, 18),
        auteur: 'Maurice Agulhon',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'La mort, l\'au-delà et les autres mondes',
        imagePath: 'assets/mort.webp',
        prix: 15.99,
        dateParution: DateTime(2019, 2, 20),
        auteur: 'Claude Lecouteux',
        type: 'PDF',
      ),
      Book.withoutId(
        title: 'Rabelais en Vendée',
        imagePath: 'assets/rabelais.webp',
        prix: 9.99,
        dateParution: DateTime(2004, 6, 1),
        auteur: 'Gilbert Prouteau',
        type: 'PDF',
      ),
      Book.withoutId(
        title: 'Rire avec Dieu - L\'humour chez les chrétiens, les juifs et les musulmans',
        imagePath: 'assets/rire.webp',
        prix: 17.99,
        dateParution: DateTime(2019, 5, 9),
        auteur: 'Marc Lienhard',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Vivre la misère au Moyen Age',
        imagePath: 'assets/misere.webp',
        prix: 17.99,
        dateParution: DateTime(2023, 4, 7),
        auteur: 'Jean-Louis Roch',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Brigands, bandits, malfaiteurs - Incroyables histoires des crapules, arsouilles, monte-en-l\'air, canailles et contrebandiers de tous les temps',
        imagePath: 'assets/brigants.webp',
        prix: 9.99,
        dateParution: DateTime(2017, 9, 11),
        auteur: 'Bernard Hautecloque',
        type: 'Multi-format',
      ),
      Book.withoutId(
        title: 'L\'amoureuse histoire d\'Auguste Comte et de Clotilde de Vaux',
        imagePath: 'assets/augusteclaute.webp',
        prix: 10.99,
        dateParution: DateTime(1917, 1, 1),
        auteur: 'Charles de Rouvre',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'John Milton, poète combattant',
        imagePath: 'assets/milton.webp',
        prix: 9.99,
        dateParution: DateTime(1959, 1, 1),
        auteur: 'Emile Saillens',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Kierkegaard, écrire ou mourir',
        imagePath: 'assets/kierkegaard.webp',
        prix: 12.99,
        dateParution: DateTime(2015, 1, 1),
        auteur: 'Stéphane Vial',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Esprit, es-tu là? Histoires du surnaturel, de l\'Antiquité à nos jours',
        imagePath: 'assets/surnaturel.webp',
        prix: 12.99,
        dateParution: DateTime(2013, 11, 8),
        auteur: 'Vivianne Perret',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Armageddon - Une histoire de la fin du monde',
        imagePath: 'assets/findumonde.webp',
        prix: 14.99,
        dateParution: DateTime(2024, 3, 6),
        auteur: 'Régis Burnet, Pierre-Edouard Detal',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'L\'Apologétique chrétienne - Expressions de la pensée religieuse, de l\'Antiquité à nos jours',
        imagePath: 'assets/apologetique.webp',
        prix: 11.99,
        dateParution: DateTime(2019, 9, 3),
        auteur: 'Didier Boisson, Elisabeth Pinto-Mathieu',
        type: 'Multi-format',
      ),
      Book.withoutId(
        title: 'La Prostitution devant le philosophe',
        imagePath: 'assets/prostphil.webp',
        prix: 1.99,
        dateParution: DateTime(2016, 8, 5),
        auteur: 'Charles Richard',
        type: 'Multi-format',
      ),
      Book.withoutId(
        title: 'Dis socrate, c\'est quoi l\'amour ? - Quand les philosophes discutent du plus beau des sentiments',
        imagePath: 'assets/socrateamour.webp',
        prix: 13.99,
        dateParution: DateTime(2021, 10, 4),
        auteur: 'Nora Kreft',
        type: 'ePub',
      ),
      Book.withoutId(
        title: 'Le vrai métier des philosophes',
        imagePath: 'assets/vraimetier.webp',
        prix: 10.99,
        dateParution: DateTime(2024, 5, 29),
        auteur: 'Nassim El Kabli',
        type: 'ePub',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des livres'),
        backgroundColor: Colors.blueAccent,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('This is the Settings page'),
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
      _booksFuture = _getBooks(); // Met à jour la liste des livres après suppression
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des livres'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
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
  // Champs du livre
  String title = '';
  String imagePath="";
  double prix = 0.0;
  DateTime? dateParution;
  String auteur = '';
  String type = '';

  Future<void> _saveBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Créer un objet Book avec les données du formulaire
      final book = Book.withoutId(
        title: title,
        imagePath: imagePath,
        prix: prix,
        dateParution: dateParution!,
        auteur: auteur,
        type: type,
      );

      // Insérer le livre dans la base de données
      await DBHelper().insertBook(book);

      print('Book saved to the database');
    }
  }

  Future<void> _pickImage() async {
    try {
      // Ouvrir la galerie pour sélectionner une image
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Obtenir le répertoire des documents de l'application
        final directory = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedFile.path);
        final filePath = '${directory.path}/$fileName';

        // Copier le fichier sélectionné dans le répertoire des documents
        final File imageFile = File(pickedFile.path);
        final File savedImage = await imageFile.copy(filePath);

        // Mettre à jour l'état avec le chemin du fichier copié
        setState(() {
          imagePath = savedImage.path;
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image: $e');
      // Vous pouvez également afficher un message d'erreur à l'utilisateur
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
                      child: Text(imagePath == null
                          ? 'Aucune image sélectionnée'
                          : 'Image: ${path.basename(imagePath!)}'),
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
                      _saveBook();

                    }
                  },
                  child: const Text('Ajouter le livre'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}