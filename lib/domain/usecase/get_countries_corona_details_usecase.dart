import '../model/country_corona_model.dart';
import '../repository/corona_repository.dart';

class GetCountriesCoronaDetailsUseCase {
  final CoronaRepository repository;

  GetCountriesCoronaDetailsUseCase({this.repository});

  Future<List<CountryCoronaModel>> call() async {
    print("[GetCountriesCoronaDetailsUseCase] Trying to find countries list");
    final result = await repository.getCountriesDetails();
    print("[GetCountriesCoronaDetailsUseCase] countries list result: ${result.length.toString()}");

    return result;
  }
}