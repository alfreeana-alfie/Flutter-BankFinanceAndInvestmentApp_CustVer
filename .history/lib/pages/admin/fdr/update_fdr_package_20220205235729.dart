import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/fdr_plan_methods.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateFdrPackage extends StatefulWidget {
  const UpdateFdrPackage({Key? key, required this.fdrPlan}) : super(key: key);

  final PlanFDR fdrPlan;

  @override
  _UpdateFdrPackageState createState() => _UpdateFdrPackageState();
}

class _UpdateFdrPackageState extends State<UpdateFdrPackage> {
  final ScrollController _scrollController = ScrollController();
  int? status;

  String? name,
      minAmt,
      maxAmt,
      interestRate,
      duration,
      durationType,
      description;

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // setState(() {
    //   name = widget.fdrPlan.name;
    //   minAmt = widget.fdrPlan.minimumAmount;
    //   maxAmt = widget.fdrPlan.maximumAmount;
    //   interestRate = widget.fdrPlan.interestRate;
    //   duration = widget.fdrPlan.duration.toString();
    //   durationType = widget.fdrPlan.durationType;
    //   description = widget.fdrPlan.description;
    // });
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.updateFdrPlanTxt, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Styles.cardColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.name,
                    onSaved: (val) => name = val,
                    hintText: Str.nameTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.minimumAmount,
                    onSaved: (val) => minAmt = val,
                    hintText: Str.minAmtTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.maximumAmount,
                    onSaved: (val) => maxAmt = val,
                    hintText: Str.maxAmtTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.interestRate,
                    onSaved: (val) => interestRate = val,
                    hintText: Str.interestRateTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.duration.toString(),
                    onSaved: (val) => duration = val,
                    hintText: Str.durationTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.durationType,
                    onSaved: (val) => durationType = val,
                    hintText: Str.durationTypeTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.fdrPlan.description,
                    onSaved: (val) => description = val,
                    hintText: Str.descriptionTxt,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.statusTxt, style: Styles.primaryTitle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(
                          '*',
                          style: TextStyle(color: Styles.dangerColor),
                        ),
                      ),
                    ],
                  ),
                  ToggleSwitch(
                    initialLabelIndex: int.parse(widget.fdrPlan.status!),
                    minWidth: 120,
                    cornerRadius: 7.0,
                    activeBgColors: const [
                      [Styles.dangerColor],
                      [Styles.successColor]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.black12.withOpacity(0.05),
                    inactiveFgColor: Styles.textColor,
                    totalSwitches: 2,
                    labels: Field.statusList,
                    onToggle: (index) {
                      // print('switched to: $index');
                      status = index;
                    },
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        status ??= int.parse(widget.fdrPlan.status!);
                        Map<String, String> body = {
                          Field.name: name ?? widget.fdrPlan.name ?? Field.emptyString,
                          Field.minimumAmount: minAmt ?? widget.fdrPlan.minimumAmount ?? Field.emptyString,
                          Field.maximumAmount: maxAmt ?? widget.fdrPlan.maximumAmount ?? Field.emptyString,
                          Field.interestRate:
                              interestRate ?? widget.fdrPlan.interestRate ?? Field.emptyString,
                          Field.duration: duration ?? widget.fdrPlan.duration.toString(),
                          Field.durationType:
                              durationType ?? widget.fdrPlan.durationType ?? Field.emptyString,
                          Field.description: description ?? widget.fdrPlan.description ?? Field.emptyString,
                          Field.status: status.toString(),
                        };
                        FdrPlanMethods.edit(context, body, widget.fdrPlan.id.toString());
                      },
                      text: Str.submitTxt,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
