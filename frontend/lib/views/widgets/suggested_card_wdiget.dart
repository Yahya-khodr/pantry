import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class SuggestedCard extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final VoidCallback onTap;
  const SuggestedCard({
    Key? key,
    required this.image,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: image,
                  fit: BoxFit.contain,
                  height: 80,
                ),
              ],
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      name.toUpperCase(),
                      style: const TextStyle(color: Palette.appBarColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
