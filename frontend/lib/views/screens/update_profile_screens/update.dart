import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/screens/update_profile_screens/update_profile_info.dart';
import 'package:frontend/views/screens/update_profile_screens/update_user_info.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
          onPressed: () {},
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
      body: TabBarView(controller: _tabController, children: const <Widget>[
        UpdateUserInfo(),
        UpdateProfileInfo(),
      ]),
    );
  }
}
