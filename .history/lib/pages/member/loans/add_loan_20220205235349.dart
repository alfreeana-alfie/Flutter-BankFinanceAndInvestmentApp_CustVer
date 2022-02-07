import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/loan_request_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_fdr.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field_clickable.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MCreateLoan extends StatefulWidget {
  const MCreateLoan({Key? key}) : super(key: key);

  @override
  _MCreateLoanState createState() => _MCreateLoanState();
}

class _MCreateLoanState extends State<MCreateLoan> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  var txt = TextEditingController();

  String? currency,
      currencyName,
      planFDR,
      planFDRName,
      userId,
      appliedAmount,
      description,
      firstPaymentDate,
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
        title: Str.applyLoanTxt,
        implyLeading: true,
        context: context,
      ),
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
                            child: Text(Str.planTxt,
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
                            child: Text(Str.currencyTxt,
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
                      NewFieldClickable(
                        mandatory: true,
                        controller: txt,
                        onSaved: (val) => firstPaymentDate = val,
                        hintText: Str.firstPaymentDateTxt,
                        onTap: _showDatePickerDialog,
                      ),
                      // NewField(
                      //         mandatory: true,
                      //         controller: txt,
                      //         onSaved: (val) => firstPaymentDate = val,
                      //         hintText: Str.firstPaymentDateTxt,
                      //       ),
                      //       ElevatedButton(
                      //             onPressed: () {
                      //               _showDatePickerDialog();
                      //             },
                      //             child:const Icon(Icons.calendar_today)),
                      const Gap(20.0),
                      NewField(
                        mandatory: true,
                        onSaved: (val) => appliedAmount = val,
                        hintText: Str.depositAmountTxt,
                        labelText: Str.amountNumTxt,
                      ),
                      const Gap(20.0),
                      NewField(
                        onSaved: (val) => description = val,
                        hintText: Str.descriptionTxt,
                        labelText: Str.descriptionTxt,
                      ),
                      const Gap(20),
                      NewField(
                          onSaved: (val) => remarks = val,
                          hintText: Str.remarkTxt),
                      const Gap(20.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.attachmentTxt,
                            style: Styles.primaryTitle),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          pickFiles(fileType);
                        },
                        child: Text(Str.browseTxt),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Styles.accentColor,
                        ),
                      ),
                      if (file != null) fileDetails(file!),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: elevatedButton(
                    color: Styles.secondaryColor,
                    context: context,
                    callback: () {
                      Map<String, String> body = {
                        'loan_Id': planFDR ?? Field.empty,
                        'loan_product_Id': planFDR ?? Field.empty,
                        'borrower_Id': userId ?? Field.empty,
                        Field.firstPaymentDate: firstPaymentDate!,
                        Field.releaseDate: '',
                        'currency_Id': currency ?? Field.empty,
                        Field.appliedAmount:
                            appliedAmount ?? Field.emptyAmount,
                        Field.totalPayable:
                            appliedAmount ?? Field.emptyAmount,
                        Field.totalPaid: Field.emptyAmount,
                        Field.latePaymentPenalty: '10',
                        Field.attachment: file!.name,
                        Field.description: description ?? Field.emptyString,
                        Field.remarks: remarks ?? Field.emptyString,
                        Field.status: Status.pending.toString(),
                        Field.approvedDate: '',
                        'approved_user_Id': '',
                        'created_user_Id': userId ?? Field.empty,
                        'branch_Id': '2',
                        Field.transactionCode: Field.transactionCodeInitials + getRandomCode(6)
                      };

                      LoanRequestMethods.add(context, body, file!.path ?? file!.name);
                    },
                    text: Str.submitTxt,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showDatePickerDialog() {
    return showDialog<Widget>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(40),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.primaryColor),
            child: SfDateRangePicker(
              todayHighlightColor: Styles.secondaryColor,
              allowViewNavigation: true,
              showNavigationArrow: true,
              showTodayButton: true,
              showActionButtons: true,
              onSubmit: (value) {
                setState(() {
                  var formattedDate = DateFormat(Styles.formatDateOnly)
                      .format(DateTime.parse(value.toString()));

                  txt.text = formattedDate;
                  firstPaymentDate = formattedDate.toString();
                });
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          );
        });
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
