import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.03,
            ),
            const CustomTextField(hintText: "Email"),
            SizedBox(
              height: size.height * 0.03,
            ),
            const CustomTextField(hintText: "Password"),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(text: "Register", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
