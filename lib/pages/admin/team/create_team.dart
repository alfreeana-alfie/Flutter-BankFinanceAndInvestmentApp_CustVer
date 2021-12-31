import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/other_bank_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final ScrollController _scrollController = ScrollController();

  String? name,
      swiftCode,
      bankCountry,
      bankCurrency,
      minTransferAmt,
      maxTransferAmt,
      fixedCharge,
      chargeInPercentage,
      descriptions;

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
            title: Str.createCurrencyTxt, implyLeading: true, context: context),
        // bottomSheet: Container(
        //   color: Styles.primaryColor,
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        //   child: elevatedButton(
        //     color: Styles.secondaryColor,
        //     context: context,
        //     callback: () {
        //       Map<String, String> body = {
        //         Field.name: name!,
        //         Field.swiftCode: swiftCode ?? Field.emptyAmount,
        //         Field.bankCountry: bankCountry ?? Field.emptyString,
        //         Field.bankCurrency: bankCurrency ?? Field.emptyAmount,
        //         Field.minTransferAmt: minTransferAmt ?? Field.emptyAmount,
        //         Field.maxTransferAmt: maxTransferAmt ?? Field.emptyAmount,
        //         Field.fixedCharge: fixedCharge ?? Field.emptyAmount,
        //         Field.chargeInPercentage:
        //             chargeInPercentage ?? Field.emptyAmount,
        //         Field.descriptions: descriptions ?? Field.emptyString,
        //         Field.status: Status.pending.toString()
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
                            swiftCode = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.swiftCodeTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.swiftCodeTxt,
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
                            bankCountry = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.bankCountryTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.bankCountryTxt,
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
                            bankCurrency = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.bankCurrencyTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.bankCurrencyTxt,
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
                            minTransferAmt = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.minTransferAmtTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.minTransferAmtTxt,
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
                            maxTransferAmt = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.maxTransferAmtTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.maxTransferAmtTxt,
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
                            fixedCharge = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.fixedChargeTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.fixedChargeTxt,
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
                            chargeInPercentage = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.chargeInPercentageTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.chargeInPercentageTxt,
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
                            descriptions = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.descriptionsTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.descriptionsTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        Container(
                          // color: Styles.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 40),
                          child: elevatedButton(
                            color: Styles.secondaryColor,
                            context: context,
                            callback: () {
                              Map<String, String> body = {
                                Field.name: name!,
                                Field.swiftCode: swiftCode ?? Field.emptyAmount,
                                Field.bankCountry:
                                    bankCountry ?? Field.emptyString,
                                Field.bankCurrency:
                                    bankCurrency ?? Field.emptyAmount,
                                Field.minTransferAmt:
                                    minTransferAmt ?? Field.emptyAmount,
                                Field.maxTransferAmt:
                                    maxTransferAmt ?? Field.emptyAmount,
                                Field.fixedCharge:
                                    fixedCharge ?? Field.emptyAmount,
                                Field.chargeInPercentage:
                                    chargeInPercentage ?? Field.emptyAmount,
                                Field.descriptions:
                                    descriptions ?? Field.emptyString,
                                Field.status: Status.pending.toString()
                              };

                              OtherBankMethods.add(context, body);
                            },
                            text: Str.createCurrencyTxt.toUpperCase(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
