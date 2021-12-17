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
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/people_slider.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  SharedPref sharedPref = SharedPref();
  final ScrollController _scrollController = ScrollController();

  var controller = ScrollController();
  var currentPage = 0;
  User userLoad = User();
  List<Customer> customerNewList = [];

  String? amount, note, description, currency, toUserId;
  String fee = '12.50',
      drCr = 'Y',
      type = 'send_moeny',
      method = 'send_money',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      otherBankId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = '1';

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

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
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
          title: Str.sendMoneyTxt, implyLeading: true, context: context),
      bottomSheet: Container(
        color: Styles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: elevatedButton(
          color: Styles.secondaryColor,
          context: context,
          callback: () {
            Map<String, String> body = {
              Field.userId: userLoad.id.toString(),
              Field.currencyId: currency ?? '-',
              Field.amount: amount ?? '0.00',
              Field.fee: fee,
              Field.drCr: drCr,
              Field.type: type,
              Field.method: method,
              Field.status: status,
              Field.note: note ?? '-',
              Field.loanId: loanId,
              Field.refId: refId,
              Field.parentId: parentId,
              Field.otherBankId: otherBankId,
              Field.gatewayId: gatewayId,
              Field.createdUserId: createdUserId,
              Field.updatedUserId: updatedUserId,
              Field.branchId: branchId,
              Field.transactionsDetails: transactionsDetails
            };

            print(toUserId);

            // SendMoneyMethods.add(context, body);
            // SendMoneyMethods.viewAll();
            // SendMoneyMethods.viewOne('1');
            // FixedDepositMethods.viewOne('1');
          },
          text: Str.sendMoneyTxt,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // Stack(
          //   children: [
          //     Container(
          //       width: double.infinity,
          //       padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15),
          //         color: Styles.primaryWithOpacityColor,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: const [
          //               Padding(
          //                 padding: EdgeInsets.only(top: 20, left: 5),
          //                 child: Text('USD', style: Styles.subtitleStyle),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(top: 20, right: 5),
          //                 child: Text(
          //                   '\$20,000.00',
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 21,
          //                       color: Colors.white),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Gap(60),
          //         ],
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       right: 70,
          //       child: Container(
          //         padding: const EdgeInsets.all(6),
          //         decoration: BoxDecoration(
          //           borderRadius:
          //               const BorderRadius.vertical(top: Radius.circular(50)),
          //           color: Styles.primaryColor,
          //         ),
          //         child: Container(
          //           padding: const EdgeInsets.all(6),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Styles.primaryWithOpacityColor,
          //           ),
          //           child: Icon(Icons.keyboard_backspace_rounded,
          //               color: Colors.white.withOpacity(0.5), size: 18),
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       right: 18,
          //       child: Container(
          //         padding: const EdgeInsets.all(6),
          //         decoration: BoxDecoration(
          //           borderRadius:
          //               const BorderRadius.vertical(top: Radius.circular(50)),
          //           color: Styles.primaryColor,
          //         ),
          //         child: Container(
          //           padding: const EdgeInsets.all(6),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Styles.primaryWithOpacityColor,
          //           ),
          //           child: Transform.rotate(
          //             angle: math.pi,
          //             child: const Icon(Icons.keyboard_backspace_rounded,
          //                 color: Colors.white, size: 18),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const Gap(20),
          _body(size.height, theme),
          const Gap(10),
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
                        onChanged: (val) {
                          setState(
                            () {
                              currency = val;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(color: Styles.primaryColor, thickness: 2),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text('Send Money Purpose',
                        style:
                            TextStyle(color: Colors.white.withOpacity(0.7)))),
                const Gap(10),
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
                toUserId = item.name;
              });
            },
            fo
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
