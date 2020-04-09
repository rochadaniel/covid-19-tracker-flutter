import 'package:json_annotation/json_annotation.dart';

part 'historical_corona_model.g.dart';

@JsonSerializable()
class HistoricalCoronaModel {
  final String country;
  final HistoricalTimelineCoronaModel timeline;

  HistoricalCoronaModel(this.country, this.timeline);

  factory HistoricalCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalCoronaModelToJson(this);
}

@JsonSerializable()
class HistoricalTimelineCoronaModel {
  final Map<String, double> cases;
  final Map<String, double> deaths;
  final Map<String, double> recovered;

  HistoricalTimelineCoronaModel(this.cases, this.deaths, this.recovered);

  factory HistoricalTimelineCoronaModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalTimelineCoronaModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalTimelineCoronaModelToJson(this);
}