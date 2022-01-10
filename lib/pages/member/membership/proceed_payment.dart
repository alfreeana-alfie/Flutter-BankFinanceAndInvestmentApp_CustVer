import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/membership_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_membership.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/initialize_paystack.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:http/http.dart' as http;

class PaymentMethodsMenu extends StatefulWidget {
  const PaymentMethodsMenu({Key? key, required this.membershipPlanId})
      : super(key: key);

  final String membershipPlanId;
  @override
  _PaymentMethodsMenuState createState() => _PaymentMethodsMenuState();
}

class _PaymentMethodsMenuState extends State<PaymentMethodsMenu> {
  final ScrollController _scrollController = ScrollController();
  final plugin = PaystackPlugin();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  bool isGeneratingCode = false;
  List<UserMembership> planListNew = [];

  String? membershipId, membershipName;


  String? amount, note, currency, currencyName, toUserId, toUserName, userId;
  String fee = '12.50',
      drCr = 'Y',
      type = 'send_money',
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

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        userId = user.id.toString();
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
    plugin.initialize(
        publicKey: 'pk_test_7577b1531016880743e16f17ba818cd14a08f1d2');
    super.initState();
    loadSharedPrefs();
    // getView();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.paymentMethodTxt, implyLeading: true, context: context),
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
                    //** CASH DEPOSIT
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Styles.primaryColor,
                      ),
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
                          Map<String, String> body = {
                            Field.userId: userId ?? '0',
                            Field.membershipPlanId: widget.membershipPlanId,
                            Field.transactionCode: Field.transactionCodeInitials + getRandomCode(6),
                            'payment_method': 'Cash',
                            Field.status: Status.pending.toString(),
                          };
                          MembershipMethods.add(context, body);
                        },
                        text: Str.cashDepositTxt,
                      ),
                    ),
                    const Gap(10),
                    //** PayStack
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
                      child: elevatedButtonWithGraphic(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () => chargeCard(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Str.payWithPaystackTxt),
                            const Gap(10),
                            Container(
                                constraints: const BoxConstraints(
                                    minWidth: 10, maxWidth: 100),
                                child: Image.asset(Values.paystackLogoPath))
                          ],
                        ),
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

  //?? Paystack SETUP
  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: SizedBox(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.check_box,
                color: Styles.secondaryColor,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Your payment has been successfully',
                style: TextStyle(fontSize: 13),
              ),
              Text('processed.', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: SizedBox(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Error in processing payment, please try again',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  chargeCard() async {
    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Map accessCode = await createAccessCode(
        'sk_test_faa379125c75547ae5db0b99b5f167ee052da92b');

    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Charge charge = Charge()
      ..amount = 10000
      ..accessCode = accessCode['data']['access_code']
      ..email = 'customer@email.com';
    CheckoutResponse response = await plugin.checkout(
      context,
      method:
          CheckoutMethod.selectable, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      Map<String, String> body = {
        Field.userId: userId ?? '0',
        Field.membershipPlanId: widget.membershipPlanId,
        Field.transactionCode: Field.transactionCodeInitials + getRandomCode(6),
        'payment_method': 'Paystack',
        Field.status: Status.pending.toString(),
      };
      MembershipMethods.add(context, body);
      _showDialog();
    } else {
      _showErrorDialog();
    }
  }
}
