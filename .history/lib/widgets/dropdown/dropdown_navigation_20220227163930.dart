import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/navigation.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDowNavigation extends StatefulWidget {
  const DropDowNavigation(
      {Key? key, this.navigation, this.navigationName, required this.onChanged})
      : super(key: key);

  final String? navigation, navigationName;
  final void Function(Navigation?) onChanged;

  @override
  _DropDowNavigationState createState() => _DropDowNavigationState();
}

class _DropDowNavigationState extends State<DropDowNavigation> {
  List<Navigation> navigationListNew = [];

  void read() async {
    final response = await http.get(AdminAPI.listOfNavigation, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final navigations = Navigation.fromMap(data);
        
        setState(() {
          navigationListNew.add(navigations);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }


  _dropDownSearch() {
    return DropdownSearch<Navigation>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectUser,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Navigation>> getData(filter) async {
    return navigationListNew;
  }
}
