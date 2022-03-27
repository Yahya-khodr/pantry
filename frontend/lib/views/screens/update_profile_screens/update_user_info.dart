import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class UpdateUserInfo extends StatefulWidget {
  const UpdateUserInfo({Key? key}) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          CustomTextField(
              labelText: "Name",
              controller: _nameController,
              icon: Icons.person_outline),
          const SizedBox(height: 20.0),
          CustomTextField(
           
            controller: _emailController,
            icon: Icons.email_outlined,
            labelText: "Email Address",
          ),
          const SizedBox(height: 20.0),
          RoundedButton(
            text: "Save",
            onPressed: () {},
            width: size.width * 0.3,
          ),
        ],
      ),
    );
  }
}
