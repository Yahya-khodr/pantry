import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/card_item_widget.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: "Items list",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 15.0),
              SizedBox(
                  width: size.width - 20.0,
                  height: size.height - 50.0,
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.7,
                    children: const <Widget>[
                      CardItem(),
                      CardItem(),
                      CardItem(),
                      CardItem(),
                      CardItem(),
                      CardItem(),
                      CardItem(),
                    ],
                  )),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
