# rick_and_morty

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


## 2 - Intéractivité et navigation

Nous avons volontairement affiché le minimum d'informations dans nos ListTiles. Le but ici est d'ajouter une page de "détails" pour afficher toutes les informations que nous avons sur les personnages, et de voir comment implémenter un peu d'intéractivité dans notre app.

- Créer un autre widget pour afficher les détails d'un personnage (Image, Nom, Espèce, Origine, Statut). Vous pouvez passer des données en dur pour structurer votre écran (widgets : Text & Placeholder), et ensuite passer les bonnes informations quand vous aurez connecté votre écran aux ListTiles.
- Utiliser la propriété 'onTap' du ListTile pour afficher ce widget (avec Navigator.push())
- Ajouter un bouton 'Retour' sur la page de détails (avec Navigator.pop())

> https://docs.flutter.dev/cookbook/navigation/navigation-basics#2-navigate-to-the-second-route-using-navigatorpush 

> https://docs.flutter.dev/cookbook/navigation/navigation-basics#3-return-to-the-first-route-using-navigatorpop 


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


## 5 - Création de l'écran Episodes

L'API est relativement limitée sur les informations fournies sur un épisode. Mais pour donner un peu de corps à notre application et surtout pour pratiquer ce que nous avons vu sur les trois premiers exercices, nous allons implémenter la page Episodes. Rien de nouveau dans cette partie :

- Conseil : Utiliser un client HTTP pour analyser la réponse de l'API
> https://rickandmortyapi.com/api/episode
(liste des episodes)

- Créer la classe Episode avec des champs pour stocker le code de l'episode (exp. S01E01), son titre et sa date de sortie.
- Créer un constructeur fromJson() pour vous aider à parser votre réponse HTTP
- Créer un service EpisodeSerivce qui va envoyer les appels HTTP et traiter la réponse
- Implémenter l'écran Episodes. Compte tenu des informations que nous avons pour chaque épisode, le plus simple serait d'utiliser une ListView. Chaque ListTile afficherait le code, le titre et la date de l'épisode.

## 6 - Infinite Scroll : Characters

Pour le moment, notre page listant les personnages n'affiche que les résultats du premier appel HTTP. Nous allons mettre en place un "infinite scroll", pour afficher la suite de la liste lorsque l'utilisateur scroll jusqu'au bas de l'écran.

- Explorer l'API avec un client HTTP pour réfléchir au workflow qui doit être mis en place.

Nous n'allons plus utiliser un FutureBuilder dans un widget Stateless, mais plutôt stocker/afficher la liste de Character dans un notre page (désormais stateful) et effectuer un nouveau rendu lorsque l'on charge la suite de la liste.

- Transformer Home en widget Stateful
- Définir un ScrollController, et ajouter un bool nous indiquant s'il reste du contenu à charger

```
final ScrollController _scrollController = ScrollController();
var _hasNextPage = true;
```

- Ajouter le ScrollController au ListView :

```
ListView.builder(
    controller: _scrollController,
    itemCount: characters.length,
    itemBuilder: (context, index) =>
        _listElement(context, characters[index]),
);
```

- Ajouter un listener au ScrollController lors de l'initialisation de notre widget Home, afin de détecter le "bas de page" 

```
// Cette méthode initState est appelée à l'instanciation d'un widget Stateful
@override
void initState() {
    super.initState();

    _scrollController.addListener(() {
        var maxScroll = _scrollController.position.maxScrollExtent;
        var currentScroll = _scrollController.offset;
        // Si on est en bas du ListView et qu'il y a encore des données à charger
        if (currentScroll == maxScroll && _hasNextPage) {
            print("Charge la suite");
        }
    });
}
```

Nous sommes capables de détecter le bas de page, maintenant il faut revoir l'implémentation de notre service afin de permettre le chargement des "pages" successives.

- On stocke l'url de la prochaine page à charger. Par défaut : l'url pour la première page
```
String? nextUrl = "https://rickandmortyapi.com/api/character/";
```

- La méthode fetchCharacters se sert de nextUrl pour effectuer sa requête. ELle peut renvoyer une liste de Character ou null sous forme de Future
```
Future<List<Character>?> fetchCharacters() async {
    if (nextUrl != null) {
        // On peut forcer nextUrl avec ! car on s'est assuré qu'elle n'est pas null
        final response = await http.get(Uri.parse(nextUrl!));

        if (response.statusCode == 200) {
            return parseCharacters(response.body);
        } else {
            throw Exception('Failed to load album');
        }
    } else {
        return null;
    }
}
```

- parseCharacters doit également prendre en charge de mettre à jour la prochaine url à requêter (on peut donc décider de renommer cette méthode qui devient plus généraliste)
```
List<Character> parseResponse(String responseBody) {
    final Map<String, dynamic> data = jsonDecode(responseBody);

    // Récupère et stocke la prochaine url
    nextUrl = data["info"]["next"];

    final List<dynamic> results = data['results'];

    return results
        .map((jsonElement) => Character.fromJson(jsonElement))
        .toList();
}
```

Servons nous de ce nouveau service dans notre Widget Home

- Nous allons avoir besoin d'instancier notre service
- Nous allons stocker la liste de characters directement dans notre widget Stateful
- Nous allons avoir besoin d'un bool 'loading' pour ne pas spammer l'API lorsque nous sommes en bas de page
```
final CharactersService _service = CharactersService();
final List<Character> _items = [];
final ScrollController _scrollController = ScrollController();
var _hasNextPage = true;
var _isLoading = false;
```

- Créer une méthode asynchrone pour charger des éléments via notre service
```
// Fonction pour charger des éléments supplémentaires
void _loadMoreItems() async {
    // Return si déjà en train de charger
    if (_isLoading) return;
    // Sinon, set le bool pour indiquer que l'on charge des éléments
    setState(() => _isLoading = true);
    // Récupère des données
    final newItems = await _service.fetchCharacters();
    // mise à jour du state (et nouveau rendu du widget)
    setState(() {
        // Si nextUrl est null, on set _hasNextPage à false
        if (_service.nextUrl == null) {
        _hasNextPage = false;
        }
        // Si on a des nouveaux éléments, on les ajoute à la liste
        if (newItems != null) {
        _items.addAll(newItems);
        }
        // Fin de chargement, set 'loading' à false
        _isLoading = false;
    });
}
```

- Modifier initState pour charger des items au démarrage et lorsqu'on est en bas de page
```
@override
void initState() {
    super.initState();

    _loadItems();

    _scrollController.addListener(() {
        var maxScroll = _scrollController.position.maxScrollExtent;
        var currentScroll = _scrollController.offset;
        // Si on est en bas du ListView et qu'il y a encore des données à charger
        if (currentScroll == maxScroll && _hasNextPage) {
        _loadItems();
        }
    });
}
```

On peut désormais retirer notre FutureBuilder devenu inutile, et afficher uniquement le ListView. Notre écran est re-rendu lorsqu'on utilise la méthode setState (la liste ayant été mise à jour, on affiche un écran avec plus d'éléments dans le ListView).

- Voici l'intégralité de la méthode build
```
@override
Widget build(BuildContext context) {
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
        body: ListView.builder(
            controller: _scrollController,
            itemCount: _items.length,
            itemBuilder: (context, index) => _listElement(context, _items[index]),
        ),
    );
}
```

Super ! En l'état l'infinite scroll fonctionne déjà !!
Si l'on veut ajouter un petit spinner en bas de notre écran pendant le chargement, il suffit de "manipuler" un peu le ListView, en jouant sur le nombre d'items et les éléments à afficher.

On détermine itemCount avec une expression ternaire en fonction de _hasNextPage
- S'il reste de la data à charger on doit "ajouter un slot" dans le ListView pour afficher un Spinner pendant le chargement de la page suivante
- Sinon on ne crée pas de slot supplémentaire
```
itemCount: _hasNextPage ? _items.length + 1 : _items.length,
```

- On doit également modifier noter itemBuilder
- Si l'index est inférieur à la taille "normale" de la liste, on affiche un ListTile
- Si l'index est supérieur à la taille de la liste, on affiche le Spinner
```
itemBuilder: (context, index) {
    if (index < _items.length) {
        return _listElement(context, _items[index]);
    } else {
        return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: CircularProgressIndicator()),
        );
    }
},
```

## 7 - Bonus - Infinite Scroll : Episodes

En vous basant sur ce que nous avons vu pour l'exercice 6, implémentez un infinite scroll pour la liste des épisodes. Rien de spécial à signaler, l'implémentation est à peu près identique.