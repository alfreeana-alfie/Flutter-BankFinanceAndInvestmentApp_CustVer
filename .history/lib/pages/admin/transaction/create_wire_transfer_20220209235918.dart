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
import 'package:flutter_banking_app/widgets/dropdown/dropdown_bank.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateWireTransfer extends StatefulWidget {
  const CreateWireTransfer({Key? key}) : super(key: key);

  @override
  _CreateWireTransferState createState() => _CreateWireTransferState();
}

class _CreateWireTransferState extends State<CreateWireTransfer> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  SharedPref sharedPref = SharedPref();

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
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.wireTransfer, implyLeading: true, context: context),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.bank, style: Styles.primaryTitle),
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
                    mandatory: true,
                    onSaved: (val) => swiftCode = val,
                    hintText: Str.swiftCode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => amount = val,
                    hintText: Str.amount,
                    labelText: Str.amountNum,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number
                  ),
                  const Gap(20.0),
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
                    mandatory: true,
                    onSaved: (val) => accountHolder = val,
                    hintText: Str.accountHolder,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => accountHolderName = val,
                    hintText: Str.accountHolderName,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name
                  ),
                  const Gap(20.0),
                  NewField(
                    onSaved: (val) => note = val,
                    hintText: Str.description,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.multiline,
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
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      width: double.maxFinite,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.userId: userId ?? Field.empty,
                          Field.currencyId: currency ?? Field.empty,
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
                          Field.otherBankId: otherBankId ?? Field.empty,
                          Field.gatewayId: gatewayId,
                          Field.createdUserId: userId ?? Field.empty,
                          Field.updatedUserId: userId ?? Field.empty,
                          Field.branchId: branchId,
                          Field.transactionsDetails: transactionsDetails
                        };

                        // WireTransferMethods.addAdmin(context, body);
                        Method.add(
                            context,
                            _btnController,
                            body,
                            AdminAPI.createNavigation,
                            Type.navigation,
                            RouteSTR.createNavigation,
                            Str.navigationList);
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
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
            //       labelText: Str.description,
            //       labelStyle: Styles.subtitleStyleDark02,
            //       hintText: Str.description,
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
