import 'dart:async';
import 'dart:convert';

import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:Jorbs/Data/models/Job.dart';
import 'package:Jorbs/helpers/keys.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'jorbs_event.dart';
part 'jorbs_state.dart';

class JorbsBloc extends Bloc<JorbsEvent, JorbsState> {
  JorbsBloc() : super(JorbsInitial());
  List<Job> filteredJobs = [];

  Future<void> fetchFilteredJobsFromGithub() async {
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
          filteredJobs.add(Job(
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
    if (SavedFilters.selectedProviders.contains(1)) {
      try {
        final response = await http.get(
            'https://data.usajobs.gov/api/search?Keyword=${SavedFilters.position}&&LocationName=${SavedFilters.location}',
            headers: Headers.headers);
        var responseJson = json.decode(response.body);
        responseJson.removeWhere((key, value) => key != "SearchResult");

        var _listOfMapsOfJobs =
            responseJson['SearchResult']['SearchResultItems'];

        for (var index in _listOfMapsOfJobs) {
          filteredJobs.add(Job(
            position: index['MatchedObjectDescriptor']["PositionTitle"],
            companyName: index['MatchedObjectDescriptor']["OrganizationName"],
            date: index['MatchedObjectDescriptor']["PositionStartDate"],
            location: index['MatchedObjectDescriptor']
                ["PositionLocationDisplay"],
            jobUrl: index['MatchedObjectDescriptor']["PositionURI"],
            logoUrl:
                'https://fcw.com/-/media/GIG/FCWNow/Logos/USAJobs_logo.jpg',
            provider: 'US',
          ));
        }
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
      if (event is SavedFilter) {
        await fetchFilteredJobsFromGithub();
        print("HERE DONE called ");
        if (filteredJobs.isNotEmpty) yield JobsLoaded(filteredJobs);
        filteredJobs = [];
      }
    } catch (error) {
      yield JorbsError("Couldn't fetch Jobs. Is the device online?");
      throw (error);
    }
  }
}
