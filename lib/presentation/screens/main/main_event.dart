import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {
  MainEvent([List props = const <dynamic>[]]);
}

class GetTotalCoronaDetailsEvent extends MainEvent {}

class GetWorldHistoricalCoronaDetailsEvent extends MainEvent {}

class GetCountryHistoricalCoronaDetailsEvent extends MainEvent {
  @required final String countryName;

  GetCountryHistoricalCoronaDetailsEvent(this.countryName);
}