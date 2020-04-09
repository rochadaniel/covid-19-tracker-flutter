import 'package:json_annotation/json_annotation.dart';

part 'world_corona_model.g.dart';

@JsonSerializable()
class WorldCoronaModel {
  final double updated;
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
  final double affectedCountries;

  WorldCoronaModel(this.updated, this.cases, this.todayCases, this.deaths,
      this.todayDeaths, this.recovered, this.active, this.critical,
      this.casesPerOneMillion, this.deathsPerOneMillion, this.tests,
      this.testsPerOneMillion, this.affectedCountries);

  factory WorldCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$WorldCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorldCoronaModelToJson(this);
}