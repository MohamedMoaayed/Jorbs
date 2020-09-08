import 'package:Jorbs/helpers/Helpers.dart';
import 'package:Jorbs/helpers/Locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:Jorbs/Data/SaveFilters.dart';
import '../Screens/PopUpScreen.dart';

//This widget for building the autoComplete Google Api places Search
// SavedFilters savedFilters = SavedFilters();

class PlacesField extends StatelessWidget {
  const PlacesField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Location',
          style: TextStyle(
              fontFamily: 'Gilroy', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          child: TextFormField(
              onSaved: (val) => locator<SavedFilters>().setlocation(val),
              controller: myControllerLocation,
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
                  apiKey: Keys.keyForApiPlaces,
                  onError: (err) => print(err.errorMessage),
                  mode: Mode.overlay,
                  language: 'en',
                  components: [Component(Component.country, 'jo')],
                );
              }),
        ),
        Divider(),
      ],
    );
  }
}
