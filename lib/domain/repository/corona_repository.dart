import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';

abstract class CoronaRepository {
  Future<List<CountryCoronaModel>> getCountriesDetails();

  Future<WorldCoronaModel> getWorldDetails();

  saveCountryName(String countryName);

  String getSavedCountryName();
}