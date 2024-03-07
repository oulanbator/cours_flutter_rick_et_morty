import 'package:cours_flutter_rick_et_morty/service/characters_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Les profils "en dur" sont stockés dans cette variable
    var profiles = CharactersService().profiles;

    return const Placeholder();
  }
}
