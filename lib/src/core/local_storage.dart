import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _tokenKey = 'token';

  static late SharedPreferences _sharedPreferences;


  static init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

 static Future<bool> storeToken(String token) async {
    return _sharedPreferences.setString(_tokenKey, token);
  }

 static String? get token => _sharedPreferences.getString(_tokenKey);

 static Future<bool> clearToken() async => _sharedPreferences.remove(_tokenKey);
}
