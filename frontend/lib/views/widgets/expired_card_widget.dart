import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';

class ExpiredCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;
  const ExpiredCard({Key? key, required this.food, required this.onTap})
      : super(key: key);

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
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Ink.image(
                    image: NetworkImage(Constants.imageApi + food.imageUrl!),
                    fit: BoxFit.cover,
                    height: 75,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      food.name!.toUpperCase(),
                      style:
                          const TextStyle(color: Palette.appBarColorLinear),
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
