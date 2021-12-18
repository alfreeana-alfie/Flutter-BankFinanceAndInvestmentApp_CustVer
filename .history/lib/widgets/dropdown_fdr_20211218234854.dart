import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
import 'package:flutter_banking_app/models/fdrs.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownPlanFDR extends StatefulWidget {
  const DropDownPlanFDR(
      {Key? key, this.plan, this.planName, required this.onChanged})
      : super(key: key);

  final String? plan, planName;
  final void Function(PlanFDR?) onChanged;

  @override
  _DropDownPlanFDRState createState() => _DropDownPlanFDRState();
}

class _DropDownPlanFDRState extends State<DropDownPlanFDR> {
  List<PlanFDR> planListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listofFdrPlans, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = PlanFDR.fromMap(plan);
        print(plan);
        // setState(() {
        //   planListNew.add(plans);
        // });
      }
    } else {
      print(Status.failedTxt);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Styles.primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Styles.primaryColor,
            hint: widget.planName == null
                ? Text(Str.planTxt, style: Styles.subtitleStyle02)
                : Text(
                    widget.planName!,
                    style: Styles.subtitleStyle,
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: Styles.subtitleStyle02,
            items: planListNew.map(
              (val) {
                return DropdownMenuItem<PlanFDR>(
                  value: val,
                  child: Text(val.name ?? '-'),
                );
              },
            ).toList(),
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
