import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/repository/corona_repository.dart';

class GetWorldHistoricalCoronaDetailsUseCase {
  final CoronaRepository repository;

  GetWorldHistoricalCoronaDetailsUseCase({this.repository});

  Future<HistoricalCoronaModel> call() async {
    print("[GetWorldHistoricalCoronaDetailsUseCase] Trying to find world historical details");
    final result = await repository.getCountryHistoricalDetails("all");
    print("[GetWorldHistoricalCoronaDetailsUseCase] Historical details found: ${result.country}");

    return result;
  }
}