import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/presentation/screens/country/country_details_screen.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';
import '../main_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        if (state is InitialMainState) {
          return Text("");
        } else if (state is SuccessMainState) {
          return _showCountriesView(state.totalCoronaDetailsModel.countries);
        } else if (state is LoadingMainState) {
          return _showLoadingView();
        } else {
          return _showErrorView();
        }
      }),
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
        final countryCoronaItem = countries[index];
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
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage:
              NetworkImage(countryCoronaItem.countryInfo.flag),
              backgroundColor: Colors.transparent,
            ),
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
      },
    );
  }
}
