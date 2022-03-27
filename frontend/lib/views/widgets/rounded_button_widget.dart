import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  final double? width;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.color = Palette.buttonColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: textColor),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}
