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
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateOtherBank extends StatefulWidget {
  const CreateOtherBank({Key? key}) : super(key: key);

  @override
  _CreateOtherBankState createState() => _CreateOtherBankState();
}

class _CreateOtherBankState extends State<CreateOtherBank> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createOtherBank, implyLeading: true, context: context),
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
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.swiftCode,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => bankCountry = val,
                      hintText: Str.bankCountry,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => bankCurrency = val,
                      hintText: Str.bankCurrency,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => minTransferAmt = val,
                      hintText: Str.minTransferAmt,
                      labelText: Str.amountNum,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => maxTransferAmt = val,
                      hintText: Str.maxTransferAmt,
                      labelText: Str.amountNum,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => fixedCharge = val,
                      hintText: Str.fixedCharge,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => chargeInPercentage = val,
                      hintText: Str.chargeInPercentage,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true, 
                      onSaved: (val) => descriptions = val,
                      hintText: Str.descriptions,
                      maxLines: 5,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.multiline
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
                    child: RoundedLoadingButton(
                      
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
