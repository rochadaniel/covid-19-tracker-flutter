import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/presentation/custom_widgets/card_view_graph_stats.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_historical_stats.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class WorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: GetBuilder<MainController>(
        builder: (_) {
          var value = _.worldCoronaModelResponse;
          print("**********[world_page] MainController Builder: ${value.toString()}");
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

  Widget _showCountriesView(WorldCoronaModel worldCoronaModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CardViewGraphStats(
              cases: worldCoronaModel.cases,
              active: worldCoronaModel.active,
              recovered: worldCoronaModel.recovered,
              deaths: worldCoronaModel.deaths,
              countryName: Constants.WORLD_COUNTRY_NAME,
            ),
            _buildHistoricalView()
          ],
        ),
      ),
    );
  }

  Widget _buildHistoricalView() {
//    return Container();
    return GetBuilder<MainController>(
      id: '1',
      initState: (_) {
        print("________danuel");
        MainController.to.loadHistoricalTimeline();
      },
      builder: (_) {
        var value = _.historicalTimelineResponse;
        print("**********[world_page] MainController Builder _buildHistoricalView: ${value?.toString()}");

        switch (value?.status) {
          case Status.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case Status.COMPLETED:
            return GroupedCardViewHistoricalStats(value.data);
            break;
          case Status.ERROR:
            return Center(
              child: Text(Constants.DEFAULT_ERROR_STRING),
            );
            break;
        }
        return Container();
      },
    );
  }
}
