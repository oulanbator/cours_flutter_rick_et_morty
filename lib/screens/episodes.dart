import 'package:cours_flutter_rick_et_morty/shared/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Episodes extends StatelessWidget {
  const Episodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Episodes"),
      ),
      // BottomNavBar avec l'index sélectionné : 1
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
      body: const Center(
        child: Text("Liste des épisodes !"),
      ),
    );
  }
}
