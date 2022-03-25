import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            ProfileWidget(
              imagePath: 'assets/images/user-placeholder.jpg',
              onClicked: () {},
              isEdit: true,
            )
          ],
        ),
      ),
    );
  }
}
