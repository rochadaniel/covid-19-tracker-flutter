import 'package:covid19app/domain/repository/corona_repository.dart';

class SaveCountryNameUseCase {
  final CoronaRepository repository;

  SaveCountryNameUseCase({this.repository});

  String call(String countryName) {
    print("[GetTotalCoronaDetailsEvent] Trying to save CountryName");
    final result = repository.saveCountryName(countryName);
    print("[GetTotalCoronaDetailsEvent] CountryName saved: $result");

    return result;
  }
}