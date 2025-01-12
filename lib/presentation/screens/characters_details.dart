import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../widgets/character_detail_item.dart';

import '../../data/models/character.dart';

class CharactersDetailsScreen extends StatelessWidget {
  const CharactersDetailsScreen(this.character, {super.key});

  final Character character;

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.mainColor,
      expandedHeight: 600, // cool looking button in nav
      pinned: true,
      leading: BackButton(
        color: AppColors.brownColor,
      ),
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
        title: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.darkColor,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: AppColors.secondaryColor,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            totalRepeatCount: 3,
            animatedTexts: [
              TypewriterAnimatedText(
                character.name,
                speed: Duration(milliseconds: 130),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          CharacterDetailItem(
            dataValue:
                character.origin.entries.first.value.toString().toLowerCase() ==
                        'unknown'
                    ? 'Somewhere In The World'
                    : character.origin.entries.first.value,
            isCenteredText: true,
          ),
          character.status.toLowerCase() == 'unknown'
              ? SizedBox()
              : CharacterDetailItem(
                  dataKey: 'Status : ',
                  dataValue: character.status,
                ),
          CharacterDetailItem(
            dataKey: 'Gender : ',
            dataValue: character.gender,
          ),
          CharacterDetailItem(
            dataKey: 'Location : ',
            dataValue: character.location.entries.first.value,
          ),
          CharacterDetailItem(
            dataKey: 'Species : ',
            dataValue: character.speciesIfHumanOrDifferentType,
          ),
          character.type.isEmpty
              ? SizedBox()
              : CharacterDetailItem(
                  dataKey: 'Type : ',
                  dataValue: character.type,
                ),
          SizedBox(height: 450),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          buildSliverList(),
        ],
      ),
    );
  }
}
