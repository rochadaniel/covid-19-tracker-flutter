import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class GetTotalCoronaDetailsEvent extends MainEvent {}