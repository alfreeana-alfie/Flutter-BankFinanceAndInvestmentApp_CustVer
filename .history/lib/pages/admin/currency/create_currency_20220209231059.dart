import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/currency_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateCurrency extends StatefulWidget {
  const CreateCurrency({Key? key}) : super(key: key);

  @override
  _CreateCurrencyState createState() => _CreateCurrencyState();
}

class _CreateCurrencyState extends State<CreateCurrency> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String? name, exchangeRate, baseCurrency;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createCurrency, implyLeading: true, context: context),
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
                      onSaved: (val) => name = val,
                      hintText: Str.name,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      ),
                  const Gap(20.0),
                  NewField(
                      onSaved: (val) => exchangeRate = val,
                      hintText: Str.exchangeRate,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,),
                  const Gap(20),
                  NewField(
                      onSaved: (val) => baseCurrency = val,
                      hintText: Str.baseCurrency,
                      ]),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          Field.name: name ?? Field.emptyString,
                          Field.exchangeRate: exchangeRate ?? Field.exchangeRate,
                          Field.baseCurrency: baseCurrency ?? Field.emptyAmount,
                          Field.status: Status.pending.toString(),
                        };

                        CurrencyMethods.add(context, body);
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
