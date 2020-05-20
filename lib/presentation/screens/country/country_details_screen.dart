import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/domain/usecase/get_country_historical_details_usecase.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_details.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_historical_stats.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../injection_container.dart';

class CountryDetailsScreen extends StatefulWidget {
  final CountryCoronaModel countryCoronaModel;

  CountryDetailsScreen({Key key, @required this.countryCoronaModel})
      : super(key: key);

  @override
  _CountryDetailsScreenState createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  Future getCountryHistoricalCoronaDetailsFuture;

  @override
  void initState() {
    super.initState();

    final getCountryHistoricalCoronaDetailsUseCase = Get.find<GetCountryHistoricalCoronaDetailsUseCase>();
    getCountryHistoricalCoronaDetailsFuture = getCountryHistoricalCoronaDetailsUseCase.call(widget.countryCoronaModel.country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.foregroundColor,
      appBar: AppBar(
        title: Text(widget.countryCoronaModel.country),
        backgroundColor: Constants.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              GroupedCardViewDetails(
                countryCoronaModel: widget.countryCoronaModel,
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
