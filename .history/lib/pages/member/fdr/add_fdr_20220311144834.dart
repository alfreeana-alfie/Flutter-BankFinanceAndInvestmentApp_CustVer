import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/fixed_deposit_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_currency.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.init(context);

    Widget fileDetails(PlatformFile file) {
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final szize = (mb >= 1)
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

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.applyDeposit,
        implyLeading: true,
        context: context,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
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
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                            child: Text(Str.plan,
                                style: Styles.primaryTitle),
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
                          child: DropDownPlanFDR(
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
                        ),
                        const Gap(20.0),
                        Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                            child: Text(Str.currency,
                                style: Styles.primaryTitle),
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
                          onSaved: (val) => amount = val,
                          hintText: Str.depositAmount,
                          labelText: Str.amountNum,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                      color: Styles.cardColor,
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        NewField(
                            onSaved: (val) => remarks = val,
                            hintText: Str.remark),
                            const Gap(20.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(Str.attachment,
                              style: Styles.primaryTitle),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            pickFiles(fileType);
                          },
                          child: Text(Str.browse),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Styles.accentColor,
                          ),
                        ),
                        if (file != null) fileDetails(file!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Styles.primaryColor,
              ),
              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    'fdr_plan_Id': planFDR ?? Field.emptyString,
                    'user_Id': userLoad.id.toString(),
                    'currency_Id': currency ?? Field.emptyString,
                    Field.depositAmount: amount ?? Field.emptyString,
                    Field.returnAmount: amount ?? Field.emptyString,
                    Field.attachment: file!.name,
                    Field.remarks: remarks ?? Field.emptyString,
                    Field.status: Status.pending.toString(),
                    Field.approvedDate: '',
                    Field.matureDate: '',
                    'transaction_Id': '1',
                    'approved_user_Id': '1',
                    'created_user_Id': userLoad.id.toString(),
                    'updated_user_Id': userLoad.id.toString(),
                    'branch_Id': '2',
                    Field.transactionCode:
                              Field.transactionCodeInitials+ '$currencyName-' + getRandomCode(6)
                  };

                  FixedDepositMethods.add(context, body, file!.path ?? file!.name);
                },
                text: Str.applyDeposit.toUpperCase(),
              ),
            ),
            Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,10),
                  child: backButton(context),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    loadSharedPrefs();
  }

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
