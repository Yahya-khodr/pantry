import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class UpdateUserInfo extends StatefulWidget {
  final User user;
  final String token;
  const UpdateUserInfo({
    Key? key,
    required this.user,
    required this.token,
  }) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    _nameController.value = _nameController.value.copyWith(
      text: widget.user.name,
      selection: widget.user.name != null
          ? TextSelection.collapsed(offset: widget.user.name!.length)
          : null,
    );

    _emailController.value = _emailController.value.copyWith(
      text: widget.user.email,
      selection: widget.user.email != null
          ? TextSelection.collapsed(offset: widget.user.email!.length)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 20.0),
          CustomTextField(
            labelText: "Name",
            controller: _nameController,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          const SizedBox(height: 20.0),
          CustomTextField(
            controller: _emailController,
            prefixIcon: const Icon(Icons.email_outlined),
            labelText: "Email Address",
          ),
          const SizedBox(height: 20.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: size.width * 0.3,
            child: RoundedButton(
              text: "Save",
              onPressed: () {},
              width: size.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
