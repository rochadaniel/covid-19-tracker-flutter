import 'package:json_annotation/json_annotation.dart';

part 'country_corona_model.g.dart';

@JsonSerializable()
class CountryCoronaModel {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int totalTests;
  final int testsPerOneMillion;

  CountryCoronaModel(
      this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.totalTests,
      this.testsPerOneMillion);

  factory CountryCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$CountryCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCoronaModelToJson(this);
}