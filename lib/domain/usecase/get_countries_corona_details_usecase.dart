import '../model/country_corona_model.dart';
import '../repository/corona_repository.dart';

class GetCountriesCoronaDetailsUseCase {
  final CoronaRepository repository;

  GetCountriesCoronaDetailsUseCase({this.repository});

  Future<List<CountryCoronaModel>> call() async {
    return await repository.getCountriesDetails();
  }
}