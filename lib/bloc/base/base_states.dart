part of 'base_bloc.dart';

abstract class BaseStates {
  const BaseStates();
}

class ApiCallFailureState extends BaseStates {
  final Exception exception;
  ApiCallFailureState(this.exception);
}

class ShowProgressIndicatorState extends BaseStates {
  bool showProgress;
  bool isTabbar;

  ShowProgressIndicatorState(this.showProgress, {this.isTabbar = false});
}

class CommonInitialState extends BaseStates {}
