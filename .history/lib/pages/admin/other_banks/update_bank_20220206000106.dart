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
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateOtherBank extends StatefulWidget {
  const UpdateOtherBank({Key? key, required this.bank}) : super(key: key);

  final Bank bank;

  @override
  _UpdateOtherBankState createState() => _UpdateOtherBankState();
}

class _UpdateOtherBankState extends State<UpdateOtherBank> {
  final ScrollController _scrollController = ScrollController();
  int? status;

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
    // setState(() {
    //   name = widget.bank.name;
    //   swiftCode = widget.bank.swiftCode;
    //   bankCountry = widget.bank.bankCountry;
    //   bankCurrency = widget.bank.bankCurrency.toString();
    //   minTransferAmt = widget.bank.minTransferAmt;
    //   maxTransferAmt = widget.bank.maxTransferAmt;
    //   fixedCharge = widget.bank.fixedCharge;
    //   chargeInPercentage = widget.bank.chargeInPercentage;
    //   descriptions = widget.bank.descriptions;
    // });
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.updateOtherBankTxt,
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
                      initialValue: widget.bank.name,
                      onSaved: (val) => name = val,
                      hintText: Str.nameTxt),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue:  widget.bank.swiftCode,
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.swiftCodeTxt),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.bank.bankCountry,
                      onSaved: (val) => bankCountry = val,
                      hintText: Str.bankCountryTxt),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.bank.bankCurrency.toString(),
                      onSaved: (val) => bankCurrency = val,
                      hintText: Str.bankCurrencyTxt),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.bank.minTransferAmt,
                    onSaved: (val) => minTransferAmt = val,
                    hintText: Str.minTransferAmtTxt,
                    labelText: Str.amountNumTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.bank.maxTransferAmt,
                    onSaved: (val) => maxTransferAmt = val,
                    hintText: Str.maxTransferAmtTxt,
                    labelText: Str.amountNumTxt,
                  ),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.bank.fixedCharge,
                      onSaved: (val) => fixedCharge = val,
                      hintText: Str.fixedChargeTxt),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.bank.chargeInPercentage,
                      onSaved: (val) => chargeInPercentage = val,
                      hintText: Str.chargeInPercentageTxt),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.bank.descriptions,
                    onSaved: (val) => descriptions = val,
                    hintText: Str.descriptionsTxt,
                    maxLines: 5,
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
                    initialLabelIndex: int.parse(widget.bank.status.toString()),
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
                        status ??= int.parse(widget.bank.status.toString());
                        Map<String, String> body = {
                          Field.name: name ?? widget.bank.name ?? Field.emptyString,
                          Field.swiftCode: swiftCode ?? widget.bank.swiftCode ?? Field.emptyAmount,
                          Field.bankCountry: bankCountry ?? widget.bank.bankCountry ?? Field.emptyString,
                          Field.bankCurrency:
                              bankCurrency ?? widget.bank.bankCurrency.toString(),
                          Field.minTransferAmt:
                              minTransferAmt ?? widget.bank.minTransferAmt ?? Field.emptyAmount,
                          Field.maxTransferAmt:
                              maxTransferAmt ?? widget.bank.maxTransferAmt ?? Field.emptyAmount,
                          Field.fixedCharge: fixedCharge ?? widget.bank.fixedCharge ?? Field.emptyAmount,
                          Field.chargeInPercentage:
                              chargeInPercentage ?? widget.bank.chargeInPercentage ?? Field.emptyAmount,
                          Field.descriptions:
                              descriptions ?? widget.bank.descriptions ?? Field.emptyString,
                          Field.status: status.toString()
                        };

                        OtherBankMethods.edit(context, body, widget.bank.id.toString());
                      },
                      text: Str.submitTxt.toUpperCase(),
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
