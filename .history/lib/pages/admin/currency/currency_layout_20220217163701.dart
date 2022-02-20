import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/currency_methods.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CurrencyLayout extends StatefulWidget {
  const CurrencyLayout({Key? key, this.currency, this.type}) : super(key: key);

  final Currency currency;
  final String? type;

  @override
  _CurrencyLayoutState createState() => _CurrencyLayoutState();
}

class _CurrencyLayoutState extends State<CurrencyLayout> {
  final RoundedLoadingButtonController _scrollController = RoundedLoadingButtonController();

  String? name, exchangeRate, baseCurrency;
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
    //   name = widget.currency.name;
    //   exchangeRate = widget.currency.exchangeRate;
    //   baseCurrency = widget.currency.baseCurrency.toString();
    //   status = widget.currency.status;
    // });
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.updateCurrency, implyLeading: true, context: context),
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
                      initialValue: widget.currency.name,
                      onSaved: (val) => name = val,
                      hintText: Str.name),
                  const Gap(20.0),
                  NewField(
                      initialValue: widget.currency.exchangeRate,
                      onSaved: (val) => exchangeRate = val,
                      hintText: Str.exchangeRate),
                  const Gap(20),
                  NewField(
                      initialValue: widget.currency.baseCurrency.toString(),
                      onSaved: (val) => baseCurrency = val,
                      hintText: Str.baseCurrency),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.status, style: Styles.primaryTitle),
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
                    initialLabelIndex:
                        int.parse(widget.currency.status.toString()),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          Field.name:
                              name ?? widget.currency.name ?? Field.emptyString,
                          Field.exchangeRate: exchangeRate ??
                              widget.currency.exchangeRate ??
                              Field.exchangeRate,
                          Field.baseCurrency: baseCurrency ??
                              widget.currency.baseCurrency.toString(),
                          Field.status: status.toString(),
                        };

                        CurrencyMethods.edit(
                            context, body, widget.currency.id.toString());
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
