part of 'main_bloc.dart';

@immutable
abstract class MainEvents {}

class GetPackagesEvent extends MainEvents {
  GetPackagesEvent();
}

class GetBookingsEvent extends MainEvents {
  GetBookingsEvent();
}
