import 'country_corona_model.dart';

class TotalCoronaDetailsModel {
  final List<CountryCoronaModel> countries;
  final CountryCoronaModel savedCountry;

  TotalCoronaDetailsModel(this.countries, this.savedCountry);
}
