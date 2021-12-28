import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/loan_product_methods.dart';
import 'package:flutter_banking_app/methods/admin/other_bank_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateLoanProduct extends StatefulWidget {
  const CreateLoanProduct({Key? key}) : super(key: key);

  @override
  _CreateLoanProductState createState() => _CreateLoanProductState();
}

class _CreateLoanProductState extends State<CreateLoanProduct> {
  final ScrollController _scrollController = ScrollController();

  String? name,
      minAmt,
      maxAmt,
      description,
      interestRate,
      interestType,
      term,
      termPeriod;

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
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.createLoanProductTxt,
            implyLeading: true,
            context: context),
        // bottomSheet: Container(
        //   color: Styles.primaryColor,
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        //   child: elevatedButton(
        //     color: Styles.secondaryColor,
        //     context: context,
        //     callback: () {
        //       Map<String, String> body = {
        //         Field.name: name!,
        //         Field.minimumAmount: minAmt ?? Field.emptyString,
        //         Field.maximumAmount: maxAmt ?? Field.emptyString,
        //         Field.description: description ?? Field.emptyString,
        //         Field.interestRate: interestRate ?? Field.emptyString,
        //         Field.interestType: interestType ?? Field.emptyString,
        //         Field.term: term ?? Field.emptyString,
        //         Field.termPeriod: termPeriod ?? Field.emptyString,
        //         Field.status: Status.pending.toString(),
        //       };

        //       OtherBankMethods.add(context, body);
        //     },
        //     text: Str.createCurrencyTxt.toUpperCase(),
        //   ),
        // ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.accentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          onChanged: (val) {
                            name = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.nameTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.nameTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            minAmt = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.minAmtTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.minAmtTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            maxAmt = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.maxAmtTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.maxAmtTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            description = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.descriptionTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.descriptionTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            interestRate = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.interestRateTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.interestRateTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            interestType = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.interestTypeTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.interestTypeTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            term = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.termTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.termTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            termPeriod = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.termPeriodTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.termPeriodTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Styles.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    Field.name: name!,
                    Field.minimumAmount: minAmt ?? Field.emptyString,
                    Field.maximumAmount: maxAmt ?? Field.emptyString,
                    Field.description: description ?? Field.emptyString,
                    Field.interestRate: interestRate ?? Field.emptyString,
                    Field.interestType: interestType ?? Field.emptyString,
                    Field.term: term ?? Field.emptyString,
                    Field.termPeriod: termPeriod ?? Field.emptyString,
                    Field.status: Status.pending.toString(),
                  };

                  LoanProductMethods.add(context, body);
                },
                text: Str.submitTxt.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
