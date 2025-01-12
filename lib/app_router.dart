import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';
import 'presentation/screens/characters.dart';
import 'presentation/screens/characters_details.dart';

class AppRouter {
  late CharactersRepository _charactersRepository;
  late CharactersCubit _charactersCubit;

  AppRouter() {
    _charactersRepository = CharactersRepository(CharactersWebServices());
    _charactersCubit = CharactersCubit(_charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => _charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case charactersDetails:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharactersDetailsScreen(
            character,
          ),
        );
      // default:
    }
    return null;
  }
}
