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

class RateLayout extends StatefulWidget {
  const RateLayout({Key? key, this.rate}) : super(key: key);

  final Rate rate;

  @override
  _RateLayoutState createState() => _RateLayoutState();
}

class _RateLayoutState extends State<RateLayout> {
  final ScrollController _scrollController = ScrollController();

  String? functionName, currentRate, baseCurrency;
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
    //   currentRate = widget.rate.currentRate;
    //   baseCurrency = widget.rate.baseCurrency.toString();
    //   status = widget.rate.status;
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
                      readOnly: true,
                      initialValue: widget.rate.functionName,
                      onSaved: (val) => functionName = val,
                      hintText: Str.functionName),
                  const Gap(20.0),
                  NewField(
                      initialValue: widget.rate.currentRate,
                      onSaved: (val) => currentRate = val,
                      hintText: Str.currentRate),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          Field.functionName: functionName ??
                              widget.rate.functionName ??
                              Field.emptyString,
                          Field.currentRate: currentRate ??
                              widget.rate.currentRate ??
                              Field.currentRate,
                        };

                        RateMethods.edit(
                            context, body, widget.rate.id.toString());
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
