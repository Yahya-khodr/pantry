import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: Palette.appBarColor)),
        child: TextField(
          controller: widget.controller,
          cursorColor: Palette.appBarColor,
          decoration: InputDecoration(
            focusColor: Palette.appBarColor,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                    const BorderSide(color: Palette.appBarColor, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                    const BorderSide(color: Palette.appBarColor, width: 2.0)),
            prefixIcon: widget.hintText == "Email" || widget.hintText == "Name"
                ? const Icon(Icons.email)
                : const Icon(Icons.lock),
            suffixIcon: widget.hintText == "Password"
                ? IconButton(
                    onPressed: _toggleVisibility,
                    icon: _isHidden
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : null,
          ),
          obscureText: widget.hintText == "Password" ? _isHidden : false,
        ),
      ),
    );
  }
}
