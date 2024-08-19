import 'dart:io';

import 'package:flutter/material.dart';
import 'package:litteratus/widgets/book_card2.dart';
import 'package:path_provider/path_provider.dart';
import 'db_helper.dart';
import 'models/achat.dart';
import 'models/book.dart';
import 'models/liste.dart';
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
              title: const Text('Tous les listes'),
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
      _booksFuture = _getBooks(); // Update the book list after deletion
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



class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> types = ['Epub', 'Pdf'];
  String? selectedType;
  int? selectedListId; // New field for selected list ID
  List<Liste> listes = []; // List of Liste objects

  // Champs du livre
  String title = '';
  String imagePath = "";
  double prix = 0.0;
  DateTime? dateParution;
  String auteur = '';
  String type = '';

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

      // Créer un objet Book avec les données du formulaire
      final book = Book.withoutId(
        title: title,
        imagePath: imagePath,
        prix: prix,
        dateParution: dateParution!,
        auteur: auteur,
        type: type,
        listId: selectedListId, // Add the selected list ID
      );

      // Insérer le livre dans la base de données
      await DBHelper().insertBook(book);

      print('Book saved to the database');
    }
  }

  Future<void> _pickImage() async {
    try {
      // Open gallery to select an image
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Get the directory of the app's documents
        final directory = await getExternalStorageDirectory(); // Use getExternalStorageDirectory for Android

        // Create a custom folder if it doesn't exist
        final String customFolder = '${directory!.path}/Imageslivres';
        await Directory(customFolder).create(recursive: true);

        final fileName = path.basename(pickedFile.path);
        final filePath = '$customFolder/$fileName';

        // Copy the selected file to the custom folder
        final File imageFile = File(pickedFile.path);
        final File savedImage = await imageFile.copy(filePath);

        // Update the state with the path of the copied file
        setState(() {
          imagePath = savedImage.path;
        });

        print('Image saved to: $imagePath');
      }
    } catch (e) {
      print('Error selecting image: $e');
      // Display an error message to the user if needed
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
                      print('Liste ID: $selectedListId'); // Print the selected list ID
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
                        subtitle: Text(listes[index].date.toString()),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
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
              return Text('Liste des livres de la liste ${liste.title}');
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
                                return BookCard(
                                  book: books[index],
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
                                  '${totalPrix.toStringAsFixed(2)} dh',
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
                                        fontSize: 20
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
                                        fontSize: 20
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
                                        fontSize: 20
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
                                        fontSize: 20
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
                                        fontSize: 20
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
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total: ${totalPrix.toStringAsFixed(2)} dh',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(width: 16), // Add spacing if needed
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

