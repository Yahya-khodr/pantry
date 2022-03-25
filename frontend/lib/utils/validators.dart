class Validator {
  static bool isValidName(String name) {
    if (name.isEmpty || name.length < 3) {
      return false;
    }
    return true;
  }

  static bool isValidEmail(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty || !regex.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool isValidPassword(String password) {
    if (password.isEmpty || password.length < 5) {
      return false;
    }
    return true;
  }

  static bool isValidConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return false;
    }
    return true;
  }
}
