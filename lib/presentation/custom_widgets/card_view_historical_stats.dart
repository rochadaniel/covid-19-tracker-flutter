import 'package:covid19app/presentation/custom_widgets/simple_line_chart.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewHistoricalStats extends StatelessWidget {
  final Map<String, double> historicalTimeline;
  final String cardTitle;
  final String chartName;
  final Color lineColor;

  CardViewHistoricalStats(
      this.historicalTimeline, this.cardTitle, this.chartName, this.lineColor);

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
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      this.cardTitle,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    child: SimpleLineChart(
                      _convertFromHistoricalModel(this.historicalTimeline),
                      this.chartName,
                      this.lineColor,
                      animate: false,
                    ),
                  )
                ],
              )),
            ),
          ]),
    );
  }

  List<SimpleLineChartUIModel> _convertFromHistoricalModel(
      Map<String, double> historicalTimelineCoronaModel) {
    List<SimpleLineChartUIModel> groupList = List();

    int id = -1;

    historicalTimelineCoronaModel.forEach((key, value) {
      id++;
      groupList.add(SimpleLineChartUIModel(id, value));
    });

    return groupList;
  }
}
