import 'package:shared_preferences/shared_preferences.dart';

class CoronaLocalDataSource {
  final String _countryNameKey = "COUNTRY_NAME_KEY";
  final SharedPreferences sharedPreferences;

  CoronaLocalDataSource({this.sharedPreferences});

  saveCountryName(String countryName) {
    this.sharedPreferences.setString(_countryNameKey, countryName);
  }

  String getSavedCountryName() {
    if (this.sharedPreferences.containsKey(_countryNameKey)) {
      return this.sharedPreferences.getString(_countryNameKey);
    } else return null;
  }
}