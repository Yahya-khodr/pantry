import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/views/screens/home_screen.dart';
import 'package:frontend/views/screens/items_screen.dart';
import 'package:frontend/views/screens/profile_screen.dart';
import 'package:frontend/views/screens/shop_screen.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/tabbar_material_widget.dart';

import '../../resources/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  String barcode = 'Unknown';
  final screens = const <Widget>[
    HomeScreen(),
    ShopScreen(),
    ItemsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: TabBarMaterialWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          scanBarcode(barcode);
          
        }),
        backgroundColor: Palette.appBarColor,
        child: const FaIcon(FontAwesomeIcons.barcode),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  Future<void> scanBarcode(String code) async {
    try {
      code = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (!mounted) return;
      setState(() {
        barcode = code;
        log("barcode:" + barcode);
      });
    } on PlatformException {
      barcode = 'Failed to get platform version';
    }
  }
}
