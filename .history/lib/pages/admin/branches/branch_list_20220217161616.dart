import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/widgets/list.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {

  @override
  Widget build(BuildContext context) {
    return CardList(
      type: Type.branch,
      routePath: RouteSTR.createBranchN,
      pageName: Str.currencyList
    );
  }
}
