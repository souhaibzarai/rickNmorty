import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SearchField extends StatelessWidget {
  final String text;
  final TextEditingController? _textEditingController;

  final void Function(String searchedCharacter) validateSearch;

  const SearchField({
    super.key,
    required this.text,
    required TextEditingController? textEditingController,
    required this.validateSearch,
  }) : _textEditingController = textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: AppColors.brownColor, fontSize: 18),
        border: InputBorder.none,
      ),
      autocorrect: false,
      cursorColor: AppColors.brownColor,
      controller: _textEditingController,
      style: TextStyle(color: AppColors.brownColor, fontSize: 18),
      onChanged: (value) {
        validateSearch(value);
      },
    );
  }
}
