import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/views/screens/update_profile_screens/update_profile_info.dart';
import 'package:frontend/views/screens/update_profile_screens/update_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  User? _user;
  // ignore: unused_field
  Profile? _profile;
  String? _token;
  bool isLoading = false;

  void getToken() async {
    setState(() {
      isLoading = true;
    });
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _token = prefs.getString("token");
    });
    log(_token as String);

    if (_token != null) {
      getUserDetails(_token!);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void getUserDetails(String token) async {
    UserService.getUserDetails(token).then((value) {
      setState(() {
        _user = value.user;
        _profile = value.profile;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Update Profile"),
        bottom: TabBar(
          indicatorColor: Palette.appNameColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5,
          controller: _tabController,
          labelStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: const <Widget>[
            Tab(
              text: "User Info",
            ),
            Tab(
              text: "Profile Info",
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _tabController, children: <Widget>[
              UpdateUserInfo(
                token: _token!,
                user: _user!,
              ),
              const UpdateProfileInfo(),
            ]),
    );
  }
}
