import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Jorbs/Data/models/Job.dart';
import 'package:http/http.dart' as http;

import 'package:Jorbs/bloc/jorbs_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// In this widget the cards will get build

//A default image for github jobs, if there is no image
const String _imageUrlGithub =
    "https://lawyerlearnsblockchain.com/wp-content/uploads/2019/01/GitHub-brave-hed-796x418.jpg";

// The list of fetched Jobs
List<Job> _availableJobs = [];

// For launching links
_launchURL(String jobUrl) async {
  final url = jobUrl;
  if (await canLaunch(url)) {
    await launch(
      url,
    );
  } else {
    throw 'Could not launch $url';
  }
}

bool _checkIfThereAreFilteredJobs;
// Fetching The recent Jobs in Github and show it in the main screen when the app starts.
Future<void> fetchRecentJobs() async {
  var url = 'https://jobs.github.com/positions.json';

  try {
    if (_checkIfThereAreFilteredJobs != true) {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }

      for (var extractedData in extractedData) {
        _availableJobs.add(Job(
          companyName: extractedData['company'],
          date: extractedData['created_at'],
          jobUrl: extractedData['url'],
          location: extractedData['location'],
          logoUrl: extractedData['company_logo'],
          position: extractedData['title'],
          provider: 'github',
        ));
      }
    }
  } catch (error) {
    throw (error);
  }
}

class JobCards extends StatefulWidget {
  const JobCards({Key key}) : super(key: key);

  @override
  _JobCardsState createState() => _JobCardsState();
}

class _JobCardsState extends State<JobCards> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JorbsBloc, JorbsState>(listener: (context, state) {
      // Listen to an error if occurred
      if (state is JorbsError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    }, builder: (context, state) {
      // return widget here based on Bloc's state
      if (state is JorbsInitial) {
        return buildCards();
      } else if (state is JobsLoaded) {
        //Pass the filtered jobs from Bloc
        _checkIfThereAreFilteredJobs = true;
        _availableJobs = state.filteredJobs;

        return buildCards();
      } else {
        return buildCards();
      }
    });
  }
}

//Building the cards using Listview and FutureBuilder
Widget buildCards() {
  return FutureBuilder(
      future: fetchRecentJobs(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => fetchRecentJobs(),
                  child: ListView.builder(
                    itemCount: _availableJobs.length,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 220,
                      width: double.maxFinite,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(3),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    _availableJobs[index].logoUrl != null
                                        ? _availableJobs[index].logoUrl
                                        : _imageUrlGithub,
                                    height: double.infinity,
                                    width: 110,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        width: 230,
                                        child: Text(
                                          _availableJobs[index].position,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        width: 230,
                                        child: Text(
                                          _availableJobs[index].companyName,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.date_range),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            width: 200,
                                            child: Text(
                                              _availableJobs[index].date,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 23,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            width: 100,
                                            child: Text(
                                              _availableJobs[index].location,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: _availableJobs[index]
                                                                  .location ==
                                                              "Remote" ||
                                                          _availableJobs[index]
                                                                  .location ==
                                                              "REMOTE"
                                                      ? Theme.of(context)
                                                          .accentColor
                                                      : Colors.black),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            child: RaisedButton(
                                              child: Text(
                                                "Apply",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () => _launchURL(
                                                  _availableJobs[index].jobUrl),
                                              elevation: 1,
                                              color: Colors.green[300],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  )));
}
