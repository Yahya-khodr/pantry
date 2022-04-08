import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
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
        leading: CircleAvatar(
          backgroundImage: NetworkImage(Constants.imageApi + food.imageUrl!),
        ),
        title: Text(food.name!),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Expires in :" +
                  Utilities.daysBetween(
                          DateTime.now(), DateTime.parse(food.expiryDate!))
                      .toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              "Quantity : " + food.quantity!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
