import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonutPieChart extends StatelessWidget {
  final int totalCases;
  final List<PieChartUIModel> models;
  final bool animate;

  DonutPieChart({this.totalCases, this.models, this.animate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        charts.PieChart(
          _createSeriesList(),
          animate: animate,
          animationDuration: Duration(milliseconds: 500),
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${Constants.TOTAL_CASES_STRING.toLowerCase()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  "${NumberUtils.formatDecimalPlaces(this.totalCases)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<PieChartUIModel, String>> _createSeriesList() {
    return [
      new charts.Series<PieChartUIModel, String>(
        id: 'Cases',
        domainFn: (PieChartUIModel cases, _) => cases.name,
        measureFn: (PieChartUIModel cases, _) => cases.value,
        colorFn: (PieChartUIModel cases, _) => cases.color,
        labelAccessorFn: (PieChartUIModel row, _) => '${row.name}',
        data: models,
      )
    ];
  }
}

class PieChartUIModel {
  final String name;
  final int value;
  final charts.Color color;

  PieChartUIModel(this.name, this.value, this.color);
}