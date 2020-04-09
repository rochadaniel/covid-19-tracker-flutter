import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/repository/corona_repository.dart';

class GetWorldCoronaDetailsUseCase {
  final CoronaRepository repository;

  GetWorldCoronaDetailsUseCase({this.repository});

  Future<WorldCoronaModel> call() async {
    print("[GetWorldCoronaDetailsUseCase] Trying to find world details");
    final result = await repository.getWorldDetails();
    print("[GetWorldCoronaDetailsUseCase] world details: ${result.toString()}");

    return result;
  }
}