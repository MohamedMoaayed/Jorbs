import 'package:flutter/cupertino.dart';

class Job {
  final String provider;
  final String logoUrl;
  final String location;
  final String position;
  final String companyName;
  final String jobUrl;
  final DateTime date;

  Job({
    @required this.provider,
    @required this.companyName,
    @required this.logoUrl,
    @required this.jobUrl,
    @required this.location,
    @required this.position,
    @required this.date,
  });
}
