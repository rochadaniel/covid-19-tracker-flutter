import 'package:covid19app/data/local/corona_local_datasource.dart';
import 'package:covid19app/data/remote/corona_remote_datasource.dart';
import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/repository/corona_repository.dart';

class CoronaRepositoryImpl extends CoronaRepository {
  final CoronaRemoteDataSource remoteDataSource;
  final CoronaLocalDataSource localDataSource;

  CoronaRepositoryImpl({this.remoteDataSource, this.localDataSource});

  @override
  Future<List<CountryCoronaModel>> getCountriesDetails() async {
    return await remoteDataSource.getCountriesDetails();
  }

  @override
  Future<WorldCoronaModel> getWorldDetails() async {
    return await remoteDataSource.getWorldDetails();
  }


  @override
  Future<HistoricalCoronaModel> getCountryHistoricalDetails(String countryName) async {
    return await remoteDataSource.getHistoricalCoronaModel(countryName);
  }

  @override
  Future<HistoricalTimelineCoronaModel> getWorldHistoricalDetails() async {
    return await remoteDataSource.getWorldHistoricalDetails();
  }


  @override
  String getSavedCountryName() {
    return localDataSource.getSavedCountryName();
  }

  @override
  saveCountryName(String countryName) {
    return localDataSource.saveCountryName(countryName);
  }
}