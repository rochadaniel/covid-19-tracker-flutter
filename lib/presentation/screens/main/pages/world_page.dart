import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/model/world_corona_model.dart';
import 'package:covid19app/domain/usecase/get_world_historical_details_usecase.dart';
import 'package:covid19app/presentation/custom_widgets/card_view_graph_stats.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_historical_stats.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  Future getWorldHistoricalCoronaDetailsFuture;

  @override
  void initState() {
    super.initState();
    final getWorldHistoricalCoronaDetailsUseCase = Get.find<GetWorldHistoricalCoronaDetailsUseCase>();

    getWorldHistoricalCoronaDetailsFuture = getWorldHistoricalCoronaDetailsUseCase.call();
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
              return _showCountriesView(value.data.worldCoronaModel);
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
    return FutureBuilder(
      future: getWorldHistoricalCoronaDetailsFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("");
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError)
              return Center(
                child: Text(Constants.DEFAULT_ERROR_STRING),
              );
            else {
              final historicalTimelineCoronaModel =
                  snapshot.data as HistoricalTimelineCoronaModel;

              return GroupedCardViewHistoricalStats(
                  historicalTimelineCoronaModel);
            }
        }
      },
    );
  }
}
