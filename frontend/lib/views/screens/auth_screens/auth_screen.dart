import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/screens/auth_screens/login_screen.dart';
import 'package:frontend/views/screens/auth_screens/register_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        toolbarHeight: MediaQuery.of(context).size.height / 5,
        centerTitle: true,
        elevation: 0,
        title: Text(
          Constants.appName,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Palette.appNameColor),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          indicatorColor: Palette.appNameColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 5,
          controller: _tabController,
          labelStyle: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: const <Widget>[
            Tab(
              text: "Login",
            ),
            Tab(
              text: "Sign Up",
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: const <Widget>[
        LoginScreen(),
        RegisterScreen(),
      ]),
    );
  }
}
