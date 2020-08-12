import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jorbs/Widgets/Places.dart';
import 'package:jorbs/Widgets/ProviderSelesction.dart';

class PopUpScreen extends StatelessWidget {
  const PopUpScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 00,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      fillColor: Theme.of(context).primaryColor,
      splashColor: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.settings,
              color: Colors.black,
              size: 32,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Set Filters",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onPressed: () => buildShowDialog(context),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        // barrierDismissible: false,
        // barrierColor: Colors.blueGrey.with,
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Dialog(
              backgroundColor: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 500,
                width: 700,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Position",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
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
                        Text(
                          "Provider(s)",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ProviderSelection(),
                        Divider(),
                        Text(
                          "Location",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        PlacesSearch(),
                        Divider(),
                        SizedBox(
                          width: 300.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 0,
                            onPressed: () {},
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
