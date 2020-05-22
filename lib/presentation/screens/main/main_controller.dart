import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/usecase/get_countries_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_saved_country_name_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_historical_details_usecase.dart';
import 'package:covid19app/domain/usecase/save_country_name_usecase.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:get/get.dart';

class MainController extends GetController {
  static MainController get to => Get.find();

  Response<List<CountryCoronaModel>> countriesResponse;
  Response<WorldCoronaModel> worldCoronaModelResponse;
  Response<CountryCoronaModel> savedCountryResponse;

  Response<HistoricalTimelineCoronaModel> historicalTimelineResponse;

  Response<HistoricalCoronaModel> historicalCoronaResponse;

  final GetCountriesCoronaDetailsUseCase getCountriesCoronaDetailsUseCase;
  final GetSavedCountryNameUseCase getSavedCountryNameUseCase;
  final SaveCountryNameUseCase saveCountryNameUseCase;
  final GetWorldCoronaDetailsUseCase getWorldCoronaDetailsUseCase;
  final GetWorldHistoricalCoronaDetailsUseCase getWorldHistoricalCoronaDetailsUseCase;
  final GetCountryHistoricalCoronaDetailsUseCase getCountryHistoricalCoronaDetailsUseCase;

  MainController({
    this.getCountriesCoronaDetailsUseCase,
    this.getSavedCountryNameUseCase,
    this.saveCountryNameUseCase,
    this.getWorldCoronaDetailsUseCase,
    this.getWorldHistoricalCoronaDetailsUseCase,
    this.getCountryHistoricalCoronaDetailsUseCase
  }) : super();

  void load() async {
    print("==============[MainController - load] loading");
    countriesResponse = Response.loading();
    worldCoronaModelResponse = Response.loading();
    savedCountryResponse = Response.loading();

    update(this);

    try {
      var list = await Future.wait([
        getWorldCoronaDetailsUseCase.call(),
        getCountriesCoronaDetailsUseCase.call()
      ]);

      print("==============[MainController - load] result: ${list.length}");

      WorldCoronaModel worldCoronaModel = list[0];
      List<CountryCoronaModel> countriesCoronaModel = list[1];

      String savedCountryName = getSavedCountryNameUseCase.call();

      if (savedCountryName == null) {
        savedCountryName = Constants.DEFAULT_COUNTRY;

        saveCountryNameUseCase.call(savedCountryName);
      }

      print(
          "==============[MainController - load] Trying to find saved CountryName in countries list");
      final savedCountry = countriesCoronaModel
          .firstWhere((item) => item.country == savedCountryName);
      print(
          "==============[MainController - load] CountryName in countries list found with ${savedCountry.cases.toString()} cases");

      print("==============[MainController - load] Success");
      countriesResponse = Response.completed(countriesCoronaModel);
      worldCoronaModelResponse = Response.completed(worldCoronaModel);
      savedCountryResponse = Response.completed(savedCountry);

      update(this);
    } catch (error) {
      print("==============[MainController - load] ErrorState: ${error.toString()}");
      countriesResponse = Response.error(error.toString());
      worldCoronaModelResponse = Response.error(error.toString());
      savedCountryResponse = Response.error(error.toString());

      update(this);
    }
  }

  void loadHistoricalTimeline() async {
    final logPrefix = "==============[MainController - loadHistoricalTimeline]";
    try {
      print("$logPrefix loading");
      historicalTimelineResponse = Response.loading();

      update(this, ['1']);

      HistoricalTimelineCoronaModel historicalTimelineCoronaModel = await (getWorldHistoricalCoronaDetailsUseCase.call());

      print("$logPrefix Success");
      historicalTimelineResponse = Response.completed(historicalTimelineCoronaModel);

      update(this, ['1']);
    } catch (error) {
      print("$logPrefix ErrorState: ${error.toString()}");
      historicalTimelineResponse = Response.error(error.toString());

      update(this, ['1']);
    }
  }

  void loadHistorical(String countryName) async {
    final logPrefix = "==============[MainController - loadHistorical: $countryName]";
    try {
      print("$logPrefix loading");
      historicalCoronaResponse = Response.loading();

      update(this, ['2']);

      HistoricalCoronaModel historicalCoronaModel = await (getCountryHistoricalCoronaDetailsUseCase.call(countryName));

      print("$logPrefix Success: ${historicalCoronaModel.country}");
      historicalCoronaResponse = Response.completed(historicalCoronaModel);

      update(this);
    } catch (error) {
      print("$logPrefix ErrorState: ${error.toString()}");
      historicalCoronaResponse = Response.error(error.toString());

      update(this, ['2']);
    }
  }
}
