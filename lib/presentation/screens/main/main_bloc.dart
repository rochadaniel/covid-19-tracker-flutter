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
  Stream<MainState> mapEventToState(MainEvent event,) async* {
    if (event is GetTotalCoronaDetailsEvent) {
      yield LoadingMainState();

      try {
        final countries = await getCountriesCoronaDetailsUseCase.call();

        String savedCountryName = getSavedCountryNameUseCase.call();
        if (savedCountryName == null) {
          savedCountryName = Constants.DEFAULT_COUNTRY;
        }

        final savedCountry =
        countries.firstWhere((item) => item.country == savedCountryName);

        TotalCoronaDetailsModel totalCoronaDetailsModel =
        TotalCoronaDetailsModel(countries, savedCountry);

        yield SuccessMainState(totalCoronaDetailsModel);
      } catch (error) {
        yield ErrorMainState();
      }
    }
  }
}
