import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/total_corona_details_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/usecase/get_countries_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_saved_country_name_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/save_country_name_usecase.dart';
import 'package:covid19app/utils/constants.dart';

import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetCountriesCoronaDetailsUseCase getCountriesCoronaDetailsUseCase;
  final GetSavedCountryNameUseCase getSavedCountryNameUseCase;
  final SaveCountryNameUseCase saveCountryNameUseCase;
  final GetWorldCoronaDetailsUseCase getWorldCoronaDetailsUseCase;

  MainBloc({
    this.getCountriesCoronaDetailsUseCase,
    this.getSavedCountryNameUseCase,
    this.saveCountryNameUseCase,
    this.getWorldCoronaDetailsUseCase
  });

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is GetTotalCoronaDetailsEvent) {
      print("[GetTotalCoronaDetailsEvent] LoadingState");
      yield LoadingMainState();

      try {
        var list = await Future.wait([
          getWorldCoronaDetailsUseCase.call(),
          getCountriesCoronaDetailsUseCase.call()
        ]);

        print("[GetTotalCoronaDetailsEvent] resultado: ${list.length}");

        WorldCoronaModel worldCoronaModel = list[0];
        List<CountryCoronaModel> countriesCoronaModel = list[1];

        String savedCountryName = getSavedCountryNameUseCase.call();

        if (savedCountryName == null) {
          savedCountryName = Constants.DEFAULT_COUNTRY;

          saveCountryNameUseCase.call(savedCountryName);
        }

        print("[GetTotalCoronaDetailsEvent] Trying to find saved CountryName in countries list");
        final savedCountry =
            countriesCoronaModel.firstWhere((item) => item.country == savedCountryName);
        print("[GetTotalCoronaDetailsEvent] CountryName in countries list found with ${savedCountry.cases.toString()} cases");

        TotalCoronaDetailsModel totalCoronaDetailsModel =
            TotalCoronaDetailsModel(countriesCoronaModel, worldCoronaModel, savedCountry);

        print("[GetTotalCoronaDetailsEvent] SuccessState");
        yield SuccessMainState(totalCoronaDetailsModel);
      } catch (error) {
        print("[GetTotalCoronaDetailsEvent] ErrorState: ${error.toString()}");
        yield ErrorMainState();
      }
    }
  }
}
