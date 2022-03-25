import 'package:flutter/material.dart';

class CardDetail extends StatelessWidget {
  final String title;

  const CardDetail({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
