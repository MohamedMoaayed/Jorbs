import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const String kApiPlaces = "AIzaSyAJYx9g9_MHvZ8Hy0W3vRQ1foYpjVM-j94";

class PlacesSearch extends StatefulWidget {
  PlacesSearch({Key key}) : super(key: key);

  @override
  _PlacesSearchState createState() => _PlacesSearchState();
}

class _PlacesSearchState extends State<PlacesSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              ),
              hintText: 'Select a Location',
              hintStyle: TextStyle(fontFamily: 'Gilroy')),
          onTap: () async {
            Prediction p = await PlacesAutocomplete.show(
              context: context,
              apiKey: kApiPlaces,
              onError: (err) => print(err.errorMessage),
              mode: Mode.overlay,
              language: "en",
              components: [Component(Component.country, "jo")],
            );
          }),
    );
  }
}
