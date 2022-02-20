import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/other_bank_methods.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OtherBankLayout extends StatefulWidget {
  const OtherBankLayout({Key? key, this.bank, this.type}) : super(key: key);

  final Bank? bank;
  final String? type;

  @override
  _OtherBankLayoutState createState() => _OtherBankLayoutState();
}

class _OtherBankLayoutState extends State<OtherBankLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  int? status;

  String? currency,
      currencyName,
      name,
      exchangeRate,
      swiftCode,
      bankCountry,
      bankCurrency,
      minTransferAmt,
      maxTransferAmt,
      fixedCharge,
      chargeInPercentage,
      descriptions;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateOtherBank : Str.createOtherBank,
          implyLeading: true,
          context: context),
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
                      initialValue: widget.type == Field.update ? widget.bank?.name : Field.empty,
                      onSaved: (val) => name = val,
                      hintText: Str.name,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue:  widget.type == Field.update ? widget.bank?.swiftCode : Field.empty,
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.swiftCode,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update ? widget.bank?.bankCountry : Field.empty,
                      onSaved: (val) => bankCountry = val,
                      hintText: Str.bankCountry,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
                  const Gap(20.0),
                  // NewField(
                  //     mandatory: true,
                  //     initialValue: widget.type == Field.update ? widget.bank?.bankCurrency.toString() : Field.empty,
                  //     onSaved: (val) => bankCurrency = val,
                  //     hintText: Str.bankCurrency),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.currency, style: Styles.primaryTitle),
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
                  SizedBox(
                    child: DropDownCurrency(
                      currency: currency,
                      currencyName: currencyName,
                      currencyExchangeRate: exchangeRate,
                      onChanged: (val) {
                        setState(
                          () {
                            currency = val!.id.toString();
                            currencyName = val.name;
                            exchangeRate = val.exchangeRate;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update ? widget.bank?.minTransferAmt : Field.empty,
                    onSaved: (val) => minTransferAmt = val,
                    hintText: Str.minTransferAmt,
                    labelText: Str.amountNum,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update ? widget.bank?.maxTransferAmt : Field.empty,
                    onSaved: (val) => maxTransferAmt = val,
                    hintText: Str.maxTransferAmt,
                    labelText: Str.amountNum,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update ? widget.bank?.fixedCharge : Field.empty,
                      onSaved: (val) => fixedCharge = val,
                      hintText: Str.fixedCharge,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update ? widget.bank?.chargeInPercentage : Field.empty,
                      onSaved: (val) => chargeInPercentage = val,
                      hintText: Str.chargeInPercentage,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update ? widget.bank?.descriptions : Field.empty,
                    onSaved: (val) => descriptions = val,
                    hintText: Str.descriptions,
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.status, style: Styles.primaryTitle),
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
                    initialLabelIndex: int.parse(widget.bank?.status.toString() ?? Field.emptyInt),
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
                        status ??= int.parse(widget.bank?.status.toString() ?? Field.emptyInt);
                        Map<String, String> body = {
                          Field.name: name ?? widget.bank?.name ?? Field.emptyString,
                          Field.swiftCode: swiftCode ?? widget.bank?.swiftCode ?? Field.emptyInt,
                          Field.bankCountry: bankCountry ?? widget.bank?.bankCountry ?? Field.emptyString,
                          Field.bankCurrency:
                              currency ?? widget.bank?.bankCurrency.toString() ?? Field.empty,
                          Field.minTransferAmt:
                              minTransferAmt ?? widget.bank?.minTransferAmt ?? Field.emptyAmount,
                          Field.maxTransferAmt:
                              maxTransferAmt ?? widget.bank?.maxTransferAmt ?? Field.emptyAmount,
                          Field.fixedCharge: fixedCharge ?? widget.bank?.fixedCharge ?? Field.emptyAmount,
                          Field.chargeInPercentage:
                              chargeInPercentage ?? widget.bank?.chargeInPercentage ?? Field.emptyAmount,
                          Field.descriptions:
                              descriptions ?? widget.bank?.descriptions ?? Field.emptyString,
                          Field.status: status.toString()
                        };

                        OtherBankMethods.edit(context, body, widget.bank?.id.toString() ?? Field.empty);
                      },
                      text: Str.submit.toUpperCase(),
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
