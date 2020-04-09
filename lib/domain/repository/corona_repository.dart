import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';

abstract class CoronaRepository {
  Future<List<CountryCoronaModel>> getCountriesDetails();

  Future<WorldCoronaModel> getWorldDetails();

  Future<HistoricalCoronaModel> getCountryHistoricalDetails(String countryName);

  Future<HistoricalTimelineCoronaModel> getWorldHistoricalDetails();

  saveCountryName(String countryName);

  String getSavedCountryName();
}