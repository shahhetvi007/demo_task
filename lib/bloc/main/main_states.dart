part of 'main_bloc.dart';

abstract class MainStates extends BaseStates {
  const MainStates();
}

class MainInitialState extends MainStates {}

class GetPackagesResponseState extends MainStates {
  final PackagesList response;

  GetPackagesResponseState(this.response);
}

class GetBookingsResponseState extends MainStates {
  final CurrentBookings response;

  GetBookingsResponseState(this.response);
}
