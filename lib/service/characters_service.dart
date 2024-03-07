import 'package:cours_flutter_rick_et_morty/model/character.dart';

class CharactersService {
  var rick = Character(
    name: "Rick Sanchez",
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    species: "Human",
    origin: "Earth (C-137)",
    status: "Alive",
  );

  var morty = Character(
    name: "Morty Smith",
    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
    species: "Human",
    origin: "unknown",
    status: "Alive",
  );

  var summer = Character(
    name: "Summer Smith",
    image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
    species: "Human",
    origin: "Earth (Replacement Dimension)",
    status: "Alive",
  );

  var beth = Character(
    name: "Beth Smith",
    image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
    species: "Human",
    origin: "Earth (Replacement Dimension)",
    status: "Alive",
  );

  var jerry = Character(
    name: "Jerry Smith",
    image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
    species: "Human",
    origin: "Earth (Replacement Dimension)",
    status: "Alive",
  );

  var princess = Character(
    name: "Abadango Cluster Princess",
    image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
    species: "Alien",
    origin: "Abadango",
    status: "Alive",
  );

  final List<Character> profiles = [];

  CharactersService() {
    profiles.add(rick);
    profiles.add(morty);
    profiles.add(summer);
    profiles.add(beth);
    profiles.add(jerry);
    profiles.add(princess);
  }
}
