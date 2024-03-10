# TP : Rick et Morty

Un TP pour voir différents concepts clés dans Flutter :
- Les ListViews
- L'intéraction et la navigation
- Les requêtes asynchrones et l'utilisation de Futures
- Les objets métier et la désérialisation
- Une barre de navigation

Ce TP s'appuie sur l'API ouverte de Rick et Morty : https://rickandmortyapi.com

Nous les remercions chaleureusement <3 !


## 1 - Création de l'écran Home (Personnages)

L'idée est d'utiliser les widgets ListView et ListTile pour afficher la liste des personnages de Rick et Morty. Pour le moment cette liste est codée "en dur" dans la classe CharactersService.

- Implémentez le widget Home qui sera notre vue principale
- Utilisez Scaffold pour créer la structure de notre écran
- Utiliser un ListView pour afficher les 6 personnages (que nous avons "en dur" dans notre service)
- Chaque personnage est représenté (a minima par son image et son nom) dans un ListTile

> https://docs.flutter.dev/cookbook/lists/basic-list (utilisation basique)

> https://docs.flutter.dev/cookbook/lists/long-lists (utlisation du constructeur .builder())

#### App démo : 
> https://github.com/oulanbator/cours_flutter_simple_list_view

## 2 - Intéractivité et navigation

Nous avons volontairement affiché le minimum d'informations dans nos ListTiles. Le but ici est d'ajouter une page de "détails" pour afficher toutes les informations que nous avons sur les personnages, et de voir comment implémenter un peu d'intéractivité dans notre app.

- Créer un autre widget pour afficher les détails d'un personnage (Image, Nom, Espèce, Origine, Statut). Vous pouvez passer des données en dur pour structurer votre écran (widgets : Text & Placeholder), et ensuite passer les bonnes informations quand vous aurez connecté votre écran aux ListTiles.
- Utiliser la propriété 'onTap' du ListTile pour afficher ce widget (avec Navigator.push())
- Ajouter un bouton 'Retour' sur la page de détails (avec Navigator.pop())

> https://docs.flutter.dev/cookbook/navigation/navigation-basics#2-navigate-to-the-second-route-using-navigatorpush 

> https://docs.flutter.dev/cookbook/navigation/navigation-basics#3-return-to-the-first-route-using-navigatorpop 

#### App démo : 
> https://github.com/oulanbator/cours_flutter_simple_list_view

## 3 - Requêtes HTTP

Maintenant que nous avons une première structure d'application intéractive, nous voulons travailler avec de vraies données. Nous allons donc essayer de mettre en place un appel HTTP, traiter la réponse, et afficher le résultat dans notre application Flutter.

- Ajouter le package HTTP
- Faire un appel HTTP dans notre service pour récupérer la donnée
> https://rickandmortyapi.com/api/character
(liste des personnages)

- Ajouter un constructeur .fromJson() à notre objet métier
- Parser la réponse à l'aide de notre constructeur et de jsonDecode.
- Utiliser un FutureBuilder pour afficher la data dans notre widget Home.

> https://docs.flutter.dev/cookbook/networking/fetch-data

> https://docs.flutter.dev/data-and-backend/serialization/json

#### App démo :
> https://github.com/oulanbator/cours-flutter-fetch-data-app

#### Conseil :
Utilisez un client HTTP comme HTTPie ou Postman quand vous travaillez avec des API web. Vous pouvez ainsi envoyer les requêtes et analyser les réponses de votre API avant (ou en parallèle) de développer vos composants qui vont consommer ces API. Cela est d'autant plus utile lorsque les réponses de l'API sont complexes, et que vont avez de la sécurité à gérer (authentification). 

## 4 - Deuxième page et BottomNavigationBar

Une BottomNavigationBar n'est qu'un type de layout parmis d'autres pour la navigation. Vous pourriez également implémenter votre navigation avec des IconButton dans votre AppBar (plus simple) ou un Drawer pour regrouper tous les items de navigation de votre application (plus complexe). Ou bien avoir une interface complètement personnalisée.. L'idée ici est de voir comment fonctionne ce composant, et une manière de l'implémenter avec un système de Navigation.

- Créer un écran Episodes (Scaffold). Pour le moment ce widget affichera simplement un Text
- Créer un widget CustomBottomNavBar qui implémente un BottomNavigationBar avec deux items : "Personnages" et "Episodes". 
- Pour gérer l'état de ce widget, une des approches possibles consiste à avoir une propriété selectedIndex (que l'on passe à ce widget) pour pouvoir savoir quel est l'item sélectionné en fonction de la page.
- Implémenter la propriété onTap() pour implémenter la navigation avec Navigator.push();
- Une autre approche serait la navigation "nommée" avec Navigator.pushNamed() et l'utilisation de "routes", mais elle requiert un peu plus de configuration et n'est pas forcément recommandée dans la documentation Flutter.
- Ajouter ce widget aux deux écrans avec la propriété bottomNavigationBar de Scaffold

> https://docs.flutter.dev/ui/navigation#using-the-navigator

> https://github.com/oulanbator/cours-flutter-bottom-navigation-app

#### App démo :
> https://github.com/oulanbator/cours_flutter_bottom_navbar

## 5 - Création de l'écran Episodes

L'API est relativement limitée sur les informations fournies sur un épisode. Mais pour donner un peu de corps à notre application et surtout pour pratiquer ce que nous avons vu sur les trois premiers exercices, nous allons implémenter la page Episodes. Rien de nouveau dans cette partie :

- Conseil : Utiliser un client HTTP pour analyser la réponse de l'API
> https://rickandmortyapi.com/api/episode
(liste des episodes)

- Créer la classe Episode avec des champs pour stocker le code de l'episode (exp. S01E01), son titre et sa date de sortie.
- Créer un constructeur fromJson() pour vous aider à parser votre réponse HTTP
- Créer un service EpisodeService qui va envoyer les appels HTTP et traiter la réponse
- Implémenter l'écran Episodes. Compte tenu des informations que nous avons pour chaque épisode, le plus simple serait d'utiliser une ListView. Chaque ListTile afficherait le code, le titre et la date de l'épisode.
