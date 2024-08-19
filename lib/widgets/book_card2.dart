import 'package:flutter/material.dart';
import '../models/book.dart';

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
            child: book.imagePath.isNotEmpty
                ? Image.asset(
              book.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/augusteclaute.webp', // Image de remplacement
                  fit: BoxFit.cover,
                );
              },
            )
                : Image.asset(
              'assets/augusteclaute.webp', // Image de remplacement
              fit: BoxFit.cover,
            ),
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
                    'Date de parution: ${book.dateParution.toLocal().toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Text(
                    'Auteur: ${book.auteur}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.yellow,
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
}
