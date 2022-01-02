import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field_clickable.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final ScrollController _scrollController = ScrollController();
  var firstDate = TextEditingController();
  var lateDate = TextEditingController();

  String? appliedAmt,
      interestRatePerYear,
      interestType,
      term,
      termPeriod,
      firstPaymentDate,
      latePaymentDate;

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.loanCalculatorTxt, implyLeading: true, context: context),
      // bottomSheet: 
      // Container(
      //   color: Styles.primaryColor,
      //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //   child: elevatedButton(
      //     color: Styles.secondaryColor,
      //     context: context,
      //     callback: () {},
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => appliedAmt = val,
                          hintText: Str.appliedAmountTxt,
                          labelText: Str.amountNumTxt,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     appliedAmt = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.appliedAmountTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.appliedAmountTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => interestRatePerYear = val,
                          hintText: Str.interestRatePerYearTxt,
                          labelText: Str.interestRatePerYearTxt,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     interestRatePerYear = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.interestRatePerYearTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.interestRatePerYearTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => interestType = val,
                          hintText: Str.interestRateTxt,
                          labelText: Str.interestRateTxt,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     interestType = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.interestTypeTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.interestTypeTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => term = val,
                          hintText: Str.termTxt,
                          labelText: Str.termTxt,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     term = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.termTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.termTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => termPeriod = val,
                          hintText: Str.termPeriodTxt,
                          labelText: Str.termPeriodTxt,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     termPeriod = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.termPeriodTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.termPeriodTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewFieldClickable(
                          mandatory: true,
                          controller: firstDate,
                          onSaved: (val) => firstPaymentDate = val,
                          hintText: Str.firstPaymentDateTxt,
                          onTap: _showFirstDatePickerDialog,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     firstPaymentDate = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.firstPaymentDateTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.firstPaymentDateTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20.0),
                      NewFieldClickable(
                          mandatory: true,
                          controller: lateDate,
                          onSaved: (val) => latePaymentDate = val,
                          hintText: Str.latePaymentDateTxt,
                          onTap: _showLateDatePickerDialog,
                        ),
                      // TextFormField(
                      //   onChanged: (val) {
                      //     latePaymentDate = val;
                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.number,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.latePaymentDateTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.latePaymentDateTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      const Gap(20),
                      elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {},
                        text: Str.calculateTxt.toUpperCase(),
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

  _showFirstDatePickerDialog() {
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

                  firstDate.text = formattedDate;
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

  _showLateDatePickerDialog() {
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

                  firstDate.text = formattedDate;
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
}
