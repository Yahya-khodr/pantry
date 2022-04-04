import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/utils/validators.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    void _loginUser() {
      if (Validator.isValidEmail(_email) &&
          Validator.isValidPassword(_password)) {
        setState(() {
          _isloading = true;
        });
        final Future<HTTPResponse<String>> response =
            UserService().loginUser(_email, _password);

        response.then((value) {
          if (value.isSuccessful) {
            Utilities.fetchAndSaveUserInfo(res: value.data);
            setState(() {
              _isloading = false;
            });
            setState(() {
              _isloading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          } else {
            setState(() {
              _isloading = false;
              Utilities.showSnackbar(context, value.message, false);
            });
          }
        });
      } else if (!Validator.isValidEmail(_email)) {
        Utilities.showSnackbar(context, 'Invalid  Email', false);
      } else if (!Validator.isValidPassword(_password)) {
        Utilities.showSnackbar(context, 'Password is empty', false);
      }
    }

    Size size = MediaQuery.of(context).size;
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomTextField(
                    hintText: "Email",
                    controller: _emailController,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    controller: _passwordController,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedButton(
                      width: size.width / 2,
                      text: "Login",
                      onPressed: () {
                        setState(() {
                          _email = _emailController.text;
                          _password = _passwordController.text;
                        });
                        log("email " + _email);
                        log("password " + _password);
                        _loginUser();
                      }),
                ],
              ),
            ),
          );
  }
}
