import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

import '../../data/models/character.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final bool isNotAlive = character.status.toLowerCase() == 'dead';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          charactersDetails,
          arguments: character,
        );
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            color: AppColors.darkColor.withAlpha(180),
            child: Text(
              isNotAlive ? '💀 ${character.name}' : character.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
                height: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          child: Hero(
            tag: character.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/loading.gif'),
              image: character.image.isNotEmpty
                  ? NetworkImage(character.image)
                  : AssetImage('assets/images/default_if_null.jpg'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
