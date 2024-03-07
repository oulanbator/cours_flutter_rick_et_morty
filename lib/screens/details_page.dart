import 'package:cours_flutter_rick_et_morty/model/character.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Character character;

  const DetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profil - ${character.name}"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.network(character.image),
              Text("Espèce : ${character.species}"),
              Text("Origine : ${character.origin}"),
              Text("Statut : ${character.status}"),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Retour"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
