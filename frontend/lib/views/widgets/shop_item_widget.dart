import 'package:flutter/material.dart';
import 'package:frontend/models/shop_item_model.dart';
import 'package:frontend/resources/palette.dart';

class ShopItemCard extends StatelessWidget {
  final ShopItem shopItem;
  final VoidCallback onPressed;
  const ShopItemCard({Key? key, required this.shopItem, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  shopItem.itemName!.toUpperCase(),
                  style: TextStyle(color: Palette.appBarColor),
                ),
              ),
              Row(
                children: [
                  Text(shopItem.quantity.toString()),
                  IconButton(
                      onPressed: onPressed,
                      icon:
                          const Icon(Icons.delete, color: Palette.appBarColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
