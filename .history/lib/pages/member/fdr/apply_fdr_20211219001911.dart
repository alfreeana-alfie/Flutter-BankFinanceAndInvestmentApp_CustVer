import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/fixed_deposit_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class ApplyNewFDR extends StatefulWidget {
  const ApplyNewFDR({Key? key}) : super(key: key);

  @override
  _ApplyNewFDRState createState() => _ApplyNewFDRState();
}

class _ApplyNewFDRState extends State<ApplyNewFDR> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  var controller = ScrollController();
  var currentPage = 0;

  String? currency, currencyName, planFDR, planFDRName, amount, remarks;
  String fee = '12.50',
      drCr = 'Y',
      type = 'send_moeny',
      method = 'send_money',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      otherBankId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = '1';

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        print(userLoad.id.toString());
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
    SizeConfig.init(context);
    final theme = Layouts.getTheme(context);
    final size = Layouts.getSize(context);

    return OKToast(
      child: Scaffold(
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
                "fdr_plan_Id": "2",
                "user_Id": "1",
                "currency_Id": "1",
                "deposit_amount": "100.3",
                "return_amount": "100.6",
                "attachment": "fixed_deposit_files/SA1I9f7x0OajcjqtqPJcaXY44vvTaaNv5e0sqqG5.png",
                "remarks": "2",
                "status": "1",
                "approved_date": 'null',
                "mature_date": 'null',
                "transaction_Id": "1",
                "approved_user_Id": "3",
                "created_user_Id": "1",
                "updated_user_Id": "1",
                "branch_Id": "2",
              };
    
              FixedDepositMethods.add(context, body);
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
                            labelText: Str.depositAmountTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.amountNumTxt,
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
      ),
    );
  }
}
