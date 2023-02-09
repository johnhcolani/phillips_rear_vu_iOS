
import 'package:shared_preferences/shared_preferences.dart';
class DataManager{
  static const String key="myKey";

  Future<void> saveData(String value) async {
    final prefs= await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  Future<String>getData()async{
    final prefs= await SharedPreferences.getInstance();
    return prefs.getString(key)??'';
  }
  // Future<void> clearData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key);
  // }
}