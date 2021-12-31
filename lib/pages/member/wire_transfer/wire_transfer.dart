import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/wire_transfer_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class MCreateWireTransfer extends StatefulWidget {
  const MCreateWireTransfer({Key? key}) : super(key: key);

  @override
  _MCreateWireTransferState createState() => _MCreateWireTransferState();
}

class _MCreateWireTransferState extends State<MCreateWireTransfer> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();

  String? currency, currencyName, userId, otherBankId, amount, note;

  String fee = '1',
      drCr = '1',
      type = '1',
      method = 'wire_transfer',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = 'wire_transfer';

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
                          // readOnly: true,
                          onChanged: (val) {
                            otherBankId = '1';
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.bankTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.bankTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //         padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
                        //         child: Text(Str.bankTxt,
                        //             style: Styles.subtitleStyle)),
                        //     const Gap(20.0),
                        //     DropDownCurrency(
                        //       currency: currency,
                        //       currencyName: currencyName,
                        //       onChanged: (val) {
                        //         setState(
                        //           () {
                        //             currency = val!.id.toString();
                        //             currencyName = val.name;
                        //           },
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        const Gap(20.0),
                        TextFormField(
                          // readOnly: true,
                          onChanged: (val) {
                            // otherBankId = '1';
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    amount = val;
                                  },
                                  style: Styles.subtitleStyle,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: Str.amountNumTxt,
                                    hintStyle: Styles.subtitleStyle,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      gapPadding: 0.0,
                                    ),
                                  ),
                                ),
                              ),
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
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {},
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.accountHolderTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.accountHolderTxt,
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
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.accountHolderNameTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.accountHolderNameTxt,
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
                  // Divider(color: Styles.primaryColor, thickness: 2),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                      color: Styles.thirdColor,
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      onChanged: (val) {
                        note = val;
                      },
                      style: Styles.subtitleStyleDark,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
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
                  ),
                  // const Gap(10),
                ],
              ),
            ),
            Container(
              color: Styles.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    Field.userId: userId ?? '0',
                    Field.currencyId: currency ?? '0',
                    Field.amount: amount ?? Field.emptyAmount,
                    Field.fee: fee,
                    Field.drCr: drCr,
                    Field.type: type,
                    Field.method: method,
                    Field.status: status,
                    Field.note: note ?? Field.emptyString,
                    Field.loanId: loanId,
                    Field.refId: refId,
                    Field.parentId: parentId,
                    Field.otherBankId: otherBankId ?? '0',
                    Field.gatewayId: gatewayId,
                    Field.createdUserId: userId ?? '0',
                    Field.updatedUserId: userId ?? '0',
                    Field.branchId: branchId,
                    Field.transactionsDetails: transactionsDetails
                  };

                  WireTransferMethods.add(context, body);
                },
                text: Str.wireTransferTxt.toUpperCase(),
              ),
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
