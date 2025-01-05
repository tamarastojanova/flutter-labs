import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/joke_model.dart';
import 'package:new_flutter_project/services/api_service.dart';
import 'package:new_flutter_project/widgets/jokes/joke_card.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {
  Joke randomJoke = Joke(type: '', setup: '', punchline: '', id: 0);

  @override
  void initState() {
    super.initState();
    getRandomJoke();
  }

  void getRandomJoke() async {
    try {
      final response = await ApiService.getRandomJoke();
      final data = json.decode(response.body);
      setState(() {
        randomJoke = Joke.fromJson(data);
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Joke"),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: JokeCard(joke: randomJoke),
        ),
      ),
    );
  }
}
