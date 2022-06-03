import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) => sharedPreferences.get(key);

  static Future<bool> saveData(String key, dynamic value) async{
    if(value is int)return await sharedPreferences.setInt(key, value);
    if(value is bool)return await sharedPreferences.setBool(key, value);
    if(value is String)return await sharedPreferences.setString(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }
}