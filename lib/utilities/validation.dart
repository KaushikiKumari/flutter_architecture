// ignore_for_file: unnecessary_null_comparison, prefer_is_empty

class Validation {
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isValid(String data) {
    if (data == null || data.length == 0 || data == "") {
      return false;
    }
    return true;
  }

  static bool isValidPhone(String data) {
    if (data == null || data.length == 0 || data == "" || data.length < 10) {
      return false;
    }
    return true;
  }
}
