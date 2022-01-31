import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/rate_methods.dart';
import 'package:flutter_banking_app/models/rate.dart';
import 'package:flutter_banking_app/models/rate.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateRate extends StatefulWidget {
  const UpdateRate({Key? key, required this.rate}) : super(key: key);

  final Rate rate;

  @override
  _UpdateRateState createState() => _UpdateRateState();
}

class _UpdateRateState extends State<UpdateRate> {
  final ScrollController _scrollController = ScrollController();

  String? functionName, exchangeRate, baseCurrency;
  int? status;

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

    // setState(() {
    //   functionName = widget.rate.functionName;
    //   exchangeRate = widget.rate.exchangeRate;
    //   baseCurrency = widget.rate.baseCurrency.toString();
    //   status = widget.rate.status;
    // });
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.updateCurrencyTxt, implyLeading: true, context: context),
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
                      read
                        initialValue: widget.rate.functionName,
                        onSaved: (val) => functionName = val,
                        hintText: Str.functionNameTxt),
                    const Gap(20.0),
                    NewField(
                        initialValue: widget.rate.exchangeRate,
                        onSaved: (val) => exchangeRate = val,
                        hintText: Str.exchangeRateTxt),
                    const Gap(20),
                    NewField(
                        initialValue: widget.rate.baseCurrency.toString(),
                        onSaved: (val) => baseCurrency = val,
                        hintText: Str.baseCurrencyTxt),
                    const Gap(20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.statusTxt, style: Styles.primaryTitle),
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
                    ToggleSwitch(
                      initialLabelIndex:int.parse(widget.rate.status.toString()),
                      minWidth: 120,
                      cornerRadius: 7.0,
                      activeBgColors: const [
                        [Styles.dangerColor],
                        [Styles.successColor]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.black12.withOpacity(0.05),
                      inactiveFgColor: Styles.textColor,
                      totalSwitches: 2,
                      labels: Field.statusList,
                      onToggle: (index) {
                        // print('switched to: $index');
                        status = index;
                      },
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
                          Map<String, String> body = {
                            Field.functionName: functionName ?? widget.rate.functionName ?? Field.emptyString,
                            Field.exchangeRate: exchangeRate ?? widget.rate.exchangeRate ?? Field.exchangeRate,
                            Field.baseCurrency: baseCurrency ?? widget.rate.baseCurrency.toString(),
                            Field.status: status.toString(),
                          };

                          CurrencyMethods.edit(context, body, widget.rate.id.toString());
                        },
                        text: Str.submitTxt.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
