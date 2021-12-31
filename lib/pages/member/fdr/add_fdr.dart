import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/fixed_deposit_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class MCreateFDR extends StatefulWidget {
  const MCreateFDR({Key? key}) : super(key: key);

  @override
  _MCreateFDRState createState() => _MCreateFDRState();
}

class _MCreateFDRState extends State<MCreateFDR> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  var controller = ScrollController();
  var currentPage = 0;

  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';

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

    Widget fileDetails(PlatformFile file) {
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File Name: ${file.name}'),
            // Text('File Size: $size'),
            // Text('File Extension: ${file.extension}'),
            // Text('File Path: ${file.path}'),
          ],
        ),
      );
    }

    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
          title: Str.applyDepositTxt,
          implyLeading: true,
          context: context,
          onPressedBack: () => Navigator.pop(context),
        ),
        // bottomSheet: Container(
        //   color: Styles.primaryColor,
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        //   child: elevatedButton(
        //     color: Styles.secondaryColor,
        //     context: context,
        //     callback: () {
        //       Map<String, String> body = {
        //         'fdr_plan_Id': planFDR ?? Field.emptyString,
        //         'user_Id': userLoad.id.toString(),
        //         'currency_Id': currency  ?? Field.emptyString,
        //         'deposit_amount': amount  ?? Field.emptyString,
        //         'return_amount': amount  ?? Field.emptyString,
        //         'attachment': file!.name,
        //         'remarks': remarks ?? Field.emptyString,
        //         'status': '1',
        //         'approved_date': 'null',
        //         'mature_date': 'null',
        //         'transaction_Id': '1',
        //         'approved_user_Id': '1',
        //         'created_user_Id': userLoad.id.toString(),
        //         'updated_user_Id': userLoad.id.toString(),
        //         'branch_Id': '2',
        //       };

        //       FixedDepositMethods.add(context, body, file!.name);
        //     },
        //     text: Str.applyLoanTxt.toUpperCase(),
        //   ),
        // ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 8),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 8),
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
                          onChanged: (val) {
                            amount = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(Str.attachmentTxt,
                                    style: Styles.subtitleStyleDark02),
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
                              // if (file != null) fileDetails(file!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    'fdr_plan_Id': planFDR ?? Field.emptyString,
                    'user_Id': userLoad.id.toString(),
                    'currency_Id': currency ?? Field.emptyString,
                    'deposit_amount': amount ?? Field.emptyString,
                    'return_amount': amount ?? Field.emptyString,
                    // 'attachment': file!.name,
                    'remarks': remarks ?? Field.emptyString,
                    'status': '1',
                    'approved_date': '2021-09-09',
                    'mature_date': '2021-09-09',
                    'transaction_Id': '1',
                    'approved_user_Id': '1',
                    'created_user_Id': userLoad.id.toString(),
                    'updated_user_Id': userLoad.id.toString(),
                    'branch_Id': '2',
                  };

                  FixedDepositMethods.add(context, body, 'test');
                },
                text: Str.applyDepositTxt.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
