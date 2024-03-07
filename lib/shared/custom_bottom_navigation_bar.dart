import 'package:cours_flutter_rick_et_morty/screens/episodes.dart';
import 'package:cours_flutter_rick_et_morty/screens/home.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Characters",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: "Episodes",
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) => _navigate(context, index),
    );
  }

  // Gestion de la navigation en fonction de l'index cliqué
  _navigate(BuildContext context, int index) {
    late Widget destination;

    switch (index) {
      case 0:
        destination = const Home();
        break;
      case 1:
        destination = const Episodes();
        break;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Le widget que vous souhaitez afficher
          return destination;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Aucune animation n'est définie, donc pas de transition
          return child;
        },
      ),
    );
  }

  // Dans le cas d'une navigation nommée
  // _navigate(BuildContext context, int index) {
  //   String path = "/";

  //   switch (index) {
  //     case 0:
  //       path = "/characters";
  //       break;
  //     case 1:
  //       path = "/episodes";
  //       break;
  //   }

  //   Navigator.pushNamed(context, path);
  // }
}
