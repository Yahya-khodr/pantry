import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String suffixText ;
   const CustomTextInput(
    {
    Key? key,
    required this.controller,
    required this.keyboardType,
     required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 3,
      child: TextField(
        
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          suffixText:suffixText ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.green, width: 3),
          ),
        ),
      ),
    );
  }
}
