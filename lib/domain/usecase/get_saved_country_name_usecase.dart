import 'package:covid19app/domain/repository/corona_repository.dart';

class GetSavedCountryNameUseCase {
  final CoronaRepository repository;

  GetSavedCountryNameUseCase({this.repository});

  String call() {
    return repository.getSavedCountryName();
  }
}