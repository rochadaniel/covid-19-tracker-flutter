import 'package:covid19app/domain/repository/corona_repository.dart';

class GetSavedCountryNameUseCase {
  final CoronaRepository repository;

  GetSavedCountryNameUseCase({this.repository});

  String call() {
    print("[GetSavedCountryNameUseCase] Trying to find saved CountryName");
    final result = repository.getSavedCountryName();
    print("[GetSavedCountryNameUseCase] Found saved CountryName: $result");
    return result;
  }
}