import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:covid19app/presentation/custom_widgets/card_view_graph_stats.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_details.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_historical_stats.dart';
import 'package:covid19app/presentation/screens/main/main_controller.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: GetBuilder<MainController>(
        init: MainController(
            getCountriesCoronaDetailsUseCase: Get.find(),
            getSavedCountryNameUseCase: Get.find(),
            saveCountryNameUseCase: Get.find(),
            getWorldCoronaDetailsUseCase: Get.find()
        ),
        initState: (_) {
          print("**********[main_screen] MainController initState");
          MainController.to.load();
        },
        builder: (_) {
          var value = MainController.to.savedCountryResponse;
          print("**********[home_page] MainController Builder: ${value.toString()}");

          switch (value.status) {
            case Status.LOADING:
              return _showLoadingView();
              break;
            case Status.COMPLETED:
              return _showHomeView(value.data);
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

  Widget _showHomeView(CountryCoronaModel countryCoronaModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CardViewGraphStats(
              cases: countryCoronaModel.cases,
              active: countryCoronaModel.active,
              recovered: countryCoronaModel.recovered,
              deaths: countryCoronaModel.deaths,
              countryName: countryCoronaModel.country,
            ),
            GroupedCardViewDetails(
              countryCoronaModel: countryCoronaModel,
              isComplete: false,
            ),
            FlatButton(
              onPressed: () {
                Get.find<MainController>().load();
              },
              child: Text(
                "Flat Button",
              ),
            ),
            _buildHistoricalView(countryCoronaModel.country),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoricalView(String countryName) {
    final getCountryHistoricalCoronaDetailsUseCase = Get.find<GetCountryHistoricalCoronaDetailsUseCase>();
    final getCountryHistoricalCoronaDetailsFuture = getCountryHistoricalCoronaDetailsUseCase.call(countryName);

    return FutureBuilder(
      future: getCountryHistoricalCoronaDetailsFuture,
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
              final historicalCoronaModel =
              snapshot.data as HistoricalCoronaModel;

              return GroupedCardViewHistoricalStats(
                  historicalCoronaModel.timeline);
            }
        }
      },
    );
  }
}
