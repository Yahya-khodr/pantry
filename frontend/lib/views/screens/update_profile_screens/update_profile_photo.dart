import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/image_cropper.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePicture extends StatefulWidget {
  final String imageUrl;
  const UpdateProfilePicture(this.imageUrl, {Key? key}) : super(key: key);

  @override
  _UpdateProfilePictureState createState() => _UpdateProfilePictureState();
}

class _UpdateProfilePictureState extends State<UpdateProfilePicture> {
  File? _selectedFile;
  String? _res;
  bool _inProcess = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  _selectImage(ImageSource source) async {
    setState(() {
      _inProcess = true;
    });
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      File? cropped = await ImagesCropper.cropImage(image);

      setState(() {
        _selectedFile = cropped!;
        _inProcess = false;
      });
    } else {
      setState(() {
        _inProcess = false;
      });
      return;
    }
  }

  void getToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _res = prefs.getString("token");
    });
    print(_res);
  }

  Future<void> _uploadImage() async {
    if (_selectedFile != null) {
      final Future<bool> response =
          UserService.updateProfilePicture(_selectedFile!, _res!);
      response.then(
        (value) {
          if (value) {
            Utilities.fetchAndSaveUserInfo(res: _res!);
            Utilities.showSnackbar(
                context, "Profile picture updated successfully", true);
            Navigator.pop(context);
          } else {
            Utilities.showSnackbar(
                context, "Error updating profile picture", false);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        title: const Text('Update Profile Picture'),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: _selectedFile != null
                ? Image.file(_selectedFile!)
                : widget.imageUrl.isEmpty
                    ? Image.asset(
                        "assets/images/user-placeholder.jpg",
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      )
                    : Image.network(
                        Constants.imageApi + widget.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
          ),
          // select new image button
          Container(
            margin: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () {
                _selectImage(ImageSource.gallery);
              },
              child: const Text(
                'Select New Image',
                style: TextStyle(color: Palette.appBarColor),
              ),
            ),
          ),
          // update profile picture button
          Container(
              margin: const EdgeInsets.all(20.0),
              child: RoundedButton(
                  text: "Update Profile", onPressed: () => _uploadImage())),
        ],
      ),
    );
  }
}
