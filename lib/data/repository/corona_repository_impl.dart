import 'package:covid19app/data/remote/corona_remote_datasource.dart';
import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/repository/corona_repository.dart';
import 'package:flutter/widgets.dart';

class CoronaRepositoryImpl extends CoronaRepository {
  final CoronaRemoteDataSource remoteDataSource;

  CoronaRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<List<CountryCoronaModel>> getCountriesDetails() async {
    return await remoteDataSource.getCountriesDetails();
  }
}