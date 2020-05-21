import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/model/total_corona_details_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/usecase/get_countries_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_saved_country_name_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/save_country_name_usecase.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:get/get.dart';

class MainController extends GetController {
  static MainController get to => Get.find();

  Response<TotalCoronaDetailsModel> totalCoronaDetailsModel = Response.empty();

  final GetCountriesCoronaDetailsUseCase getCountriesCoronaDetailsUseCase;
  final GetSavedCountryNameUseCase getSavedCountryNameUseCase;
  final SaveCountryNameUseCase saveCountryNameUseCase;
  final GetWorldCoronaDetailsUseCase getWorldCoronaDetailsUseCase;

  MainController({
    this.getCountriesCoronaDetailsUseCase,
    this.getSavedCountryNameUseCase,
    this.saveCountryNameUseCase,
    this.getWorldCoronaDetailsUseCase,
  }) : super();

  void load() async {
    totalCoronaDetailsModel = Response.loading();
    update(this);

//    await Future.delayed(Duration(seconds: 5));
//
//    totalCoronaDetailsModel = Response.error("daniel");
//    update(this);

    try {
      var list = await Future.wait([
        getWorldCoronaDetailsUseCase.call(),
        getCountriesCoronaDetailsUseCase.call()
      ]);

      print("[MainController - load] resultado: ${list.length}");

      WorldCoronaModel worldCoronaModel = list[0];
      List<CountryCoronaModel> countriesCoronaModel = list[1];

      String savedCountryName = getSavedCountryNameUseCase.call();

      if (savedCountryName == null) {
        savedCountryName = Constants.DEFAULT_COUNTRY;

        saveCountryNameUseCase.call(savedCountryName);
      }

      print("[MainController - load] Trying to find saved CountryName in countries list");
      final savedCountry =
      countriesCoronaModel.firstWhere((item) => item.country == savedCountryName);
      print("[MainController - load] CountryName in countries list found with ${savedCountry.cases.toString()} cases");

      totalCoronaDetailsModel = Response.completed(TotalCoronaDetailsModel(countriesCoronaModel, worldCoronaModel, savedCountry));

      print("[MainController - load] SuccessState");
      update(this);
    } catch (error) {
      totalCoronaDetailsModel = Response.error(error.toString());
      print("[MainController - load] ErrorState: ${error.toString()}");
      update(this);
    }
  }
}
//class MainController extends RxController {
//  static MainController get to => Get.find();
//
//  final Rx<Response<int>> totalCoronaDetailsModel = Response.empty().obs;
//
//  @override
//  void onInit() {
//    super.onInit();
//
////    loadTest();
//  }
//  void loadTest() async {
//    totalCoronaDetailsModel.value = Response.loading();
//
//    Future.delayed(const Duration(milliseconds: 5000), () {
//      totalCoronaDetailsModel.value = Response.error("daniel");
//    });
//  }
//}