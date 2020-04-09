import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:covid19app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class GroupedCardViewDetails extends StatelessWidget {
  final CountryCoronaModel countryCoronaModel;
  final bool isComplete;

  GroupedCardViewDetails({this.countryCoronaModel, this.isComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: this.isComplete
            ? _buildCompleteCardDetails(countryCoronaModel)
            : _buildCardDetails(countryCoronaModel),
      ),
    );
  }

  List<Widget> _buildCompleteCardDetails(
      CountryCoronaModel countryCoronaModel) {
    var list = List<Widget>();
    list.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: _buildColorCard(
              Constants.TOTAL_CASES_STRING,
              NumberUtils.formatDecimalPlaces(countryCoronaModel.cases),
              Color(0xFF475c78)),
        ),
        Expanded(
          flex: 2,
          child: _buildColorCard(
              Constants.ACTIVE_CASES_STRING,
              NumberUtils.formatDecimalPlaces(countryCoronaModel.active),
              Colors.blue),
        ),
      ],
    ));

    list.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: _buildColorCard(
              Constants.RECOVERED_CASES_STRING,
              NumberUtils.formatDecimalPlaces(countryCoronaModel.recovered),
              Colors.green),
        ),
        Expanded(
          flex: 2,
          child: _buildColorCard(
              Constants.DEATHS_CASES_STRING,
              NumberUtils.formatDecimalPlaces(countryCoronaModel.deaths),
              Colors.red),
        ),
      ],
    ));

    list.addAll(_buildCardDetails(countryCoronaModel));

    return list;
  }

  List<Widget> _buildCardDetails(CountryCoronaModel countryCoronaModel) {
    return <Widget>[
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.TODAY_CASES_STRING,
                NumberUtils.formatDecimalPlaces(countryCoronaModel.todayCases),
                Color(0xFF8fb9a8)),
          ),
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.PER_ONE_MILLION_CASES_STRING,
                NumberUtils.formatDecimalPlaces(
                    countryCoronaModel.casesPerOneMillion),
                Color(0xFFf1828d)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.TODAY_DEATHS_CASES_STRING,
                NumberUtils.formatDecimalPlaces(countryCoronaModel.todayDeaths),
                Color(0xFFab6ca2)),
          ),
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.PER_ONE_DEATHS_CASES_STRING,
                NumberUtils.formatDecimalPlaces(
                    countryCoronaModel.deathsPerOneMillion),
                Color(0xFFda787f)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.TOTAL_TESTS_STRING,
                NumberUtils.formatDecimalPlaces(countryCoronaModel.tests),
                Color(0xFF765d69)),
          ),
          Expanded(
            flex: 2,
            child: _buildColorCard(
                Constants.PER_ONE_TESTS_CASES_STRING,
                NumberUtils.formatDecimalPlaces(
                    countryCoronaModel.testsPerOneMillion),
                Color(0xFF685d79)),
          ),
        ],
      ),
    ];
  }

  Widget _buildColorCard(String title, String value, Color color) {
    return Card(
      color: color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
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
      ),
    );
  }
}
