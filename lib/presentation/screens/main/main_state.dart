import 'package:covid19app/domain/model/total_corona_details_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState {}

class InitialMainState extends MainState {}

class LoadingMainState extends MainState {}

class SuccessMainState extends MainState {
  final TotalCoronaDetailsModel totalCoronaDetailsModel;

  SuccessMainState(this.totalCoronaDetailsModel);
}

class ErrorMainState extends MainState {}
