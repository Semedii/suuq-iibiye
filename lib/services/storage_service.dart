import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  late final SharedPreferences _pref;

  Future<StorageService> init()async{
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

    Future<bool> clear() async {
    return await _pref.clear();
  }
  
  Future<String?> getString(String key) async {
    return _pref.getString(key);
  }
}