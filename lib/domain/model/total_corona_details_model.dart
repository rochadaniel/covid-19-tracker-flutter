import 'package:covid19app/domain/model/world_corona_model.dart';

import 'country_corona_model.dart';

class TotalCoronaDetailsModel {
  final List<CountryCoronaModel> countries;
  final WorldCoronaModel worldCoronaModel;
  final CountryCoronaModel savedCountry;

  TotalCoronaDetailsModel(this.countries, this.worldCoronaModel, this.savedCountry);
}
