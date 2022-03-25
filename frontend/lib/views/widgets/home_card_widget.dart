import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String qty;
  const HomeCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.date,
      required this.qty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
        ),
        title: Text(title),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Expires in :" + date,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              "Quantity : " + qty,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
