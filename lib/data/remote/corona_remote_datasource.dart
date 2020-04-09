import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class CoronaRemoteDataSource {
  final Dio herokuApi;

  CoronaRemoteDataSource({@required this.herokuApi});

  Future<List<CountryCoronaModel>> getCountriesDetails() async {
    try {
      Response response = await herokuApi.get("/countries");

      List<CountryCoronaModel> result = new List<CountryCoronaModel>();

      response.data.forEach((postJson) {
        result.add(CountryCoronaModel.fromJson(postJson));
      });

      return result;
    } catch (er) {
      if (er is DioError) {}
      throw ("Default error message: ${er.toString()}");
    }
  }

  Future<WorldCoronaModel> getWorldDetails() async {
    try {
      Response response = await herokuApi.get("/all");

      return WorldCoronaModel.fromJson(response.data);
    } catch (er) {
      if (er is DioError) {}
      throw ("Default error message: ${er.toString()}");
    }
  }
}
