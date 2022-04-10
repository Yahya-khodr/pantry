import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/utils/utilities.dart';

class HomeCard extends StatelessWidget {
  final Food food;
  final VoidCallback ontap;
  const HomeCard({
    Key? key,
    required this.food,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: ListTile(
        onTap: ontap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            imageUrl: Constants.imageApi + food.imageUrl!,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(food.name!),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(
                    text: 'Expires in: ',
                    style:
                        const TextStyle(fontSize: 12, color: Palette.textColor),
                    children: <TextSpan>[
                  TextSpan(
                    text: Utilities.daysBetween(DateTime.now(),
                                DateTime.parse(food.expiryDate!))
                            .toString() +
                        'd',
                    style: const TextStyle(color: Palette.appBarColor),
                  )
                ])),
            RichText(
              text: TextSpan(
                text: 'Quantity: ',
                style: const TextStyle(fontSize: 12, color: Palette.textColor),
                children: <TextSpan>[
                  TextSpan(
                    text: food.quantity!,
                    style: const TextStyle(color: Palette.appBarColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
