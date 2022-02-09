import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/fdr_plan_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateFdrPackage extends StatefulWidget {
  const CreateFdrPackage({Key? key}) : super(key: key);

  @override
  _CreateFdrPackageState createState() => _CreateFdrPackageState();
}

class _CreateFdrPackageState extends State<CreateFdrPackage> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  String? name,
      minAmt,
      maxAmt,
      interestRate,
      duration,
      durationType,
      description;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createFdrPlan, implyLeading: true, context: context),
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
                    onSaved: (val) => name = val,
                    hintText: Str.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => minAmt = val,
                    hintText: Str.minAmt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => maxAmt = val,
                    hintText: Str.maxAmt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => interestRate = val,
                    hintText: Str.interestRate,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => duration = val,
                    hintText: Str.duration,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => durationType = val,
                    hintText: Str.durationType,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => description = val,
                    hintText: Str.description,
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
                        Map<String, String> body = {
                          Field.name: name!,
                          Field.minimumAmount: minAmt ?? Field.emptyString,
                          Field.maximumAmount: maxAmt ?? Field.emptyString,
                          Field.interestRate:
                              interestRate ?? Field.emptyString,
                          Field.duration: duration ?? Field.emptyString,
                          Field.durationType:
                              durationType ?? Field.emptyString,
                          Field.description: description ?? Field.emptyString,
                          Field.status: Status.pending.toString(),
                        };
                        FdrPlanMethods.add(context, body);
                      },
                      text: Str.submit,
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
