import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_events.dart';
part 'base_states.dart';

class BaseBloc extends Bloc<BaseEvents, BaseStates> {
  BaseBloc() : super(CommonInitialState());

  @override
  Stream<BaseStates> mapEventToState(BaseEvents event) async* {}
}
