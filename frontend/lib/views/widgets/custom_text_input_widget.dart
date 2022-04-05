import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String suffixText;
  final String labelText;
  const CustomTextInput({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.suffixText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: size.width / 3,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: Palette.appBarColor),
          ),
          child: TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              suffixText: suffixText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(color: Palette.appBarColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.green, width: 3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
