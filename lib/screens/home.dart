import 'package:cours_flutter_rick_et_morty/screens/details_page.dart';
import 'package:cours_flutter_rick_et_morty/service/characters_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Les profils "en dur" sont stockés dans cette variable
    var profiles = CharactersService().profiles;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rick & Morty - Profiler"),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) => _listElement(context, profiles[index]),
      ),
    );
  }
}

Widget _listElement(context, character) {
  return ListTile(
    leading: Image.network(character.image),
    title: Text(character.name),
    subtitle: Text(character.species),
    onTap: () => Navigator.push(
      context,

      // MaterialPageRoute implemente une transition standard pour la Librairie Material (Android)

      MaterialPageRoute(
        builder: (context) => DetailsPage(character: character),
      ),

      // On peut utiliser PageRouteBuilder au lieu de MaterialPageRoute pour customiser la navigation
      // PageRouteBuilder est construit autour de la 'page' et de la 'transition'.
      // Sans rentrer dans le détail, voici un exemple issu de la documentation.
      // Décommentez 'PageRouteBuilder' ci-dessous et commentez 'MaterialPageRoute' plus haut pour voir
      // un exemple de transition pas très standard ^^...

      // PageRouteBuilder<void>(
      //   opaque: false,
      //   pageBuilder: (BuildContext context, _, __) =>
      //       DetailsPage(character: character),
      //   transitionsBuilder:
      //       (___, Animation<double> animation, ____, Widget child) {
      //     return FadeTransition(
      //       opacity: animation,
      //       child: RotationTransition(
      //         turns: Tween<double>(begin: 0.5, end: 2.0).animate(animation),
      //         child: child,
      //       ),
      //     );
      //   },
      // ),
    ),
  );
}
