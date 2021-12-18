import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';

class ApplyNewFDR extends StatefulWidget {
  const ApplyNewFDR({Key? key}) : super(key: key);

  @override
  _ApplyNewFDRState createState() => _ApplyNewFDRState();
}

class _ApplyNewFDRState extends State<ApplyNewFDR> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
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
          callback: () {},
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
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: Styles.primaryColor,
                                  hint: currency == null
                                      ? Text(Str.depositPlanTxt,
                                          style: Styles.subtitleStyle02)
                                      : Text(
                                          currency!,
                                          style: Styles.subtitleStyle,
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: Styles.subtitleStyle02,
                                  items: currencyList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        currency = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
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
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: Styles.primaryColor,
                                  hint: currency == null
                                      ? Text(Str.currencyTxt,
                                          style: Styles.subtitleStyle02)
                                      : Text(
                                          currency!,
                                          style: Styles.subtitleStyle,
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: Styles.subtitleStyle02,
                                  items: currencyList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        currency = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
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
