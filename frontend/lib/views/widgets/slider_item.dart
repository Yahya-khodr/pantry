import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key? key,
    this.color = Colors.green,
    required this.image,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              image,
            ),
            colorFilter: const ColorFilter.mode(
              Palette.appBarColor,
              BlendMode.dst,
            ),
            child: InkWell(
              onTap: () {},
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.textFieldColor,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
