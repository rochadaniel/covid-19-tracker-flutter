import 'package:covid19app/domain/repository/corona_repository.dart';

class SaveCountryNameUseCase {
  final CoronaRepository repository;

  SaveCountryNameUseCase({this.repository});

  String call(String countryName) {
    return repository.saveCountryName(countryName);
  }
}