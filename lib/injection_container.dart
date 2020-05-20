import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_corona_details_usecase.dart';
import 'package:covid19app/domain/usecase/get_world_historical_details_usecase.dart';
import 'package:covid19app/presentation/screens/main/main_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local/corona_local_datasource.dart';
import 'data/remote/api_helper.dart';
import 'data/remote/corona_remote_datasource.dart';
import 'data/repository/corona_repository_impl.dart';
import 'domain/repository/corona_repository.dart';
import 'domain/usecase/get_countries_corona_details_usecase.dart';
import 'domain/usecase/get_saved_country_name_usecase.dart';
import 'domain/usecase/save_country_name_usecase.dart';

//final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Local
  final sharedPreferences = await SharedPreferences.getInstance();
  //serviceLocator.registerLazySingleton(() => sharedPreferences);
  Get.lazyPut<SharedPreferences>(() => sharedPreferences);

  // Api
//  serviceLocator.registerFactory(() => ApiHelper().herokuApi);
  Get.create<Dio>(() => ApiHelper().herokuApi);

  // Data sources
//  serviceLocator.registerFactory<CoronaRemoteDataSource>(
//    () => CoronaRemoteDataSource(herokuApi: serviceLocator()),
//  );
  Get.create<CoronaRemoteDataSource>(
    () => CoronaRemoteDataSource(herokuApi: Get.find<Dio>()),
  );

//  serviceLocator.registerFactory<CoronaLocalDataSource>(
//    () => CoronaLocalDataSource(sharedPreferences: serviceLocator()),
//  );
  Get.create<CoronaLocalDataSource>(
    () =>
        CoronaLocalDataSource(sharedPreferences: Get.find<SharedPreferences>()),
  );

  //Repository
//  serviceLocator.registerFactory<CoronaRepository>(
//    () => CoronaRepositoryImpl(
//        remoteDataSource: serviceLocator(), localDataSource: serviceLocator()),
//  );
  Get.create<CoronaRepository>(
    () => CoronaRepositoryImpl(
      remoteDataSource: Get.find<CoronaRemoteDataSource>(),
      localDataSource: Get.find<CoronaLocalDataSource>(),
    ),
  );

  // Use cases
//  serviceLocator.registerFactory(
//    () => GetCountriesCoronaDetailsUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => GetCountriesCoronaDetailsUseCase(repository: Get.find<CoronaRepository>()),
  );

//  serviceLocator.registerFactory(
//    () => GetSavedCountryNameUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => GetSavedCountryNameUseCase(repository: Get.find<CoronaRepository>()),
  );

//  serviceLocator.registerFactory(
//    () => SaveCountryNameUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => SaveCountryNameUseCase(repository: Get.find<CoronaRepository>()),
  );

//  serviceLocator.registerFactory(
//    () => GetWorldCoronaDetailsUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => GetWorldCoronaDetailsUseCase(repository: Get.find<CoronaRepository>()),
  );

//  serviceLocator.registerFactory(
//    () =>
//        GetCountryHistoricalCoronaDetailsUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => GetCountryHistoricalCoronaDetailsUseCase(repository: Get.find<CoronaRepository>()),
  );

//  serviceLocator.registerFactory(
//    () => GetWorldHistoricalCoronaDetailsUseCase(repository: serviceLocator()),
//  );
  Get.create(
        () => GetWorldHistoricalCoronaDetailsUseCase(repository: Get.find<CoronaRepository>()),
  );


  //BloC
//  serviceLocator.registerFactory(
//    () => MainBloc(
//      getCountriesCoronaDetailsUseCase: serviceLocator(),
//      getSavedCountryNameUseCase: serviceLocator(),
//      saveCountryNameUseCase: serviceLocator(),
//      getWorldCoronaDetailsUseCase: serviceLocator(),
//    ),
//  );

  Get.create(
        () => MainBloc(
          getCountriesCoronaDetailsUseCase: Get.find<GetCountriesCoronaDetailsUseCase>(),
          getSavedCountryNameUseCase: Get.find<GetSavedCountryNameUseCase>(),
          saveCountryNameUseCase: Get.find<SaveCountryNameUseCase>(),
          getWorldCoronaDetailsUseCase: Get.find<GetWorldCoronaDetailsUseCase>(),
        ),
  );
}
