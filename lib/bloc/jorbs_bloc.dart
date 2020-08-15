import 'dart:async';
import 'dart:convert';

import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:Jorbs/Data/models/Job.dart';
import 'package:Jorbs/helpers/Helpers.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'jorbs_event.dart';
part 'jorbs_state.dart';

/*
    Here will all the magic happands.
    In this file we generate all the fetch all filtered Jobs
    and submit them to the JobCards widget.
    When the pressed event trigger the bloc will do all that work.
    */
class JorbsBloc extends Bloc<JorbsEvent, JorbsState> {
  JorbsBloc() : super(JorbsInitial());

  // The List of filtered searched for Jobs
  List<Job> _filteredJobs = [];

  Future<void> fetchFilteredJobsFromProviders() async {
    // The Zero Index is Github and one index for the USAJOBS, as we assigned that in ProviderList.dart
    if (SavedFilters.selectedProviders.contains(0)) {
      var url =
          'https://jobs.github.com/positions.json?search=${SavedFilters.position}&location=${SavedFilters.location}';
      try {
        final response = await http.get(url);
        final extractedData = json.decode(response.body);
        if (extractedData == null) {
          print('There is no jobs on that search');
        }

        for (var extractedData in extractedData) {
          _filteredJobs.add(Job(
            companyName: extractedData['company'],
            date: extractedData['created_at'],
            jobUrl: extractedData['url'],
            location: extractedData['location'],
            logoUrl: extractedData['company_logo'],
            position: extractedData['title'],
            provider: 'github',
          ));
        }
      } catch (error) {
        throw (error);
      }
    }
    // If the user (only or also) selected  USAJOBS
    if (SavedFilters.selectedProviders.contains(1)) {
      try {
        final response = await http.get(
            'https://data.usajobs.gov/api/search?Keyword=${SavedFilters.position}&&LocationName=${SavedFilters.location}',
            headers: Headers.headers);
        var responseJson = json.decode(response.body);
        // Function for triming the nested JSON we received.
        responseJson.removeWhere((key, value) => key != "SearchResult");

        // Making a list for only Jobs info.
        var _listOfMapsOfJobs =
            responseJson['SearchResult']['SearchResultItems'];

        for (var index in _listOfMapsOfJobs) {
          _filteredJobs.add(Job(
            position: index['MatchedObjectDescriptor']["PositionTitle"],
            companyName: index['MatchedObjectDescriptor']["OrganizationName"],
            date: index['MatchedObjectDescriptor']["PositionStartDate"],
            location: index['MatchedObjectDescriptor']
                ["PositionLocationDisplay"],
            jobUrl: index['MatchedObjectDescriptor']["PositionURI"],
            logoUrl:
                'https://fcw.com/-/media/GIG/FCWNow/Logos/USAJobs_logo.jpg', // This's a deafult image because USAJOBS don't Provide Logos.
            provider: 'US',
          ));
        }
        /*
        Here we can add more Providers and fetch their Apis data 
        */
      } catch (error) {
        throw (error);
      }
    }
  }

  @override
  Stream<JorbsState> mapEventToState(
    JorbsEvent event,
  ) async* {
    try {
      if (event is FilterGotSaved) {
        await fetchFilteredJobsFromProviders();

        // If we received Jobs form Providers we submit them to Cards Widget otherwise we don't
        if (_filteredJobs.isNotEmpty) yield JobsLoaded(_filteredJobs);
        _filteredJobs = [];
      }
    } catch (error) {
      yield JorbsError("Couldn't fetch Jobs. Is the device online?");
      throw (error);
    }
  }
}
