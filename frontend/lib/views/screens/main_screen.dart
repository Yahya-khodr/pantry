import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/views/screens/home_screen.dart';
import 'package:frontend/views/screens/items_screen.dart';
import 'package:frontend/views/screens/scan_screen.dart';
import 'package:frontend/views/screens/settings_screen.dart';
import 'package:frontend/views/screens/shop_screen.dart';
import 'package:frontend/views/widgets/tabbar_material_widget.dart';

import '../../resources/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final screens = const <Widget>[
    HomeScreen(),
    ShopScreen(),
    ItemsScreen(),
    SettingsScreen(),
  ];
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
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: TabBarMaterialWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Palette.appBarColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
