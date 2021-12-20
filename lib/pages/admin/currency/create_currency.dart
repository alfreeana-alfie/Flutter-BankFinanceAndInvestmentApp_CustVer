import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/currency_methods.dart';
import 'package:flutter_banking_app/methods/member/wire_transfer_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateCurrency extends StatefulWidget {
  const CreateCurrency({Key? key}) : super(key: key);

  @override
  _CreateCurrencyState createState() => _CreateCurrencyState();
}

class _CreateCurrencyState extends State<CreateCurrency> {
  final ScrollController _scrollController = ScrollController();

  String? name, exchangeRate, baseCurrency;

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
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.createCurrencyTxt, implyLeading: true, context: context),
        bottomSheet: Container(
          color: Styles.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: elevatedButton(
            color: Styles.secondaryColor,
            context: context,
            callback: () {
              Map<String, String> body = {
                Field.name: name!,
                Field.exchangeRate: exchangeRate ?? Field.emptyAmount,
                Field.baseCurrency: baseCurrency ?? Field.emptyAmount,
                Field.status: Status.pending.toString()
              };
    
              CurrencyMethods.add(context, body);
            },
            text: Str.createCurrencyTxt.toUpperCase(),
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
                        TextFormField(
                          onChanged: (val) {
                            name = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.nameTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.nameTxt,
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
                            exchangeRate = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.currencyTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.amountNumTxt,
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
                            baseCurrency = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.baseCurrencyTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.baseCurrencyTxt,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
