import 'package:covid19app/presentation/screens/main/main_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local/corona_local_datasource.dart';
import 'data/remote/api_helper.dart';
import 'data/remote/corona_remote_datasource.dart';
import 'data/repository/corona_repository_impl.dart';
import 'domain/repository/corona_repository.dart';
import 'domain/usecase/get_countries_corona_details_usecase.dart';
import 'domain/usecase/get_saved_country_name_usecase.dart';
import 'domain/usecase/save_country_name_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Local
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // Api
  serviceLocator.registerFactory(() => ApiHelper().herokuApi);

  // Data sources
  serviceLocator.registerFactory<CoronaRemoteDataSource>(
        () => CoronaRemoteDataSource(herokuApi: serviceLocator()),
  );

  serviceLocator.registerFactory<CoronaLocalDataSource>(
        () => CoronaLocalDataSource(sharedPreferences: serviceLocator()),
  );

  //Repository
  serviceLocator.registerFactory<CoronaRepository>(
        () => CoronaRepositoryImpl(
        remoteDataSource: serviceLocator(), localDataSource: serviceLocator()),
  );

  // Use cases
  serviceLocator.registerFactory(
        () => GetCountriesCoronaDetailsUseCase(repository: serviceLocator()),
  );

  serviceLocator.registerFactory(
        () => GetSavedCountryNameUseCase(repository: serviceLocator()),
  );

  serviceLocator.registerFactory(
        () => SaveCountryNameUseCase(repository: serviceLocator()),
  );

  //BloC
  serviceLocator.registerFactory(
        () => MainBloc(
      getCountriesCoronaDetailsUseCase: serviceLocator(),
      getSavedCountryNameUseCase: serviceLocator(),
      saveCountryNameUseCase: serviceLocator(),
    ),
  );
}