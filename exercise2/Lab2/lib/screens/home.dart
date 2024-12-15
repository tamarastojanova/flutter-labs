import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/types/types_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getTypesFromJokeAPI();
  }

  void getTypesFromJokeAPI() async {
    ApiService.getTypesFromJokeAPI().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        types = data.map((element) => element.toString()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text(
          "Jokes App",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/random_joke');
            },
            icon: const Icon(Icons.newspaper, color: Colors.white, size: 24),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TypesList(types: types),
            ),
          ],
        ),
      ),
    );
  }
}
