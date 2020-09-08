import 'package:flutter/material.dart';

class ProviderList {
  static List<DropdownMenuItem> list = const [
    DropdownMenuItem(
      child: Text('GitHub'),
      value: 'GitHub',
    ),
    DropdownMenuItem(
      child: Text('Search.gov'),
      value: 'Search.gov',
    ),
    // Here We can add more providers.
  ];
}
