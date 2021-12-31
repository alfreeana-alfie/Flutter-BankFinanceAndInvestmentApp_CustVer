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
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateGiftCard extends StatefulWidget {
  const CreateGiftCard({Key? key}) : super(key: key);

  @override
  _CreateGiftCardState createState() => _CreateGiftCardState();
}

class _CreateGiftCardState extends State<CreateGiftCard> {
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
                        TextFormField(
                          onChanged: (val) {
                            code = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.codeTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.codeTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    amount = val;
                                  },
                                  style: Styles.subtitleStyle,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: Str.amountNumTxt,
                                    hintStyle: Styles.subtitleStyle,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      gapPadding: 0.0,
                                    ),
                                  ),
                                ),
                              ),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Styles.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
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
                text: Str.submitTxt.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
