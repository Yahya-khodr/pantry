import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String name;
  final double? left;

  const CustomTile({
    Key? key,
    required this.title,
    this.left,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: ListTile(
          leading: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(
              left: left ?? 20,
            ),
            child: Text(
              name.toUpperCase(),
              style: const TextStyle(color: Palette.appBarColor),
            ),
          ),
        ),
      ),
    );
  }
}
