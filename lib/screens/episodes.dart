import 'package:cours_flutter_rick_et_morty/model/episode.dart';
import 'package:cours_flutter_rick_et_morty/service/episodes_service.dart';
import 'package:cours_flutter_rick_et_morty/shared/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Episodes extends StatelessWidget {
  const Episodes({super.key});

  @override
  Widget build(BuildContext context) {
    var service = EpisodesService();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Episodes"),
        ),
        // BottomNavBar avec l'index sélectionné : 1
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
        body: FutureBuilder(
          future: service.fetchEpisodes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Si l'on récupère la data correctement, afficher un ListView
              var episodes = snapshot.data!;
              return ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (context, index) =>
                    _listElement(context, episodes[index]),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              // Par défaut, afficher un Spinner
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Widget _listElement(BuildContext context, Episode episode) {
  return ListTile(
    title: Text('${episode.episode} - ${episode.title}'),
    subtitle: Text(episode.date),
    onTap: () {},
  );
}
