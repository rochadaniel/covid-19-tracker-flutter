import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19app/domain/model/historical_corona_model.dart';

/// Bar chart with series legend example
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<SimpleLineChartUIModel> models;
  final String chartName;
  final Color lineColor;
  final bool animate;

  SimpleLineChart(this.models, this.chartName, this.lineColor, {this.animate});

  static List<SimpleLineChartUIModel> _convertFromHistoricalModel(
      Map<String, double> historicalTimelineCoronaModel) {
    List<SimpleLineChartUIModel> groupList = List();

    int id = -1;

    historicalTimelineCoronaModel.forEach((key, value) {
      id++;
      groupList.add(SimpleLineChartUIModel(id, value));
    });

    return groupList;
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      _createSeriesList(),
      animate: animate,
      // Add the series legend behavior to the chart to turn on series legends.
      // By default the legend will display above the chart.
      behaviors: [
        new charts.SeriesLegend(
            entryTextStyle:
                charts.TextStyleSpec(color: charts.MaterialPalette.white))
      ],

      /// Assign a custom style for the domain axis.
      ///
      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
//        renderSpec: new charts.SmallTickRendererSpec(
//          // Tick and Label styling here.
//          labelStyle: new charts.TextStyleSpec(
//            fontSize: 12, // size in Pts.
//            color: charts.MaterialPalette.white,
//          ),
//
//          // Change the line colors to match text color.
//          lineStyle: new charts.LineStyleSpec(
//            color: charts.MaterialPalette.white,
//          ),
//        ),
      ),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredMinTickCount: 5
          ),
          renderSpec: new charts.GridlineRendererSpec(
            // Tick and Label styling here.
            labelStyle: new charts.TextStyleSpec(
              fontSize: 12, // size in Pts.
              color: charts.MaterialPalette.white,
            ),

            // Change the line colors to match text color.
            lineStyle: new charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shade400,
            ),
          )),
    );
  }

  List<charts.Series<SimpleLineChartUIModel, int>> _createSeriesList() {
    var list = List<charts.Series<SimpleLineChartUIModel, int>>();

    list.add(charts.Series<SimpleLineChartUIModel, int>(
      id: this.chartName,
      domainFn: (SimpleLineChartUIModel chartModel, _) => chartModel.id,
      measureFn: (SimpleLineChartUIModel chartModel, _) => chartModel.value,
      colorFn: (SimpleLineChartUIModel chartModel, _) => charts.ColorUtil.fromDartColor(this.lineColor),
      data: models,
    ));

    return list;
  }
}

class SimpleLineChartUIModel {
  final int id;
  final double value;

  SimpleLineChartUIModel(this.id, this.value);
}
