import 'package:json_annotation/json_annotation.dart';

part 'country_corona_model.g.dart';

@JsonSerializable()
class CountryCoronaModel {
  final String country;
  final CountryInfoCoronaModel countryInfo;
  final double cases;
  final double todayCases;
  final double deaths;
  final double todayDeaths;
  final double recovered;
  final double active;
  final double critical;
  final double casesPerOneMillion;
  final double deathsPerOneMillion;
  final double tests;
  final double testsPerOneMillion;
  final double updated;

  CountryCoronaModel(
      this.country,
      this.countryInfo,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.updated);

  factory CountryCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$CountryCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCoronaModelToJson(this);
}

@JsonSerializable()
class CountryInfoCoronaModel {
  @JsonKey(name: "_id")
  final int id;
  final String iso2;
  final String iso3;
  final double lat;
  final double long;
  final String flag;

  CountryInfoCoronaModel(
      this.id, this.iso2, this.iso3, this.lat, this.long, this.flag);

  factory CountryInfoCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$CountryInfoCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryInfoCoronaModelToJson(this);
}
