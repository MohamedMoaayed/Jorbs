import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Jorbs/Data/ProviderList.dart';
import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProvidersField extends StatefulWidget {
  const ProvidersField({
    Key key,
  }) : super(key: key);

  @override
  _ProvidersFieldState createState() => _ProvidersFieldState();
}

class _ProvidersFieldState extends State<ProvidersField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Provider(s)",
          style: TextStyle(
              fontFamily: 'Gilroy', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          child: SearchableDropdown.multiple(
            items: ProviderList.list,
            selectedItems: SavedFilters.selectedProviders,
            hint: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Select a Provider",
                  style: TextStyle(fontFamily: 'Gilroy')),
            ),
            searchHint: "Select any",
            validator: (selectedItemsForValidator) {
              if (selectedItemsForValidator.length < 1) {
                return (Text(
                  "Select at least select one",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 10,
                      color: Colors.red[400]),
                ));
              }
              return (null);
            },
            onChanged: (value) {
              setState(() {
                SavedFilters.selectedProviders = value;
              });
            },
            closeButton: (selectedItems) {
              return (selectedItems.isNotEmpty
                  ? "Save ${selectedItems.length == 1 ? '"' + ProviderList.list[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                  : "Save without selection");
            },
            isExpanded: true,
          ),
        ),
        Divider(),
      ],
    );
  }
}
