import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double radius;
  final ImageProvider imageProvider;

  const CircleImage(
    this.imageProvider, {
    Key? key,
    this.radius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        )
      ],
    );
  }
}
