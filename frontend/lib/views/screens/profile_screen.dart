import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/screens/update_profile_screens/update.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            ProfileWidget(
              imagePath: 'assets/images/user-placeholder.jpg',
              onClicked: () {},
              isEdit: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("User Name"),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("User Name"),
                ),
                SizedBox(
                  width: size.width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const UpdateProfileScreen();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 5.0),
                        Text("Edit Profile"),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Palette.buttonColorRed,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
