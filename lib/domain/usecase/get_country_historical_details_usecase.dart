import 'package:covid19app/domain/model/historical_corona_model.dart';

import '../repository/corona_repository.dart';

class GetCountryHistoricalCoronaDetailsUseCase {
  final CoronaRepository repository;

  GetCountryHistoricalCoronaDetailsUseCase({this.repository});

  Future<HistoricalCoronaModel> call(String countryName) async {
    print("[GetCountryHistoricalCoronaDetailsUseCase] Trying to find $countryName historical details");
    final result = await repository.getCountryHistoricalDetails(countryName);
    print("[GetCountryHistoricalCoronaDetailsUseCase] Historical details found: ${result.country}");

    return result;
  }
}