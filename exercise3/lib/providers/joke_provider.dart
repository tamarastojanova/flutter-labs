import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/joke_model.dart';

class JokeProvider extends ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  // Get favorite jokes
  List<Joke> get favoriteJokes => _favoriteJokes;

  // Check if a joke is in the favorites list
  bool isFavorite(Joke joke) {
    return _favoriteJokes.any((favoriteJoke) => favoriteJoke.id == joke.id);
  }

  // Toggle favorite status
  void toggleFavorite(Joke joke) {
  if (isFavorite(joke)) {
    _favoriteJokes.removeWhere((favoriteJoke) => favoriteJoke.id == joke.id);
    print('Removed from favorites');
  } else {
    _favoriteJokes.add(joke);
    print('Added to favorites');
  }
  notifyListeners();
}

}

