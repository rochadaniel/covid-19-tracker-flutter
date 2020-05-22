import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/presentation/screens/country/country_details_screen.dart';
import 'package:covid19app/presentation/screens/main/pages/search_controller.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: GetBuilder<MainController>(
        builder: (_) {
          var value = _.countriesResponse;
          print("**********[search_page] MainController Builder: ${value.toString()}");
          switch (value.status) {
            case Status.LOADING:
              return _showLoadingView();
              break;
            case Status.COMPLETED:
              return _showCountriesView(value.data);
              break;
            case Status.ERROR:
              return _showErrorView();
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _showLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _showErrorView() {
    return Center(
      child: Text(Constants.DEFAULT_ERROR_STRING),
    );
  }

  Widget _showCountriesView(List<CountryCoronaModel> countries) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (_) {
        SearchController.to.controller = new TextEditingController();

        SearchController.to.controller.addListener(() {
          Get.find<SearchController>().updateFilter(SearchController.to.controller.text);
        });
      },
      dispose: (_) {
        SearchController.to.controller.dispose();
      },
      builder: (_) {
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: countries.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    labelText: "Search",
                    labelStyle: TextStyle(color: Colors.grey[200]),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid)),
                  ),
                  controller: SearchController.to.controller,
                ),
              );
            } else {
              final countryCoronaItem = countries[index - 1];
              if (_.filter == null ||
                  _.filter == "" ||
                  countryCoronaItem.country
                      .toLowerCase()
                      .contains(_.filter.toLowerCase())) {
                return Card(
                  color: Constants.backgroundColor,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CountryDetailsScreen(
                                  countryCoronaModel: countryCoronaItem),
                        ),
                      );
                    },
                    leading: Image.network(
                      countryCoronaItem.countryInfo.flag,
                      width: 60,
                      height: 60,
                    ),
//            leading: CircleAvatar(
//              radius: 30.0,
//              backgroundImage:
//              NetworkImage(countryCoronaItem.countryInfo.flag),
//              backgroundColor: Colors.transparent,
//            ),
                    title: Text(
                      countryCoronaItem.country,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "${Constants.TOTAL_CASES_STRING}: ${NumberUtils
                          .formatDecimalPlaces(countryCoronaItem.cases)}",
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
          },
        );
      }
    );
  }
}
