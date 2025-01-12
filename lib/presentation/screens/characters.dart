import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/character.dart';
import '../widgets/search_field.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  List<Character> searchedCharacters = [];
  final _searchFieldController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Widget onlineCase() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (ctx, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;

          final charactersToDisplay = _searchFieldController.text.isNotEmpty
              ? searchedCharacters
              : allCharacters;

          if (charactersToDisplay.isEmpty) {
            return Center(
              child: Text(
                'No Character with Name ${_searchFieldController.text}',
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontSize: 22,
                ),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: charactersToDisplay.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) => CharacterItem(
                character: charactersToDisplay[index],
              ),
            ),
          );
        } else {
          return progressIndicator();
        }
      },
    );
  }

  Widget progressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.brownColor,
      ),
    );
  }

  AppBar customAppBar() {
    if (isSearching == true) {
      return AppBar(
        backgroundColor: AppColors.mainColor,
        leading: isSearching
            ? BackButton(
                style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(AppColors.brownColor),
                ),
                onPressed: () {
                  clearAppBar();
                },
              )
            : Container(),
        title: SearchField(
          text: 'Find a Character',
          textEditingController: _searchFieldController,
          validateSearch: (String searchedCharacter) {
            searchCharacters(searchedCharacter);
          },
        ),
        actions: [
          IconButton(
            onPressed: _searchFieldController.text.isEmpty
                ? clearAppBar
                : clearSearched,
            icon: Icon(
              Icons.close,
              color: AppColors.brownColor,
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Rick and Morty',
          style: TextStyle(
            color: AppColors.brownColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: activateSearchMode,
            icon: Icon(
              Icons.search,
              color: AppColors.brownColor,
            ),
          ),
        ],
      );
    }
  }

  void activateSearchMode() {
    setState(() {
      isSearching = true;
    });

    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: stopSearchMode),
    );
  }

  void stopSearchMode() {
    setState(() {
      _searchFieldController.clear();
      isSearching = false;
    });
  }

  void clearAppBar() {
    stopSearchMode();
    Navigator.pop(context);
  }

  void searchCharacters(String inputValue) {
    setState(() {
      searchedCharacters = allCharacters
          .where(
            (character) => character.name
                .toLowerCase()
                .startsWith(inputValue.toLowerCase()),
          )
          .toList();
    });
  }

  void clearSearched() {
    setState(() {
      _searchFieldController.clear();
    });
  }

  Widget offlineCase() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            'assets/images/offline_warning.png',
            height: 380,
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              'Network error, check your connection network',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.brownColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: customAppBar(),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            List<ConnectivityResult> connectivity, Widget child) {
          bool connected = !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return onlineCase();
          } else {
            return offlineCase();
          }
        },
        child: progressIndicator(),
      ),
    );
  }
}
