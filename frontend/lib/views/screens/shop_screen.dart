import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: "Shopping List"),
        ),
        body: Center(
          child: Text('Shop screen'),
        ));
  }
}
