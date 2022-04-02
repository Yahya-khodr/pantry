import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/views/screens/auth_screens/auth_screen.dart';
import 'package:frontend/views/screens/update_profile_screens/update.dart';
import 'package:frontend/views/screens/update_profile_screens/update_profile_photo.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _res, _name, _imageUrl, _email;
  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void _getProfileInformation() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _name = prefs.getString("name");
      _imageUrl = prefs.getString("imageUrl");
      _email = prefs.getString("email");

      isLoading = false;
      isLoggedIn = true;
      print("name: $_name");
      print("imageUrl: $_imageUrl");
      print("email: $_email");
    });
  }

  void getToken() async {
    setState(() {
      isLoading = true;
    });
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _res = prefs.getString("token");
    });
    print(_res);

    if (_res != null) {
      _getProfileInformation();
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                Utilities.fetchAndSaveUserInfo(res: _res!);
                await Future.delayed(const Duration(seconds: 1));
                _getProfileInformation();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ProfileWidget(
                          image: _imageUrl!.isEmpty
                              ? Image.asset(
                                  "assets/images/user-placeholder.jpg",
                                  fit: BoxFit.cover,
                                  width: 120.0,
                                  height: 120.0,
                                )
                              : Image.network(
                                  Constants.imageApi + _imageUrl!,
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                          //     ),
                          // imagePath: 'assets/images/user-placeholder.jpg',
                          onClicked: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProfilePicture(_imageUrl!))),
                          isEdit: true,
                        ),
                        // Stack(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 10.0, right: 10.0),
                        //       child: _imageUrl!.isEmpty
                        //           ? Image.asset(
                        //               "assets/images/user-placeholder.jpg",
                        //               fit: BoxFit.cover,
                        //               width: 100.0,
                        //               height: 100.0,
                        //             )
                        //           : Image.network(
                        //               Constants.imageApi + _imageUrl!,
                        //               width: 100,
                        //               height: 100,
                        //               fit: BoxFit.cover,
                        //             ),
                        //     ),
                        //     Positioned(
                        //       right: 10,
                        //       bottom: -3,
                        //       child: GestureDetector(
                        //         child: Container(
                        //           padding: const EdgeInsets.all(5),
                        //           decoration: const BoxDecoration(
                        //             color: Colors.grey,
                        //           ),
                        //           child: const Icon(
                        //             Icons.camera_alt,
                        //             color: Colors.black45,
                        //           ),
                        //         ),
                        //         onTap: () {
                        //           Navigator.of(context).push(
                        //             MaterialPageRoute(
                        //               builder: (BuildContext context) {
                        //                 return UpdateProfilePicture(_imageUrl!);
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           Expanded(
                        //             child: Text(
                        //               _name!,
                        //               style: const TextStyle(
                        //                 fontSize: 20.0,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(height: 5.0),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           Text(
                        //             _email!,
                        //             style: const TextStyle(
                        //               fontSize: 14.0,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(height: 20.0),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           CustomElevetadButton(
                        //             onPressed: () => Navigator.of(context).push(
                        //               MaterialPageRoute(
                        //                 builder: (BuildContext context) {
                        //                   return const UpdateProfileScreen();
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        //   flex: 3,
                        // ),
                      ],
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Account Information".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Full Name",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(_name!),
                    ),
                    ListTile(
                      title: const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(_email!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomElevetadButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const UpdateProfileScreen();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
