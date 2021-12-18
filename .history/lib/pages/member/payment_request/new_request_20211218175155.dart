import 'dart:convert';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/customer.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/generated/assets.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/people_slider.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  late FocusNode myFocusNode;
  var controller = ScrollController();
  var currentPage = 0;
  User userLoad = User();
  List<Customer> customerNewList = [];

  String? currency, currencyName, amount, receiverId;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        print(userLoad.id.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  void getList() async {
    final response = await http.get(API.listofUsers, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var customer in jsonBody[Field.data]) {
        final customers = Customer.fromMap(customer);

        setState(() {
          customerNewList.add(customers);
        });
      }
    } else {
      print(Status.failedTxt);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    myFocusNode = FocusNode();

    loadSharedPrefs();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final theme = Layouts.getTheme(context);
    final size = Layouts.getSize(context);

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.newRequestTxt, implyLeading: true, context: context),
      bottomSheet: Container(
        color: Styles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: elevatedButton(
          color: Styles.secondaryColor,
          context: context,
          callback: () {},
          text: Str.newRequestTxt.toUpperCase(),
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
                      // TextFormField(
                      //   // readOnly: true,
                      //   onChanged: (val) {

                      //   },
                      //   style: Styles.subtitleStyle,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.text,
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: Str.receiverAccountTxt,
                      //     labelStyle: Styles.subtitleStyle,
                      //     hintText: Str.receiverAccountTxt,
                      //     hintStyle: Styles.subtitleStyle03,
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide.none,
                      //       gapPadding: 0.0,
                      //     ),
                      //   ),
                      // ),
                      _body(size.height, theme),
                      const Gap(20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
                              child: Text(Str.currencyTxt,
                                  style: Styles.subtitleStyle)),
                          const Gap(20.0),
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
                      const Gap(20.0),
                      TextFormField(
                        onChanged: (val) {
                          amount = val;
                        },
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.amountTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.amountNumTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      // const Gap(20.0),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    color: Styles.yellowColor,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    onChanged: (val) {},
                    style: Styles.subtitleStyleDark,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: Str.descriptionTxt,
                      labelStyle: Styles.subtitleStyleDark02,
                      hintText: Str.descriptionTxt,
                      hintStyle: Styles.subtitleStyleDark03,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 0.0,
                      ),
                    ),
                  ),
                ),
                // const Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _body(double height, ThemeData theme) {
    double _height = height * 0.19;
    return SizedBox(
      height: _height,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: customerNewList.length,
        itemBuilder: (context, index) {
          final item = customerNewList[index];
          return InkWell(
            onTap: () {
              setState(() {
                currentPage = index;
                receiverId = item.id.toString();
              });
            },
            focusNode: myFocusNode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: (index == currentPage) ? 70 : 45,
                  width: (index == currentPage) ? 70 : 45,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Styles.infoColor,
                  ),
                  child: Avatar(
                    name: item.name,
                    textStyle: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.bold,
                        color: Styles.whiteColor),
                  ),
                ),
                const SizedBox(height: 10),
                (index == currentPage)
                    ? Text(item.name ?? '-',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16))
                    : const Text('')
              ],
            ),
          );
        },
      ),
    );
  }
}
