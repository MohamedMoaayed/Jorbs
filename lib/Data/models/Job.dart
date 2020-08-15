import 'package:flutter/foundation.dart';

class Job {
  final String provider;
  final String logoUrl;
  final String location;
  final String position;
  final String companyName;
  final String jobUrl;
  final String date;

  Job({
    @required this.provider,
    @required this.companyName,
    this.logoUrl,
    @required this.jobUrl,
    @required this.location,
    @required this.position,
    @required this.date,
  });
}
