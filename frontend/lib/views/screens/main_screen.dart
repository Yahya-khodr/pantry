import 'package:flutter/material.dart';
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
        onPressed: () {},
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
}

// class MyAppbar extends StatelessWidget {
//   const MyAppbar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(Constants.appName),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: const Icon(Icons.notifications_none),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: const Icon(Icons.more_vert),
//           onPressed: () {},
//         ),
//       ],
//       //backgroundColor: Colors.purple,
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Palette.appBarColor, Palette.appBarColorLinear],
//             end: Alignment.topCenter,
//             begin: Alignment.bottomCenter,
//           ),
//         ),
//       ),
//       // bottom: const TabBar(
//       //   isScrollable: true,
//       //   indicatorColor: Colors.white,
//       //   indicatorWeight: 4,

//       //   tabs: [
//       //     Tab(
//       //       child: Text(
//       //         "Home",
//       //         style: TextStyle(fontSize: 20),
//       //       ),
//       //     ),
//       //     Tab(text: 'Home'),
//       //     Tab(text: 'Home'),
//       //     Tab(text: 'Home'),
//       //     Tab(text: 'Home'),
//       //   ],
//       // ),
//     );
//   }
// }

