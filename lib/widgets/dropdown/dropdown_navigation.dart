import 'dart:convert';

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
      print(Status.failedTxt);
    }
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: Styles.greyColor,
          icon: const RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: Styles.textColor,
              )),
          hint: widget.navigationName == null
              ? Text(Str.planTxt, style: Styles.primaryTitle)
              : Text(
                  widget.navigationName!,
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: navigationListNew.map(
            (val) {
              return DropdownMenuItem<Navigation>(
                value: val,
                child: Text(val.name ?? '-'),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
