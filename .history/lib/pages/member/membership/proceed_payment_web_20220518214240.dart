// ignore_for_file: deprecated_member_use
//APP_URL=https://fvis.com.my/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/membership_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_membership.dart';
import 'package:flutter_banking_app/pages/webview.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/initialize_paystack.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
// import 'dart:html' as html;

class PaymentMethodsMenu extends StatefulWidget {
  final String? id,
      currentMembershipId,
      membershipPlanId,
      membershipPlanName,
      fee;

  const PaymentMethodsMenu(
      {Key? key,
      this.id,
      this.currentMembershipId,
      this.membershipPlanId,
      this.membershipPlanName,
      this.fee})
      : super(key: key);
  @override
  _PaymentMethodsMenuState createState() => _PaymentMethodsMenuState();
}

class _PaymentMethodsMenuState extends State<PaymentMethodsMenu> {
  final ScrollController _scrollController = ScrollController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final plugin = PaystackPlugin();
  Map<String, dynamic>? paymentIntentData;

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  bool isGeneratingCode = false;
  List<UserMembership> planListNew = [];

  String? membershipId, membershipName;

  String? amount, note, currency, currencyName, toUserId, toUserName, userId;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.paymentMethod, implyLeading: true, context: context),
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
                  //** Billplz
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: elevatedButtonWithGraphic(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        _btnController.stop();
                        submitPaymentBillPlz(widget.fee ?? '0.00');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${Str.payWithPaystack} ', style: TextStyle(fontSize: 16)),
                          Text('Billplz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          const Gap(10),
                          // Container(
                          //     constraints: const BoxConstraints(
                          //         minWidth: 10, maxWidth: 50),
                          //     child: Image.asset(Values.billplzLogoPath))
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  // //** CASH DEPOSIT
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         bottomLeft: Radius.circular(15),
                  //         bottomRight: Radius.circular(15)),
                  //     color: Styles.primaryColor,
                  //   ),
                  //   // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 0, vertical: 10),
                  //   child: elevatedButton(
                  //     color: Styles.secondaryColor,
                  //     context: context,
                  //     callback: () {
                  //       Map<String, String> body = {
                  //         Field.userId: userId ?? '0',
                  //         Field.membershipPlanId:
                  //             widget.membershipPlanId ?? '2',
                  //         Field.transactionCode:
                  //             Field.transactionCodeInitials +
                  //                 getRandomCode(6),
                  //         'payment_method': 'Cash',
                  //         Field.status: Status.pending.toString(),
                  //       };
                  //       if (widget.currentMembershipId == null) {
                  //         MembershipMethods.add(context, body);
                  //       } else {
                  //         MembershipMethods.edit(context, body, widget.id!);
                  //       }
                  //     },
                  //     text: Str.cashDeposit,
                  //   ),
                  // ),
                  // const Gap(10),
                  //** PayStack
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 0, vertical: 7),
                    child: elevatedButtonWithGraphic(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Timer(const Duration(seconds: 3), () {
                          _btnController.reset();
                        });
                        chargeCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${Str.payWithPaystack} ', style: TextStyle(fontSize: 16)),
                          Text('PayStack', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          const Gap(10),
                          // Container(
                          //     constraints: const BoxConstraints(
                          //         minWidth: 10, maxWidth: 100),
                          //     child: Image.asset(Values.paystackLogoPath))
                        ],
                      ),
                    ),
                  ),
                  // const Gap(10),
                  //** Stripe
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         bottomLeft: Radius.circular(15),
                  //         bottomRight: Radius.circular(15)),
                  //     color: Styles.primaryColor,
                  //   ),
                  //   // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 0, vertical: 10),
                  //   child: elevatedButtonWithGraphic(
                  //     controller: _btnController,
                  //     color: Styles.secondaryColor,
                  //     context: context,
                  //     callback: () async {
                  //       await makePayment();
                  //     },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(Str.payWithPaystack),
                  //         const Gap(10),
                  //         Container(
                  //             // margin: const EdgeInsets.all(8),
                  //             // color: Styles.primaryColor,
                  //             constraints: const BoxConstraints(
                  //                 minWidth: 10, maxWidth: 100),
                  //             child: Image.asset(
                  //               Values.stripeLogoPath,
                  //               color: Styles.primaryColor,
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  backButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //?? BillPlz SETUP
  submitPaymentBillPlz(String amount) async {
    // Map<String, String> body = {
    //   'customer_email': userLoad.email ?? 'email@example.com',
    //   'customer_name': userLoad.name ?? 'Testing',
    //   'product_price': amount,
    //   Field.userId: userId ?? '0',
    //   Field.walletId: '0',
    //   Field.accountId: '0',
    //   Field.method: 'Upgrade Membership Plan',
    //   Field.creditDebit: 'credit',
    //   Field.amount: widget.fee ?? '0.00',
    //   Field.rateAmount: '1.00',
    //   Field.grandTotal: '1.00',
    //   Field.paymentMethod: 'BillPlz',
    //   Field.currentRate: '1.00',
    //   Field.updatedBy: userId ?? '0',
    //   Field.currencyId:'10',
    //   Field.transactionCode: Field.transactionCodeInitials +
    //       'NGN-' +
    //       getRandomString(6),
    // };

    Map<String, String> body = {
      'customer_email': userLoad.email ?? 'email@example.com',
      'customer_name': userLoad.name ?? 'Testing',
      'product_price': amount,
      // FOR WALLET TRANSACTION
      Field.userId: userLoad.id.toString() ?? '0',
      Field.walletId: '0',
      Field.accountId: '0',
      Field.method: 'Upgrade Membership Plan',
      Field.creditDebit: 'credit',
      Field.amount: widget.fee ?? '0.00',
      Field.rateAmount: '1.00',
      Field.grandTotal: widget.fee ?? '0.00',
      Field.paymentMethod: 'BillPlz',
      Field.currentRate: '1.00',
      Field.updatedBy: userId ?? '0',
      Field.currencyId: '10',
      Field.transactionCode: Field.transactionCodeInitials +
          'NGN-' +
          getRandomString(6),
    };

    final response = await http.post(
      Uri.parse('https://villasearch.de/pay/public/api/submit'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      if (!kIsWeb) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => WebPage(
        //             initialUrl: response.body,
        //             amount: amount,
        //             currentRate: widget.currentRate,
        //             method: widget.method,
        //             walletBalance: widget.walletBalance,
        //             walletId: widget.walletId,
        //             accountId: widget.accountId,
        //             toUserId: widget.toUserId,
        //             toUserName: widget.toUserName,
        //             toUserEmail: widget.toUserEmail,
        //             userPhone: widget.userPhone,
        //             message: widget.message,
        //             messageTo: widget.messageTo,
        //             routePath: widget.routePath,
        //             exchangeRate: widget.exchangeRate,
        //             paymentMethod: 'BillPlz',
        //             type: widget.type,
        //             pageName: widget.pageName,
        //           )),
        // );
      } else {
        // if (await canLaunch(response.body)) {
        //   await launch(response.body);
        // } else {
        //   throw 'Could not launch BillPlz Redirect URL';
        // }
        html.window.open(response.body,"_self");
      }
    } else {
      // print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  calculateAmount(String amount) {
    final price = (int.parse(amount)) * 100;
    return price.toString();
  }

  chargeCard() async {
    Timer(const Duration(seconds: 3), () {
      _btnController.reset();
    });

    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Map accessCode = await createAccessCode(
        'sk_test_faa379125c75547ae5db0b99b5f167ee052da92b',
        widget.fee,
        'gmriyal@gmail.com');

    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Charge charge = Charge()
      ..amount = int.parse(widget.fee ?? '10000') * 100
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
        Field.membershipPlanId: widget.membershipPlanId ?? '2',
        Field.transactionCode: Field.transactionCodeInitials + getRandomCode(6),
        'payment_method': 'Paystack',
        Field.status: Status.pending.toString(),
      };
      if (widget.currentMembershipId == null) {
        MembershipMethods.add(context, body);
      } else {
        MembershipMethods.edit(context, body, widget.id!);
      }
      _showDialog();
    } else {
      _showErrorDialog();
    }
  }

  //?? Paystack SETUP
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      // print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KGRXdIxzlmpkVE9UV5zuCGJL9IzW7RmmyHgKHggepe7GsV2KaXP0vjntjNzoFHz1Cjl1aRzAuR3rerkvXIWVqLM00RiJonwrQ',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      // print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['client_secret'],
          confirmPayment: true,
        ),
      );
      setState(() {
        paymentIntentData = null;
      });

      Map<String, String> body = {
        Field.userId: userId ?? '0',
        Field.membershipPlanId: widget.membershipPlanId ?? '2',
        Field.transactionCode: Field.transactionCodeInitials + getRandomCode(6),
        'payment_method': 'Stripe',
        Field.status: Status.pending.toString(),
      };
      if (widget.currentMembershipId == null) {
        MembershipMethods.add(context, body);
      } else {
        MembershipMethods.edit(context, body, widget.id?? '');
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Paid Successfully!')));
    } on StripeException catch (e) {
      print(e.toString());
      _showErrorDialog();
    }
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

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    plugin.initialize(
        publicKey: 'pk_test_7577b1531016880743e16f17ba818cd14a08f1d2');
    loadSharedPrefs();
    // getView();
    print(widget.membershipPlanId);
    print(widget.currentMembershipId);
    super.initState();
  }

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

  //?? Stripe SETUP
  Future<void> makePayment() async {
    Timer(const Duration(seconds: 3), () {
      _btnController.reset();
    });

    try {
      paymentIntentData = await createPaymentIntent(widget.fee ?? '10000', 'NGN');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          applePay: true,
          googlePay: true,
          style: ThemeMode.light,
          merchantCountryCode: 'NGN',
          merchantDisplayName: userLoad.name,
        ),
      );

      // now finally display payment sheet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  //  Future<Map<String, dynamic>>
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

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }
}
