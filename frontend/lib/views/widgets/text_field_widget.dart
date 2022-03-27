import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? suffixText;
  final String? prefixText;
  final double? size;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.size,
    this.suffixText,
    this.prefixText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    required this.controller,
    this.icon,
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: widget.size,
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
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            cursorColor: Palette.appBarColor,
            decoration: InputDecoration(
              prefixText: widget.prefixText,
              suffixText: widget.suffixText,
              labelText: widget.labelText,
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
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.hintText == "Password" ||
                      widget.hintText == "Confirm Password"
                  ? IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : widget.suffixIcon,
            ),
            obscureText: widget.hintText == "Password" ||
                    widget.hintText == "Confirm Password"
                ? _isHidden
                : false,
          ),
        ),
      ),
    );
  }
}
