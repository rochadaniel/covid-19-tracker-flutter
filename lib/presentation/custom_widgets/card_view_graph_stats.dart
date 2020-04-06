import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'donut_pie_chart.dart';

class CardViewGraphStats extends StatelessWidget {
  final CountryCoronaModel countryCoronaModel;

  CardViewGraphStats({this.countryCoronaModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.backgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    alignment: Alignment.center,
                    child: Text(
                      countryCoronaModel.country == Constants.WORLD_COUNTRY_NAME
                          ? Constants.WORLD_COUNTRY_NAME
                          : countryCoronaModel.country,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    child: DonutPieChart(
                      totalCases: this.countryCoronaModel.cases,
                      models: _makeChartModels(),
                      animate: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          _buildChartDetails(
                              Constants.ACTIVE_CASES_STRING,
                              NumberUtils.formatDecimalPlaces(
                                  this.countryCoronaModel.active),
                              Colors.blue),
                          _buildChartDetails(
                              Constants.RECOVERED_CASES_STRING,
                              NumberUtils.formatDecimalPlaces(
                                  this.countryCoronaModel.recovered),
                              Colors.green),
                          _buildChartDetails(
                            Constants.DEATHS_CASES_STRING,
                            NumberUtils.formatDecimalPlaces(
                                this.countryCoronaModel.deaths),
                            Colors.red,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
          ]),
    );
  }

  Widget _buildChartDetails(String title, String value, Color circleColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCircle(circleColor),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey[300], fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 12,
      height: 12,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  List<PieChartUIModel> _makeChartModels() {
    return [
      new PieChartUIModel(
          Constants.ACTIVE_CASES_STRING,
          this.countryCoronaModel.active,
          charts.MaterialPalette.blue.shadeDefault),
      new PieChartUIModel(
          Constants.RECOVERED_CASES_STRING,
          this.countryCoronaModel.recovered,
          charts.MaterialPalette.green.shadeDefault),
      new PieChartUIModel(
          Constants.DEATHS_CASES_STRING,
          this.countryCoronaModel.deaths,
          charts.MaterialPalette.red.shadeDefault),
    ];
  }
}
