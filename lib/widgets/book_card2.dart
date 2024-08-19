import 'package:flutter/material.dart';
import '../models/book.dart';
import 'dart:io'; // Import this for File

class BookCard2 extends StatelessWidget {
  final Book book;
  final VoidCallback onDelete;

  const BookCard2({super.key, required this.book, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: _getImageWidget(book.imagePath),
          ),
          // Boîte d'informations avec fond semi-transparent
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black.withOpacity(0.5), // Fond semi-transparent
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12, // Taille de la police
                      height: 1.2, // Hauteur de ligne (line height)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prix: ${book.prix.toStringAsFixed(2)} €',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Date: ${book.dateParution.toLocal().toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Text(
                    'Auteur: ${book.auteur}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.yellow,
                      fontSize: 10, // Taille de la police
                      height: 1, // Hauteur de ligne (line height)
                    ),
                  ),
                  Text(
                    'Type: ${book.type}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                  // Bouton de suppression
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get the correct image widget
  Widget _getImageWidget(String imagePath) {
    // Check if the file exists in the custom folder
    final File file = File(imagePath);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/augusteclaute.webp', // Image de remplacement
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/augusteclaute.webp', // Image de remplacement
        fit: BoxFit.cover,
      );
    }
  }
}
