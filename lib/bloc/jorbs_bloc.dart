import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'jorbs_event.dart';
part 'jorbs_state.dart';

class JorbsBloc extends Bloc<JorbsEvent, JorbsState> {
  JorbsBloc() : super(JorbsInitial());

  @override
  Stream<JorbsState> mapEventToState(
    JorbsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
