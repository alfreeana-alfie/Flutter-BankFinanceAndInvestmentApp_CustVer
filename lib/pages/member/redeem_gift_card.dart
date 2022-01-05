import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/gift_card_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class RedeemGiftCard extends StatefulWidget {
  const RedeemGiftCard({Key? key}) : super(key: key);

  @override
  _RedeemGiftCardState createState() => _RedeemGiftCardState();
}

class _RedeemGiftCardState extends State<RedeemGiftCard> {
  final ScrollController _scrollController = ScrollController();

  String? code, currency, currencyName, amount, userId, branchId;

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
            title: Str.createGiftCardTxt, implyLeading: true, context: context),
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
                      mandatory: true,
                      onSaved: (val) => code = val,
                      hintText: Str.codeTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => amount = val,
                      hintText: Str.amountTxt,
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.currencyTxt, style: Styles.primaryTitle),
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
                    const Gap(10),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Styles.primaryColor,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
                          Map<String, String> body = {
                            Field.code: code ?? Field.emptyString,
                            Field.currencyId: currency ?? Field.emptyString,
                            Field.amount: amount ?? Field.emptyAmount,
                            Field.status: Status.pending.toString(),
                            Field.userId: Field.emptyString,
                            Field.branchId: Field.emptyString,
                            Field.usedAt: Field.emptyString,
                          };

                          GiftCardMethods.add(context, body);
                        },
                        text: Str.submitTxt,
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
