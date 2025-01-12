import 'package:flutter/material.dart';
import '../../data/models/character.dart';
import '../../data/repository/characters_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  late List<Character> characters;

  Future<void> getCharacters() async {
    final fetchedCharacters = await charactersRepository.fetchCharacters();
    emit(CharactersLoaded(characters: fetchedCharacters));
  }
}
