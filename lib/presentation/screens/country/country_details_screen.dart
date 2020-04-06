import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_details.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryCoronaModel countryCoronaModel;

  CountryDetailsScreen({Key key, @required this.countryCoronaModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(this.countryCoronaModel.country),
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
            ],
          ),
        ),
      ),
    );
  }
}
