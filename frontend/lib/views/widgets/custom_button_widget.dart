import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomElevetadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  const CustomElevetadButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 5.0),
          Text(text ?? "Edit Profile"),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Palette.appBarColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
    );
  }
}
