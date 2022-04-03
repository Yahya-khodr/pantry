import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class ProfileWidget extends StatelessWidget {
  // final String imagePath;
  final Widget image;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.image,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Palette.appBarColor;

    return Center(
      child: InkWell(
        onTap: onClicked,
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Palette.appBarColor,
            blurRadius: 2.0,
            spreadRadius: 5.0,
          )
        ],
      ),
      child: ClipOval(
        child: Material(color: Colors.transparent, child: image),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
