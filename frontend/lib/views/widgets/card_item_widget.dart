import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CardItem extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String qty;
  final String date;
  final String purchased;
  const CardItem({
    Key? key,
    required this.image,
    required this.name,
    required this.qty,
    required this.date,
    required this.purchased,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Expires in: $date d',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Purchased :' + purchased,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Qty:' + qty,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 10,
                  buttonMinWidth: 20,
                  children: <Widget>[
                    Expanded(
                      child: CircleButtonIcon(
                        onPressed: () {},
                        icon: Icons.remove,
                      ),
                    ),
                    Expanded(
                      child: CircleButtonIcon(
                        onPressed: () {},
                        icon: Icons.add,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CircleButtonIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      shape: const CircleBorder(
        side: BorderSide(color: Palette.appBarColor),
      ),
      child: Icon(
        icon,
        color: Palette.appBarColor,
      ),
    );
  }
}
