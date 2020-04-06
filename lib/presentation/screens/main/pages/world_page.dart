import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/presentation/custom_widgets/card_view_graph_stats.dart';
import 'package:covid19app/presentation/screens/country/country_details_screen.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class WorldPage extends StatelessWidget {
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
    return Text(Constants.DEFAULT_ERROR_STRING);
  }

  Widget _showCountriesView(List<CountryCoronaModel> countries) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: countries.length,
      itemBuilder: (BuildContext context, int index) {
        final countryCoronaItem = countries[index];
        if (index == 0 &&
            countryCoronaItem.country.toLowerCase() == Constants.WORLD_COUNTRY_NAME.toLowerCase()) {
          return CardViewGraphStats(countryCoronaModel: countryCoronaItem);
        } else {
          return Card(
            color: Constants.backgroundColor,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountryDetailsScreen(countryCoronaModel: countryCoronaItem),
                  ),
                );
              },
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
        }
      },
    );
  }
}
