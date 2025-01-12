import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CharacterDetailItem extends StatelessWidget {
  const CharacterDetailItem({
    super.key,
    this.dataKey,
    required this.dataValue,
    this.isCenteredText = false,
  });

  final String? dataKey;
  final String dataValue;
  final bool? isCenteredText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isCenteredText!
              ? Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor,
                      ),
                      child: AnimatedTextKit(
                        // isRepeatingAnimation: true,
                        // repeatForever: true,
                        totalRepeatCount: 2,
                        pause: Duration(milliseconds: 800),
                        animatedTexts: [
                          WavyAnimatedText(
                            dataValue,
                            speed: Duration(milliseconds: 140),
                          ),
                        ],
                      ),
                    ),
                  ),
              )
              : RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: dataKey,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: dataValue,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainGradient2,
                        ),
                      ),
                    ],
                  ),
                ),
          isCenteredText!
              ? SizedBox()
              : Divider(
                  color: AppColors.mainGradient1,
                  thickness: 2,
                ),
        ],
      ),
    );
  }
}
