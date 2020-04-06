import 'package:covid19app/domain/model/country_corona_model.dart';
import 'package:covid19app/presentation/custom_widgets/card_view_graph_stats.dart';
import 'package:covid19app/presentation/custom_widgets/grouped_card_view_details.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.foregroundColor,
      child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        if (state is InitialMainState) {
          return Text("");
        } else if (state is SuccessMainState) {
          return _showHomeView(state.totalCoronaDetailsModel.savedCountry);
        } else if (state is LoadingMainState) {
          return _showLoadingView();
        } else {
          return _showErrorView();
        }
      }),
    );
  }

  Widget _showLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _showErrorView() {
    return Text(Constants.DEFAULT_ERROR_STRING);
  }

  Widget _showHomeView(CountryCoronaModel countryCoronaModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CardViewGraphStats(countryCoronaModel: countryCoronaModel),
            GroupedCardViewDetails(
              countryCoronaModel: countryCoronaModel,
              isComplete: false,
            ),
          ],
        ),
      ),
    );
  }
}
