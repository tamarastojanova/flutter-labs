import 'package:flutter/material.dart';
import 'package:new_flutter_project/providers/joke_provider.dart';
import 'package:new_flutter_project/widgets/jokes/joke_card.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = Provider.of<JokeProvider>(context).favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text(
          "Favorite Jokes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
              child: Text(
                "No favorite jokes yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoriteJokes[index];
                return JokeCard(joke: joke);
              },
            ),
    );
  }
}
