import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/membership.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownMembershipPlan extends StatefulWidget {
  const DropDownMembershipPlan(
      {Key? key, this.membershipPlan, this.membershipName, this.membershipFee, required this.onChanged})
      : super(key: key);

  final String? membershipPlan, membershipName, membershipFee;
  final void Function(Membership?) onChanged;

  @override
  _DropDownMembershipPlanState createState() => _DropDownMembershipPlanState();
}

class _DropDownMembershipPlanState extends State<DropDownMembershipPlan> {
  List<Membership> planListNew = [];

  void getView() async {
    final response = await http.get(API.membershipPlanList, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = Membership.fromMap(plan);
        
        setState(() {
          planListNew.add(plans);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getView();
    super.initState();
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
          hint: widget.membershipName == null
              ? Text(Str.membershipPlan, style: Styles.primaryTitle)
              : Text(
                  widget.membershipName!,
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: planListNew.map(
            (val) {
              return DropdownMenuItem<Membership>(
                value: val,
                child: Text(val.planName ?? '-'),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  _dropDownSearch() {
    return DropdownSearch<Membership>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.planName ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectMembership,
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

  Future<List<Membership>> getData(filter) async {
    return planListNew;
  }
}
