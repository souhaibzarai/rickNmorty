import '../models/character.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> fetchCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) {
      return Character.fromJson(character);
    }).toList();
  }
}
