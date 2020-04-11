import 'package:covid19app/domain/model/historical_corona_model.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'card_view_historical_stats.dart';

class GroupedCardViewHistoricalStats extends StatelessWidget {
  final HistoricalTimelineCoronaModel timeline;

  GroupedCardViewHistoricalStats(this.timeline);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CardViewHistoricalStats(
            this.timeline.cases,
            "Historical data of total cases per day",
            "Cases",
            Colors.deepPurpleAccent,
          ),
          CardViewHistoricalStats(
            this.timeline.recovered,
            "Historical data of total cases recovered per day",
            Constants.RECOVERED_CASES_STRING,
            Colors.green,
          ),
          CardViewHistoricalStats(
            this.timeline.deaths,
            "Historical data of total deaths per day",
            Constants.DEATHS_CASES_STRING,
            Colors.red,
          ),
        ],
      ),
    );
  }
}
