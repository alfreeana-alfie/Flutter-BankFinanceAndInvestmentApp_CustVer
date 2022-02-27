import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
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
    final response = await http.get(API.listofFdrPlans, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = PlanFDR.fromMap(plan);
        
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
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<PlanFDR>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectPlanFdr,
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

  Future<List<PlanFDR>> getData(filter) async {
    return planListNew;
  }
}
