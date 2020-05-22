import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/response.dart';
import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_details.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_historical_stats.dart';
import 'package:covid19app/presentation/screens/country/country_details_controller.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryCoronaModel countryCoronaModel;

  CountryDetailsScreen({Key key, @required this.countryCoronaModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.foregroundColor,
      appBar: AppBar(
        title: Text(countryCoronaModel.country),
        backgroundColor: Constants.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              GroupedCardViewDetails(
                countryCoronaModel: countryCoronaModel,
                isComplete: true,
              ),
              _buildHistoricalView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoricalView() {
    return GetBuilder<CountryDetailsController>(
      init: CountryDetailsController(Get.find<GetCountryHistoricalCoronaDetailsUseCase>()),
      initState: (_) {
        CountryDetailsController.to.load(countryCoronaModel.country);
      },
      builder: (_) {
        print("[country_details_screen] CountryDetailsController Builder");
        var value = CountryDetailsController.to.historicalCoronaModelResponse;
        switch (value.status) {
          case Status.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case Status.COMPLETED:
            return GroupedCardViewHistoricalStats(value.data.timeline);
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
