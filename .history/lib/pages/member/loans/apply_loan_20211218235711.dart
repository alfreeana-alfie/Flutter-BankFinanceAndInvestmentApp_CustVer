import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';

class ApplyNewLoan extends StatefulWidget {
  const ApplyNewLoan({Key? key}) : super(key: key);

  @override
  _ApplyNewLoanState createState() => _ApplyNewLoanState();
}

class _ApplyNewLoanState extends State<ApplyNewLoan> {
  final ScrollController _scrollController = ScrollController();

  String? currency, currencyName, planFDR, planFDRName;

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
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.applyLoanTxt, implyLeading: true, context: context),
      bottomSheet: Container(
        color: Styles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: elevatedButton(
          color: Styles.secondaryColor,
          context: context,
          callback: () {
            Map<String, String> body = {
              'loan_Id': '2',
              'loan_product_Id': '1',
              'borrower_Id': '1',
              'first_payment_date': '2021-07-09',
              'release_date': '2021-07-09',
              'currency_Id': '3',
              'applied_amount': '1',
              'total_payable': '2',
              'total_paid': '2',
              'late_payment_penalties': '10',
              'attachment':
                  'loan_files/bQURCY5sVoNOCsGPX0VbXx69iNO7HD6yNZY6lLbk.png',
              'description': 'test-description',
              'remarks': '3',
              'status': '1',
              'approved_date': 'null',
              'approved_user_Id': '2',
              'created_user_Id': '1',
              'branch_Id': '2',
            };

            
          },
          text: Str.applyLoanTxt.toUpperCase(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Styles.primaryWithOpacityColor,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
                              child: Text(Str.depositPlanTxt,
                                  style: Styles.subtitleStyle)),
                          const Gap(20.0),
                          DropDownPlanFDR(
                            plan: planFDR,
                            planName: planFDRName,
                            onChanged: (val) {
                              setState(
                                () {
                                  planFDR = val!.id.toString();
                                  planFDRName = val.name;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
                              child: Text(Str.currencyTxt,
                                  style: Styles.subtitleStyle)),
                          const Gap(20.0),
                          DropDownCurrency(
                            currency: currency,
                            currencyName: currencyName,
                            onChanged: (val) {
                              setState(
                                () {
                                  currency = val!.id.toString();
                                  currencyName = val.name;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(20.0),
                      TextFormField(
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.firstPaymentDateTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.firstPaymentDateTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.appliedAmountTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.appliedAmountTxt,
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    color: Styles.yellowColor,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (val) {},
                        style: Styles.subtitleStyleDark,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.descriptionTxt,
                          labelStyle: Styles.subtitleStyleDark02,
                          hintText: Str.descriptionTxt,
                          hintStyle: Styles.subtitleStyleDark03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (val) {},
                        style: Styles.subtitleStyleDark,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.remarkTxt,
                          labelStyle: Styles.subtitleStyleDark02,
                          hintText: Str.remarkTxt,
                          hintStyle: Styles.subtitleStyleDark03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (val) {},
                              style: Styles.subtitleStyleDark,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: Str.attachmentTxt,
                                labelStyle: Styles.subtitleStyleDark02,
                                hintText: Str.attachmentTxt,
                                hintStyle: Styles.subtitleStyleDark03,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  gapPadding: 0.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: elevatedButton(
                              color: Styles.accentColor,
                              context: context,
                              callback: () {},
                              text: Str.browseTxt,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
