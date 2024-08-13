import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              book.imagePath,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
