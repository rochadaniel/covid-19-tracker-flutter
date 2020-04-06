import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19app/domain/model/total_corona_details_model.dart';
import 'package:covid19app/domain/usecase/get_countries_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_saved_country_name_usecase.dart';
import 'package:covid19app/domain/usecase/save_country_name_usecase.dart';
import 'package:covid19app/utils/constants.dart';

import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetCountriesCoronaDetailsUseCase getCountriesCoronaDetailsUseCase;
  final GetSavedCountryNameUseCase getSavedCountryNameUseCase;
  final SaveCountryNameUseCase saveCountryNameUseCase;

  MainBloc({
    this.getCountriesCoronaDetailsUseCase,
    this.getSavedCountryNameUseCase,
    this.saveCountryNameUseCase
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
        print("[GetTotalCoronaDetailsEvent] Trying to find countries list");
        final countries = await getCountriesCoronaDetailsUseCase.call();
        print("[GetTotalCoronaDetailsEvent] countries list result: ${countries.length.toString()}");

        print("[GetTotalCoronaDetailsEvent] Trying to find saved CountryName");
        String savedCountryName = getSavedCountryNameUseCase.call();
        print("[GetTotalCoronaDetailsEvent] Found saved CountryName: $savedCountryName");
        if (savedCountryName == null) {
          savedCountryName = Constants.DEFAULT_COUNTRY;

          print("[GetTotalCoronaDetailsEvent] Trying to save CountryName");
          saveCountryNameUseCase.call(savedCountryName);
          print("[GetTotalCoronaDetailsEvent] CountryName saved: $savedCountryName");
        }

        print("[GetTotalCoronaDetailsEvent] Trying to find saved CountryName in countries list");
        final savedCountry =
            countries.firstWhere((item) => item.country == savedCountryName);
        print("[GetTotalCoronaDetailsEvent] CountryName in countries list found with ${savedCountry.cases.toString()} cases");

        TotalCoronaDetailsModel totalCoronaDetailsModel =
            TotalCoronaDetailsModel(countries, savedCountry);

        print("[GetTotalCoronaDetailsEvent] SuccessState");
        yield SuccessMainState(totalCoronaDetailsModel);
      } catch (error) {
        print("[GetTotalCoronaDetailsEvent] ErrorState: ${error.toString()}");
        yield ErrorMainState();
      }
    }
  }
}
