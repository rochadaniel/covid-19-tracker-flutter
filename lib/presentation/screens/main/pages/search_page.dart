import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/presentation/screens/country/country_details_screen.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<CountryCoronaModel> items;
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: GetBuilder<MainController>(
        builder: (_) {
          print("[search_page] MainController Builder");
          var value = MainController.to.totalCoronaDetailsModelResponse;
          switch (value.status) {
            case Status.LOADING:
              return _showLoadingView();
              break;
            case Status.COMPLETED:
              return _showCountriesView(value.data.countries);
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
              controller: controller,
            ),
          );
        } else {
          final countryCoronaItem = countries[index - 1];
          if (filter == null ||
              filter == "" ||
              countryCoronaItem.country
                  .toLowerCase()
                  .contains(filter.toLowerCase())) {
            return Card(
              color: Constants.backgroundColor,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountryDetailsScreen(
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
                  "${Constants.TOTAL_CASES_STRING}: ${NumberUtils.formatDecimalPlaces(countryCoronaItem.cases)}",
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
}
