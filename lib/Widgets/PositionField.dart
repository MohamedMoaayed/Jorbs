import 'package:flutter/material.dart';
import 'package:Jorbs/Data/SaveFilters.dart';

// This widget for building the Position search text field in the popup screen

class PositionField extends StatelessWidget {
  const PositionField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Position",
          style: TextStyle(
              fontFamily: 'Gilroy', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12,
        ),
        TextFormField(
          onSaved: (val) => SavedFilters.position = val,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.amber,
                style: BorderStyle.solid,
              ),
            ),
            hintText: 'What Job do you looking for ?',
            hintStyle: TextStyle(fontFamily: 'Gilroy'),
          ),
        ),
        Divider(),
      ],
    );
  }
}
