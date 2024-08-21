import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefModel {
  SharedPrefModel._constactor();
  static final SharedPrefModel _instance = SharedPrefModel._constactor();
  static SharedPrefModel get instance => _instance;

  late SharedPreferences sharePrefObj;

  Future<void> initSharedPref() async {
    sharePrefObj = await SharedPreferences.getInstance();
  }

  insertData(String key, int value) async {
    await sharePrefObj.setInt(key, value);
  }

  getData(String key) {
    final userId = sharePrefObj.getInt(key);
    return userId;
  }

  removeData(String key) {
    sharePrefObj.remove(key);
  }
}
