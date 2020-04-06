import 'package:covid19app/domain/model/country_corona_model.dart';

abstract class CoronaRepository {
  Future<List<CountryCoronaModel>> getCountriesDetails();
}