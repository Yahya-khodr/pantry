import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      //backgroundColor: Colors.purple,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.appBarColor, Palette.appBarColorLinear],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
