import 'dart:ui';

class Constants {
  //API
  static const String HEROKU_ENDPOINT = "https://coronavirus-19-api.herokuapp.com/";

  //Colors
  static const Color backgroundColor = Color(0xff272936);
  static const Color foregroundColor = Color(0xff3d3f50);

  //Strings
  static const String TOTAL_CASES_STRING = "Total Cases";
  static const String TOTAL_TESTS_STRING = "Total Tests";
  static const String TODAY_CASES_STRING = "Cases Today";
  static const String ACTIVE_CASES_STRING = "Active";
  static const String RECOVERED_CASES_STRING = "Recovered";
  static const String DEATHS_CASES_STRING = "Deaths";
  static const String TODAY_DEATHS_CASES_STRING = "Deaths Today";
  static const String PER_ONE_MILLION_CASES_STRING = "Cases per one million";
  static const String PER_ONE_DEATHS_CASES_STRING = "Deaths per one million";
  static const String PER_ONE_TESTS_CASES_STRING = "Tests per one million";
  static const String LOADING_STRING = "Loading...";
  static const String DEFAULT_ERROR_STRING = "This operation could not be performed. Tente novamente";
  static const String DEFAULT_COUNTRY = "Brazil";
  static const String WORLD_COUNTRY_NAME = "World";
}