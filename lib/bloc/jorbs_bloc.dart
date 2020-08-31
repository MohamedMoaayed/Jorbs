import 'dart:async';
import 'package:Jorbs/Data/models/Job.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Data/FetchingAPIs.dart';

part 'jorbs_event.dart';
part 'jorbs_state.dart';

/*
    In this file we will call the FetchingAPIs fetchFilteredJobsFromProviders function to create filtered jobs 
    and submit them to the JobCards widget.
    When the pressed event trigger the bloc will do all that work.
    */
class JorbsBloc extends Bloc<JorbsEvent, JorbsState> {
  JorbsBloc() : super(JorbsInitial());

  @override
  Stream<JorbsState> mapEventToState(
    JorbsEvent event,
  ) async* {
    try {
      if (event is FilterGotSaved) {
        yield JobsLoading();

        await FetchingApis.fetchFilteredJobsFromProviders();
        // If we received Jobs form Providers we submit them to Cards Widget otherwise we don't
        if (FetchingApis.filteredJobs.isNotEmpty)
          yield JobsLoaded(FetchingApis.filteredJobs);
        FetchingApis.filteredJobs = [];
      }
    } catch (error) {
      yield JorbsError("Couldn't fetch Jobs. Is the device online?");
      throw (error);
    }
  }
}
