import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key? key,
    this.color = Colors.green,
    this.text = 'Fruits & Vegetables  ',
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffeeeeee), width: 2.0),
        color: Colors.white38,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: const [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      height: 200,
      width: 200,
      child: Stack(
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24.0, color: color),
          ),
        ],
      ),
    );
  }
}
