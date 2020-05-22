import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:get/get.dart';

class CountryDetailsController extends GetController {
  static CountryDetailsController get to => Get.find();

  final GetCountryHistoricalCoronaDetailsUseCase getCountryHistoricalCoronaDetailsUseCase;

  CountryDetailsController(this.getCountryHistoricalCoronaDetailsUseCase) : super();

  Response<HistoricalCoronaModel> historicalCoronaModelResponse;

  void load(String countryName) async {
    print("[CountryDetailsController - load] loading");
    historicalCoronaModelResponse = Response.loading();
    update(this);

    try {
      HistoricalCoronaModel countryHistoricalCoronaDetails = await (getCountryHistoricalCoronaDetailsUseCase.call(countryName));

      print("[CountryDetailsController - load] completed: ${countryHistoricalCoronaDetails.toString()}");
      historicalCoronaModelResponse = Response.completed(countryHistoricalCoronaDetails);

      update(this);
    } catch (error) {
      historicalCoronaModelResponse = Response.error(error.toString());

      print("[CountryDetailsController - load] ErrorState: ${error.toString()}");
      update(this);
    }
  }
}