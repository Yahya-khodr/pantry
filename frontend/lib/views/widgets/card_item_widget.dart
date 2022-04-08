import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class CardItem extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String qty;
  final String date;
  final int total;
  final String purchased;
  final VoidCallback onTap;
  final VoidCallback increase;
  final VoidCallback decrease;
  const CardItem({
    Key? key,
    required this.image,
    required this.name,
    required this.qty,
    required this.date,
    required this.purchased,
    required this.onTap,
    required this.increase,
    required this.decrease,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Expires in:',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: date + 'd left',
                            style: const TextStyle(color: Palette.appBarColor),
                          )
                        ])),
                    Text(
                      'Purchased :' + purchased,
                      style: const TextStyle(fontSize: 12),
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Qty:',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: qty,
                            style: const TextStyle(color: Palette.appBarColor),
                          )
                        ])),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonHeight: 10,
                    buttonMinWidth: 20,
                    children: <Widget>[
                      CircleButtonIcon(
                        onPressed: decrease,
                        icon: Icons.remove,
                      ),
                      Text(total.toString()),
                      CircleButtonIcon(
                        onPressed: increase,
                        icon: Icons.add,
                      ),
                    ],
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
      onPressed: onPressed,
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
