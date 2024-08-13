import 'package:flutter/material.dart';
import 'models/book.dart';
import 'widgets/book_card.dart';
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
      Book(
        title: 'Le duel sous l\'Ancien Régime',
        imagePath: 'assets/duel.webp',
        prix: 9.99,
        dateParution: DateTime(1982, 1, 1),
        auteur: 'Micheline Cuénin, Yves-Marie Bercé, Jacques Callot, Evelyne Lever, Maurice Lever',
        type: 'ePub',
      ),
      Book(
        title: 'La femme et le soldat - Viols et violences de guerre du Moyen Age à nos jours',
        imagePath: 'assets/femmesoldat.webp',
        prix: 14.99,
        dateParution: DateTime(2012, 1, 21),
        auteur: 'Maurice Agulhon',
        type: 'PDF',
      ),
      Book(
        title: 'HISTOIRE DU VAGABONDAGE. Du Moyen Age à nos jours',
        imagePath: 'assets/vagabondage.webp',
        prix: 14.99,
        dateParution: DateTime(1998, 11, 18),
        auteur: 'Maurice Agulhon',
        type: 'ePub',
      ),
      Book(
        title: 'La mort, l\'au-delà et les autres mondes',
        imagePath: 'assets/mort.webp',
        prix: 15.99,
        dateParution: DateTime(2019, 2, 20),
        auteur: 'Claude Lecouteux',
        type: 'PDF',
      ),
      Book(
        title: 'Rabelais en Vendée',
        imagePath: 'assets/rabelais.webp',
        prix: 9.99,
        dateParution: DateTime(2004, 6, 1),
        auteur: 'Gilbert Prouteau',
        type: 'PDF',
      ),
      Book(
        title: 'Rire avec Dieu - L\'humour chez les chrétiens, les juifs et les musulmans',
        imagePath: 'assets/rire.webp',
        prix: 17.99,
        dateParution: DateTime(2019, 5, 9),
        auteur: 'Marc Lienhard',
        type: 'ePub',
      ),
      Book(
        title: 'Vivre la misère au Moyen Age',
        imagePath: 'assets/misere.webp',
        prix: 17.99,
        dateParution: DateTime(2023, 4, 7),
        auteur: 'Jean-Louis Roch',
        type: 'ePub',
      ),
      Book(
        title: 'Brigands, bandits, malfaiteurs - Incroyables histoires des crapules, arsouilles, monte-en-l\'air, canailles et contrebandiers de tous les temps',
        imagePath: 'assets/brigants.webp',
        prix: 9.99,
        dateParution: DateTime(2017, 9, 11),
        auteur: 'Bernard Hautecloque',
        type: 'Multi-format',
      ),
      Book(
        title: 'L\'amoureuse histoire d\'Auguste Comte et de Clotilde de Vaux',
        imagePath: 'assets/augusteclaute.webp',
        prix: 10.99,
        dateParution: DateTime(1917, 1, 1),
        auteur: 'Charles de Rouvre',
        type: 'ePub',
      ),
      Book(
        title: 'John Milton, poète combattant',
        imagePath: 'assets/milton.webp',
        prix: 9.99,
        dateParution: DateTime(1959, 1, 1),
        auteur: 'Emile Saillens',
        type: 'ePub',
      ),
      Book(
        title: 'Kierkegaard, écrire ou mourir',
        imagePath: 'assets/kierkegaard.webp',
        prix: 12.99,
        dateParution: DateTime(2015, 1, 1),
        auteur: 'Stéphane Vial',
        type: 'ePub',
      ),
      Book(
        title: 'Esprit, es-tu là? Histoires du surnaturel, de l\'Antiquité à nos jours',
        imagePath: 'assets/surnaturel.webp',
        prix: 12.99,
        dateParution: DateTime(2013, 11, 8),
        auteur: 'Vivianne Perret',
        type: 'ePub',
      ),
      Book(
        title: 'Armageddon - Une histoire de la fin du monde',
        imagePath: 'assets/findumonde.webp',
        prix: 14.99,
        dateParution: DateTime(2024, 3, 6),
        auteur: 'Régis Burnet, Pierre-Edouard Detal',
        type: 'ePub',
      ),
      Book(
        title: 'L\'Apologétique chrétienne - Expressions de la pensée religieuse, de l\'Antiquité à nos jours',
        imagePath: 'assets/apologetique.webp',
        prix: 11.99,
        dateParution: DateTime(2019, 9, 3),
        auteur: 'Didier Boisson, Elisabeth Pinto-Mathieu',
        type: 'Multi-format',
      ),
      Book(
        title: 'La Prostitution devant le philosophe',
        imagePath: 'assets/prostphil.webp',
        prix: 1.99,
        dateParution: DateTime(2016, 8, 5),
        auteur: 'Charles Richard',
        type: 'Multi-format',
      ),
      Book(
        title: 'Dis socrate, c\'est quoi l\'amour ? - Quand les philosophes discutent du plus beau des sentiments',
        imagePath: 'assets/socrateamour.webp',
        prix: 13.99,
        dateParution: DateTime(2021, 10, 4),
        auteur: 'Nora Kreft',
        type: 'ePub',
      ),
      Book(
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
            int columns = constraints.maxWidth < 840 ? 2 : 4;

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


class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un livre'),
      ),
      body: const Center(
        child: Text('Page pour ajouter des livres'),
      ),
    );
  }
}