import 'package:flutter/material.dart';
import 'package:frontend/models/http_response.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/utils/validators.dart';
import 'package:frontend/views/screens/auth_screens/login_screen.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  late String _name, _email, _password, _confirmPassword;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    void _registerUser() {
      if (Validator.isValidName(_name) &&
          Validator.isValidEmail(_email) &&
          Validator.isValidPassword(_password) &&
          Validator.isValidConfirmPassword(_password, _confirmPassword)) {
        setState(() {
          _isLoading = true;
        });
        final Future<HTTPResponse<String>> response =
            UserService().registerUser(_name, _email, _password);
        response.then((value) {
          if (value.isSuccessful) {
            Utilities.fetchAndSaveUserInfo(res: value.data);
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else {
            setState(() {
              _isLoading = false;
            });
            Utilities.showSnackbar(context, value.message, false);
          }
        });
      } else if (!Validator.isValidName(_name)) {
        Utilities.showAlertDialog(context, "Error", "Name is required.", false);
      } else if (!Validator.isValidEmail(_email)) {
        Utilities.showAlertDialog(
            context, "Error", "Email address is not valid", false);
      } else if (!Validator.isValidPassword(_password)) {
        Utilities.showAlertDialog(context, "Error",
            "Password must be at least 8 characters long.", false);
      } else if (!Validator.isValidConfirmPassword(
          _password, _confirmPassword)) {
        Utilities.showAlertDialog(
            context, "Error", "Passwords must be same.", false);
      }
    }

    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomTextField(
                    hintText: "Name",
                    controller: _nameController,
                    prefixIcon: const Icon(Icons.person),
                  ),
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
                  CustomTextField(
                    hintText: "Confirm Password",
                    controller: _confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedButton(
                      width: size.width / 2,
                      text: "Register",
                      onPressed: () {
                        setState(() {
                          _name = _nameController.text;
                          _email = _emailController.text;
                          _password = _passwordController.text;
                          _confirmPassword = _confirmPasswordController.text;
                        });
                        _registerUser();
                      })
                ],
              ),
            ),
          );
  }
}
