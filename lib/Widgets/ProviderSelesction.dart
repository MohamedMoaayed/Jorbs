import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jorbs/Data/ProviderList.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProviderSelection extends StatefulWidget {
  const ProviderSelection({Key key}) : super(key: key);

  @override
  _ProviderSelectionState createState() => _ProviderSelectionState();
}

class _ProviderSelectionState extends State<ProviderSelection> {
  List<int> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: SearchableDropdown.multiple(
          items: ProviderList.list,
          selectedItems: selectedItems,
          hint: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Select a Provider",
                style: TextStyle(fontFamily: 'Gilroy')),
          ),
          searchHint: "Select any",
          validator: (selectedItemsForValidator) {
            if (selectedItemsForValidator.length != 1) {
              return (Text(
                "Must select one",
                style: TextStyle(
                    fontFamily: 'Gilroy', fontSize: 10, color: Colors.red[400]),
              ));
            }
            return (null);
          },
          onChanged: (value) {
            setState(() {
              selectedItems = value;
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
    );
  }
}
