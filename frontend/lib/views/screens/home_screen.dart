import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/widgets/circle_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: true,
        title: Text(Constants.appName),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
