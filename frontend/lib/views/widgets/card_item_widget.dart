import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'Product Name Product Name Product Name Product Name Product Name Product Name Product Name  ',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
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
                    const Text("20"),
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
          ),
        ],
      ),
    );
  }
}
