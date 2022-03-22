import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/card_item_widget.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 15.0),
          Container(
              padding: const EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: const <Widget>[
                  CardItem(),
                  CardItem(),
                  CardItem(),
                  CardItem(),
                ],
              )),
          const SizedBox(height: 15.0)
        ],
      ),
    );
  }
}
