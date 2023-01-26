import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void setStringData(String data, route) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(route, data);
  }
}
