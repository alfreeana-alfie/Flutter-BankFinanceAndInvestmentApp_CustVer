import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/loan_request_methods.dart';
import 'package:flutter_banking_app/methods/member/send_money_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';

class MCreateLoan extends StatefulWidget {
  const MCreateLoan({Key? key}) : super(key: key);

  @override
  _MCreateLoanState createState() => _MCreateLoanState();
}

class _MCreateLoanState extends State<MCreateLoan> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();

  String? currency,
      currencyName,
      planFDR,
      planFDRName,
      userId,
      appliedAmount,
      description,
      remarks;
  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';

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
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.applyLoanTxt,
        implyLeading: true,
        context: context,
        onPressedBack: () =>
            Navigator.pushReplacementNamed(context, RouteSTR.loanListM),
      ),
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
                        keyboardType: TextInputType.text,
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
                        onChanged: (val) {
                          appliedAmount = val;
                        },
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    color: Styles.thirdColor,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (val) {
                          description = val;
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
                      TextFormField(
                        onChanged: (val) {
                          remarks = val;
                        },
                        style: Styles.subtitleStyleDark,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
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
                              keyboardType: TextInputType.text,
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
                            child: ElevatedButton(
                              onPressed: () async {
                                pickFiles(fileType);
                              },
                              child: Text(Str.browseTxt),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Styles.accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Styles.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: elevatedButton(
              color: Styles.secondaryColor,
              context: context,
              callback: () {
                
                     Map<String, String> body = {
                  'loan_Id': planFDR ?? Field.empty,
                  'loan_product_Id': '1',
                  'borrower_Id': userId ?? Field.empty,
                  'first_payment_date': '2021-07-09',
                  'release_date': '2021-07-09',
                  'currency_Id': currency ?? Field.empty,
                  'applied_amount': appliedAmount ?? Field.emptyAmount,
                  'total_payable': '2',
                  'total_paid': '2',
                  'late_payment_penalties': '10',
                  // 'attachment':
                  //     'loan_files/bQURCY5sVoNOCsGPX0VbXx69iNO7HD6yNZY6lLbk.png',
                  'description': description ?? Field.emptyString,
                  'remarks': remarks ?? Field.emptyString,
                  'status': Status.pending.toString(),
                  'approved_date': '2021-02-09',
                  'approved_user_Id': '1',
                  'created_user_Id': userId ?? Field.empty,
                  'branch_Id': '2',
                };

                print(body);

                LoanRequestMethods.add(context, body);
              },
              text: Str.sendMoneyTxt,
            ),
          ),
          // Container(
          //   // color: Styles.primaryColor,
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          //   child: elevatedButton(
          //     color: Styles.secondaryColor,
          //     context: context,
          //     callback: () {
          //       Map<String, String> body = {
          //         'loan_Id': planFDR ?? Field.empty,
          //         'loan_product_Id': '1',
          //         'borrower_Id': userId ?? Field.empty,
          //         'first_payment_date': '2021-07-09',
          //         'release_date': '2021-07-09',
          //         'currency_Id': currency ?? Field.empty,
          //         'applied_amount': appliedAmount ?? Field.emptyAmount,
          //         'total_payable': Field.emptyAmount,
          //         'total_paid': Field.emptyAmount,
          //         'late_payment_penalties': '10',
          //         // 'attachment':
          //         //     'loan_files/bQURCY5sVoNOCsGPX0VbXx69iNO7HD6yNZY6lLbk.png',
          //         'description': description ?? Field.emptyString,
          //         'remarks': remarks ?? Field.emptyString,
          //         'status': Status.pending.toString(),
          //         'approved_date': 'null',
          //         'approved_user_Id': Field.empty,
          //         'created_user_Id': userId ?? Field.empty,
          //         'branch_Id': '2',
          //       };

          //       LoanRequestMethods.add(context, body);
          //     },
          //     text: Str.submitTxt.toUpperCase(),
          //   ),
          // ),
        ],
      ),
    );
  }

  // _selectDate(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2010),
  //     lastDate: DateTime(2025),
  //   );
  //   if (selected != null && selected != selectedDate) {
  //     setState(() {
  //       selectedDate = selected;
  //     });
  //   }
  // }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        break;
    }
  }
}
