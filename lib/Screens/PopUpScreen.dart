import 'dart:ui';

import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:Jorbs/helpers/Locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Jorbs/Widgets/PlacesField.dart';
import 'package:Jorbs/Widgets/PositionField.dart';
import 'package:Jorbs/Widgets/ProviderSelesction.dart';
import 'package:Jorbs/bloc/jorbs_bloc.dart';

// This is the filter screen which will be first implemented as RawMaterialButton in the main screen.
// SavedFilters savedFilters = SavedFilters();
var savedFilters = locator<SavedFilters>();
// For saving texts.
final myControllerPosition = TextEditingController();
final myControllerLocation = TextEditingController();

class PopUpScreen extends StatefulWidget {
  PopUpScreen({
    Key key,
  }) : super(key: key);

  @override
  _PopUpScreenState createState() => _PopUpScreenState();
}

class _PopUpScreenState extends State<PopUpScreen> {
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.

    myControllerPosition.dispose();
    myControllerLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
              'Set Filters',
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

// Here is the PopUp filter screen's coding part.
  Future buildShowDialog(BuildContext context) {
    return showDialog(
        // barrierDismissible: false,
        // barrierColor: Colors.blueGrey.with,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _form,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Dialog(
                backgroundColor: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
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
                          // Putting all the widgets togather.
                          PositionField(),
                          ProvidersField(),
                          PlacesField(),
                          SavedButtom(form: _form),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// This is the buttom in the Popup Screen for saving the inputs and trigger BlocEvent.
class SavedButtom extends StatelessWidget {
  const SavedButtom({
    Key key,
    @required GlobalKey<FormState> form,
  })  : _form = form,
        super(key: key);

  final GlobalKey<FormState> _form;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 5,
        onPressed: () {
          if (locator<SavedFilters>().selectedProviders.isNotEmpty) {
            _form.currentState.save();
            final JorbsBloc counterBloc = BlocProvider.of<JorbsBloc>(context);

            print(savedFilters.position);
            print(savedFilters.selectedProviders);

            Navigator.of(context).pop();
            submitBloc(context);
          }
        },
        child: Text(
          'Save',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        color: Theme.of(context).accentColor,
      ),
    );
  }

// A function for submit Bloc trigger
  void submitBloc(BuildContext context) {
    final jorbsBloc = context.bloc<JorbsBloc>();
    jorbsBloc.add(FilterGotSaved());
    return null;
  }
}
