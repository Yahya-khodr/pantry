import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Ink.image(
                image: const NetworkImage(
                  'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                ),
                fit: BoxFit.cover,
                height: 100,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: const Text(
              'Product Name',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                buttonHeight: 15,
                buttonMinWidth: 30,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.green),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  ),
                  const Text(
                    "20",
                    style: TextStyle(),
                    maxLines: 2,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.green),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
