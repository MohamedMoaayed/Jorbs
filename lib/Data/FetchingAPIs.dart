import 'dart:async';
import 'dart:convert';

import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:Jorbs/Data/models/Job.dart';
import 'package:Jorbs/helpers/Helpers.dart';

import 'package:http/http.dart' as http;

class FetchingApis {
// The List of filtered searched for Jobs
  static List<Job> filteredJobs = [];

  static Future<void> fetchFilteredJobsFromProviders() async {
    // The Zero Index is Github and one index for the USAJOBS, as we assigned that in ProviderList.dart
    if (SavedFilters.selectedProviders.contains(0)) {
      var url =
          'https://jobs.github.com/positions.json?search=${SavedFilters.position}&location=${SavedFilters.location}';
      try {
        var response = await http.get(url);
        var _responseJson = json.decode(response.body);
        if (_responseJson == null) {
          print('There is no jobs on that search');
        }

        for (var entry in _responseJson) {
          filteredJobs.add(Job(
            companyName: entry['company'],
            date: entry['created_at'],
            jobUrl: entry['url'],
            location: entry['location'],
            logoUrl: entry['company_logo'],
            position: entry['title'],
            provider: 'github',
          ));
        }

        _responseJson = [];
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
        var _responseJson = json.decode(response.body);

        // Function for triming the nested JSON we received.
        _responseJson.removeWhere((key, value) => key != "SearchResult");

        // Making a list for only Jobs info.
        var _listOfMapsOfJobs =
            _responseJson['SearchResult']['SearchResultItems'];

        for (var entry in _listOfMapsOfJobs) {
          filteredJobs.add(Job(
            position: entry['MatchedObjectDescriptor']["PositionTitle"],
            companyName: entry['MatchedObjectDescriptor']["OrganizationName"],
            date: entry['MatchedObjectDescriptor']["PositionStartDate"],
            location: entry['MatchedObjectDescriptor']
                ["PositionLocationDisplay"],
            jobUrl: entry['MatchedObjectDescriptor']["PositionURI"],
            logoUrl:
                'https://fcw.com/-/media/GIG/FCWNow/Logos/USAJobs_logo.jpg', // This's a deafult image because USAJOBS don't Provide Logos.
            provider: 'US',
          ));
        }
        _responseJson = [];
        _listOfMapsOfJobs = [];
        /*
        Here we can add more Providers and fetch their Apis data 
        */
      } catch (error) {
        throw (error);
      }
    }
  }
}
