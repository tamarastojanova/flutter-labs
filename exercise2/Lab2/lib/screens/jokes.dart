import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/joke_model.dart';
import 'package:new_flutter_project/services/api_service.dart';
import '../widgets/jokes/joke_card.dart';

class Jokes extends StatefulWidget {
  const Jokes({super.key});

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes> {
  List<Joke> jokes = [];
  String type = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final type = ModalRoute.of(context)?.settings.arguments as String;
    if (type.isNotEmpty) {
      getJokes(type);
    }
  }

  void getJokes(String type) async {
    try {
      final response = await ApiService.getJokesForType(type);
      setState(() {
        jokes = List<Joke>.from(response.map((json) => Joke.fromJson(json)));
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
        backgroundColor: Colors.pink[100],
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return JokeCard(joke: joke);
              },
            ),
    );
  }
}
