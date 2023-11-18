import 'package:contact_app/src/core/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper{
  Future<String?> readData(StorageKeys key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key.name);
    return data;
  }

  writeData(StorageKeys key, String value) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key.name, value); //name is converting into string,returning name
  }

  // updateData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  // }

  clearAllData(StorageKeys key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key.name);
  }
}