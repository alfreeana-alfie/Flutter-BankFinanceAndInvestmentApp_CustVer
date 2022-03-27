import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/gift_card.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GiftCardLayout extends StatefulWidget {
  const GiftCardLayout({Key? key, this.giftCard, this.type}) : super(key: key);

  final GiftCard? giftCard;
  final String? type;

  @override
  _GiftCardLayoutState createState() => _GiftCardLayoutState();
}

class _GiftCardLayoutState extends State<GiftCardLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? code, currency, currencyName, amount, userId, branchId;
  int? status;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update
              ? Str.updateGiftCard
              : Str.createGiftCard,
          implyLeading: true,
          context: context),
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
                    initialValue: widget.type == Field.update
                        ? widget.giftCard?.code
                        : Field.empty,
                    onSaved: (val) => code = val,
                    hintText: Str.code,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update
                          ? widget.giftCard?.amount
                          : Field.empty,
                      onSaved: (val) => amount = val,
                      hintText: Str.amount,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.currency, style: Styles.primaryTitle),
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
                        int.parse(widget.giftCard?.status ?? Field.emptyInt),
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
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      width: double.maxFinite,
                      elevation: 0.0,
                      borderRadius: 15,
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        status ??= int.parse(
                            widget.giftCard?.status ?? Field.emptyInt);
                        Map<String, String> body = {
                          Field.code: code ??
                              widget.giftCard?.code ??
                              Field.emptyString,
                          Field.currencyId: currency ??
                              widget.giftCard?.currencyId.toString() ??
                              Field.emptyAmount,
                          Field.amount: amount ??
                              widget.giftCard?.amount ??
                              Field.emptyAmount,
                          Field.status: status.toString(),
                          Field.userId: userId ??
                              widget.giftCard?.userId.toString() ??
                              Field.emptyAmount,
                          Field.branchId: branchId ??
                              widget.giftCard?.userId.toString() ??
                              Field.emptyAmount,
                          // Field.usedAt: user,
                        };

                        // GiftCardMethods.edit(
                        //     context,
                        //     body,
                        //     widget.giftCard?.id.toString() ??
                        //         Field.emptyAmount);
                        widget.type == Field.update
                            ? Method.edit(
                                context,
                                _btnController,
                                body,
                                Uri.parse(AdminAPI.updateGiftCard.toString() + widget.giftCard!.id.toString()),
                                Type.giftCard,
                                GiftCardLayout(
                                  type: Field.create,
                                ),
                                Str.giftCardList,
                                Field.empty, '')
                            : Method.add(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createGiftCard,
                                Type.giftCard,
                                GiftCardLayout(
                                  type: Field.create,
                                ),
                                Str.giftCardList, '');
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
                  ),
                  backButton(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
