import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';
import 'package:frontend/views/screens/auth_screens/auth_screen.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final TabBar? bottom;
  final double? height;
  final Widget? iconButton;
  final Widget? voiceButton;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.height,
    this.iconButton,
    this.voiceButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return AppBar(
      toolbarHeight: height,
      title: Text(title),
      actions: [
        iconButton!,
        voiceButton ?? Container(),
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: const Text("Log out"),
                onTap: () async {
                  await userViewModel.signOut();
                  Utilities.clearSharedPreferences(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Authentication()));
                },
              ),
            ];
          },
        ),
      ],
      //backgroundColor: Colors.purple,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.appBarColor, Palette.appBarColorLinear],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
      ),
      bottom: bottom,
    );
  }
}
