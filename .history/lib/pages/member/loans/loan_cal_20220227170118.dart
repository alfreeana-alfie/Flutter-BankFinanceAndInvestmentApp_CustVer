import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
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
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.loanCalculator, implyLeading: true, context: context),
      // bottomSheet: 
      // Container(
      //   color: Styles.primaryColor,
      //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //   child: elevatedButton(
      //     color: Styles.secondaryColor,
      //     context: context,
      //     callback: () {},
      //     text: Str.applyLoan.toUpperCase(),
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
                          hintText: Str.appliedAmount,
                          labelText: Str.amountNum,
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
                      //     labelText: Str.appliedAmount,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.appliedAmount,
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
                          hintText: Str.interestRatePerYear,
                          labelText: Str.interestRatePerYear,
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
                      //     labelText: Str.interestRatePerYear,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.interestRatePerYear,
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
                          hintText: Str.interestRate,
                          labelText: Str.interestRate,
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
                      //     labelText: Str.interestType,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.interestType,
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
                          hintText: Str.term,
                          labelText: Str.term,
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
                      //     labelText: Str.term,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.term,
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
                          hintText: Str.termPeriod,
                          labelText: Str.termPeriod,
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
                      //     labelText: Str.termPeriod,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.termPeriod,
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
                          hintText: Str.firstPaymentDate,
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
                      //     labelText: Str.firstPaymentDate,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.firstPaymentDate,
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
                          hintText: Str.latePaymentDate,
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
                      //     labelText: Str.latePaymentDate,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.latePaymentDate,
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
                        text: Str.calculate.toUpperCase(),
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

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
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
