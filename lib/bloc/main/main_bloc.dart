import 'package:demo_task/bloc/base/base_bloc.dart';
import 'package:demo_task/models/current_bookings.dart';
import 'package:demo_task/models/packages.dart';
import 'package:demo_task/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_events.dart';
part 'main_states.dart';

class MainBloc extends Bloc<MainEvents, MainStates> {
  Repository repository = Repository.getInstance();
  BaseBloc baseBloc;

  MainBloc(this.baseBloc) : super(MainInitialState());

  @override
  Stream<MainStates> mapEventToState(MainEvents event) async* {
    if (event is GetPackagesEvent) {
      yield* _mapGetPackagesEventToState(event);
    } else if (event is GetBookingsEvent) {
      yield* _mapGetBookingsEventToState(event);
    }
  }

  Stream<GetPackagesResponseState> _mapGetPackagesEventToState(
      GetPackagesEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      PackagesList response = await repository.getPackagesList();
      print("in bloc method");

      yield GetPackagesResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error as Exception));
      yield GetPackagesResponseState(PackagesList(
          status: '', message: error.toString(), code: '', response: []));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<GetBookingsResponseState> _mapGetBookingsEventToState(
      GetBookingsEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CurrentBookings response = await repository.getCurrentBookings();

      yield GetBookingsResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error as Exception));
      yield GetBookingsResponseState(CurrentBookings(
          status: '', message: error.toString(), code: '', response: []));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
