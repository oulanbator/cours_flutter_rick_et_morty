import 'package:cours_flutter_rick_et_morty/screens/details_page.dart';
import 'package:cours_flutter_rick_et_morty/service/characters_service.dart';
import 'package:cours_flutter_rick_et_morty/shared/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // référence à notre service
    var service = CharactersService();

    return Scaffold(
      appBar: AppBar(
        // Permet de supprimer la flèche "retour arrière" sur nos vues principales
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // On peut renommer cet écran pour tenir compte de la nouvelle structure de nottre application
        title: const Text("Personnages"),
      ),
      // BottomNavBar avec l'index sélectionné : 0
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // On wrap le ListView dans un FutureBuilder
      body: FutureBuilder(
        future: service.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Si l'on récupère la data correctement, afficher un ListView
            var characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) =>
                  _listElement(context, characters[index]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            // Par défaut, afficher un Spinner
            return const Center(child: CircularProgressIndicator());
          }
        },
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
      MaterialPageRoute(
        builder: (context) => DetailsPage(character: character),
      ),
    ),
  );
}
