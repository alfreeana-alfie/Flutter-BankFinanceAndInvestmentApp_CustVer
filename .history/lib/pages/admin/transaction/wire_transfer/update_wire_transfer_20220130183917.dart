import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/wire_transfer_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_bank.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateWireTransfer extends StatefulWidget {
  const UpdateWireTransfer({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  _UpdateWireTransferState createState() => _UpdateWireTransferState();
}

class _UpdateWireTransferState extends State<UpdateWireTransfer> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();

  int? status;

  String? currency,
      currencyName,
      userId,
      otherBankId,
      otherBankName,
      amount,
      note,
      swiftCode,
      accountHolder,
      accountHolderName;

  String? fee,
      drCr,
      type,
      method,
      loanId,
      refId,
      parentId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      transactionsDetails;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userId = user.id.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // setState(() {
    //   otherBankId = widget.transaction.otherBankId;
    //   amount = widget.transaction.amount;
    //   currency = widget.transaction.currencyId;
    //   note = widget.transaction.note;
    // });
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.wireTransferTxt, implyLeading: true, context: context),
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
                      readOnly: true,
                      mandatory: true,
                      initialValue: widget.transaction.userId.toString(),
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.userAccountTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: widget.transaction.otherBankId.toString(),
                      onSaved: (val) => otherBankId = val,
                      hintText: Str.otherBankTxt,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(Str.bankTxt, style: Styles.primaryTitle),
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
                      child: DropDownBank(
                        bank: otherBankId,
                        bankName: otherBankName,
                        onChanged: (val) {
                          setState(
                            () {
                              otherBankId = val!.id.toString();
                              otherBankName = val.name;
                            },
                          );
                        },
                      ),
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: swiftCode,
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.swiftCodeTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: amount,
                      onSaved: (val) => amount = val,
                      hintText: Str.amountTxt,
                      labelText: Str.amountNumTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: currency,
                      onSaved: (val) => currency = val,
                      hintText: Str.currencyTxt,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.currencyTxt, style: Styles.primaryTitle),
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
                        onChanged: (val) {
                          setState(
                            () {
                              currency = val!.id.toString();
                              currencyName = val.name;
                            },
                          );
                        },
                      ),
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: accountHolder,
                      onSaved: (val) => accountHolder = val,
                      hintText: Str.accountHolderTxt,
                    ),const Gap(20.0),
                    NewField(
                      readOnly: true,
                      mandatory: true,
                      initialValue: accountHolderName,
                      onSaved: (val) => accountHolderName = val,
                      hintText: Str.accountHolderNameTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      readOnly: true,
                      initialValue: note,
                      onSaved: (val) => note = val,
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
                      initialLabelIndex: status,
                      minWidth: 120,
                      cornerRadius: 7.0,
                      activeBgColors: const [
                        [Styles.warningColor],
                        [Styles.successColor],
                        [Styles.dangerColor]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.black12.withOpacity(0.05),
                      inactiveFgColor: Styles.textColor,
                      totalSwitches: 3,
                      labels: Field.approvelList,
                      onToggle: (index) {
                        // print('switched to: $index');
                        status = index;
                      },
                    ),
                    const Gap(20),
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
                            // Field.userId: userId ?? widget.transaction.userId.toString(),
                            // Field.currencyId: currency ?? widget.transaction.currencyId ?? Field.empty,
                            // Field.amount: amount ?? widget.transaction.amount ?? Field.emptyAmount,
                            // Field.fee: fee ?? widget.transaction.fee ?? Field.emptyAmount,
                            // Field.drCr: drCr  ?? widget.transaction.drCr ?? Field.emptyString,
                            // Field.type: type  ?? widget.transaction.type ?? Field.emptyAmount,
                            // Field.method: method ?? widget.transaction.method ?? Field.emptyAmount ,
                            Field.status: status.toString(),
                            // Field.note: note ?? widget.transaction.note ?? Field.emptyAmount,
                            // Field.loanId: loanId ?? widget.transaction.loanId ?? Field.emptyAmount,
                            // Field.refId: refId  ?? widget.transaction.refId ?? Field.emptyAmount,
                            // Field.parentId: parentId ?? widget.transaction.parentId ?? Field.emptyAmount,
                            // Field.otherBankId: otherBankId ?? widget.transaction.otherBankId ?? Field.emptyAmount,
                            // Field.gatewayId: gatewayId ?? widget.transaction.gatewayId ?? Field.emptyAmount,
                            // Field.createdUserId: userId ?? widget.transaction.userId.toString(),
                            // Field.updatedUserId: userId ?? widget.transaction.userId.toString(),
                            // Field.branchId: branchId ?? widget.transaction.branchId ?? Field.emptyAmount,
                            // Field.transactionsDetails: transactionsDetails ?? widget.transaction.transactionsDetails ?? Field.emptyAmount
                          };

                          WireTransferMethods.editStatus(context, body, widget.transaction.id.toString());
                        },
                        text: Str.wireTransferTxt.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(color: Styles.primaryColor, thickness: 2),
              // Container(
              //   decoration: const BoxDecoration(
              //     borderRadius:
              //         BorderRadius.vertical(bottom: Radius.circular(15)),
              //     color: Styles.thirdColor,
              //   ),
              //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              //   child: TextFormField(
              //     onChanged: (val) {
              //       note = val;
              //     },
              //     style: Styles.subtitleStyleDark,
              //     textInputAction: TextInputAction.done,
              //     keyboardType: TextInputType.text,
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //       labelText: Str.descriptionTxt,
              //       labelStyle: Styles.subtitleStyleDark02,
              //       hintText: Str.descriptionTxt,
              //       hintStyle: Styles.subtitleStyleDark03,
              //       border: const OutlineInputBorder(
              //         borderSide: BorderSide.none,
              //         gapPadding: 0.0,
              //       ),
              //     ),
              //   ),
              // ),
              // const Gap(10),

              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customColumn({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(),
            style:
                TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
        const Gap(2),
        Text(subtitle,
            style:
                TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8))),
      ],
    );
  }
}
