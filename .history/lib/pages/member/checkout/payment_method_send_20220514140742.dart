// ignore_for_file: deprecated_member_use
//APP_URL=https://fvis.com.my/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/wallet_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_membership.dart';
import 'package:flutter_banking_app/utils/initialize_paystack.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaymentMethodWalletMenu extends StatefulWidget {
  const PaymentMethodWalletMenu(
      {Key? key,
      required this.amount,
      this.method,
      this.creditDebit,
      this.toUserId,
      this.toUserEmail,
      this.walletId,
      this.accountId,
      this.walletBalance,
      this.routePath,
      this.userPhone,
      this.toUserName,
      this.message,
      this.messageTo,
      this.currentRate,
      this.user,
      this.exchangeRate,
      this.pageName,
      this.currencyId,
      this.currencyName,
      this.type,
      this.userId})
      : super(key: key);

  final String? method,
      creditDebit,
      toUserId,
      toUserName,
      toUserEmail,
      walletId,
      accountId,
      walletBalance,
      routePath,
      userPhone,
      message,
      messageTo,
      currentRate,
      exchangeRate,
      pageName,
      type,
      userId,
      currencyId,
      currencyName;

  final User? user;
  final String amount;
  @override
  _PaymentMethodWalletMenuState createState() =>
      _PaymentMethodWalletMenuState();
}

class _PaymentMethodWalletMenuState extends State<PaymentMethodWalletMenu> {
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

  String? amount,
      userId,
      userName,
      emailMessage,
      emailMessage01,
      emailMessage02,
      emailMessage03,
      emailMessageTo,
      emailMessageTo01,
      emailMessageTo02,
      emailMessageTo03;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        userId = user.id.toString();
        userName = user.name;
      });
    } catch (e) {
      print(e);
    }
  }

  void sendData(
      amount,
      currentRate,
      method,
      walletBalance,
      walletId,
      accountId,
      toUserId,
      toUserName,
      toUserEmail,
      userPhone,
      message,
      messageTo,
      routePath,
      exchangeRate,
      paymentMethod,
      type,
      pageName) {
    // double rateCharge = double.parse(amount);
    // setState(() => rateCharge *= (double.parse(currentRate) / 100));

    // // Calculation - Amount
    // double updatedAmount = double.parse(amount);
    // setState(() => updatedAmount -= rateCharge);

    // double updatedBalance = double.parse(walletBalance!);
    // if (method == Type.deposit || method == Type.topUp) {
    //   double convertBalance = updatedAmount;
    //   // setState(() => convertBalance /= double.parse(exchangeRate!));
    //   setState(() => updatedBalance += convertBalance);
    // } else {
    //   setState(() => updatedBalance -= updatedAmount);
    // }

    // // Calculation - Rate
    // if (exchangeRate != null) {
    double newAmount = double.parse(amount);
    setState(() => newAmount *= double.parse(exchangeRate));

    double rateCharge = newAmount;
    setState(() => rateCharge *= (double.parse(currentRate) / 100));

    // Calculation - Amount
    double updatedAmount = newAmount;
    setState(() => updatedAmount -= rateCharge);

    // Calculation - Wallet subtract Updated Amount
    double updatedBalance = double.parse(walletBalance!);
    if (method == Type.deposit || method == Type.topUp) {
      double convertBalance = updatedAmount;
      setState(() => convertBalance /= double.parse(exchangeRate!));
      setState(() => updatedBalance += convertBalance);
    } else {
      setState(() => updatedBalance -= updatedAmount);
    }
    // }

    switch (method) {
      case 'send_money':
        emailMessage =
            'Send Money You have just send ${double.parse(amount).toStringAsFixed(2)} to $toUserName.';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo =
            'Send Money You have just received ${double.parse(amount).toStringAsFixed(2)} from $userName.';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'exchange_money':
        emailMessage =
            'Exchange Money You have just exchanged ${double.parse(amount).toStringAsFixed(2)} from your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'wire_transfer':
        emailMessage =
            'Wire Transfer You have just transferred ${double.parse(amount).toStringAsFixed(2)} into your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'top_up':
        emailMessage =
            'Top-Up Wallet You have just top-up ${double.parse(amount).toStringAsFixed(2)} into your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'sms_subcribed':
        emailMessage =
            'Congratulations, You have subcribed to SMS Notification. FVIS Investment ';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case Field.topUpAccountant:
        emailMessage =
            'Wallet Transaction Your account has been credited ${double.parse(amount).toStringAsFixed(2)}.';
        emailMessage01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      default:
    }

    Map<String, String> body = {
      Field.userId: widget.userId ?? userId ?? '0',
      Field.walletId: walletId ?? '0',
      Field.accountId: accountId ?? '0',
      Field.method: method ?? 'default',
      Field.creditDebit: method ?? 'default',
      Field.amount: double.parse(amount).toStringAsFixed(2),
      Field.rateAmount: rateCharge.toStringAsFixed(2),
      Field.grandTotal: updatedAmount.toStringAsFixed(2),
      Field.paymentMethod: paymentMethod,
      Field.currentRate: widget.currentRate ?? '0',
      Field.updatedBy: userId ?? '0',
      Field.currencyId: widget.currencyId ?? '10',
      Field.transactionCode: Field.transactionCodeInitials +
          '${widget.currencyName}-' +
          getRandomString(6),
    };

    Map<String, String> toUserBody = {
      Field.userId: toUserId ?? '0',
      Field.walletId: walletId ?? '0',
      Field.accountId: accountId ?? '0',
      Field.method: method ?? 'default',
      Field.creditDebit: method ?? 'default',
      Field.amount: double.parse(amount).toStringAsFixed(2),
      Field.rateAmount: rateCharge.toStringAsFixed(2),
      Field.grandTotal: updatedAmount.toStringAsFixed(2),
      Field.paymentMethod: paymentMethod,
      Field.updatedBy: toUserId ?? '0',
      Field.currencyId: widget.currencyId ?? '10',
      Field.transactionCode: Field.transactionCodeInitials +
          '${widget.currencyName}-' +
          getRandomString(6),
    };

    Map<String, String> updateWalletBody = {
      // Field.userId: userId ?? '3',
      // Field.accountId: accountId ?? '1',
      Field.amount: updatedBalance.toString(),
      Field.updatedBy: userId ?? '3',
    };

    WalletMethods.addTransaction(context, body);
    WalletMethods.update(context, updateWalletBody, widget.walletId ?? '0');

    if (method == 'sms_subcribed') {
      updateSMS(context, userLoad.id.toString());
    }

    if (toUserId != null) {
      if (userLoad.emailVerifiedAt != null) {
        EmailJS.send(
            context,
            userLoad.email ?? 'customer@gmail.com',
            userLoad.name ?? 'user',
            'FVIS Investment',
            emailMessage ?? 'Default',
            emailMessage01 ?? 'Default',
            emailMessage02 ?? 'Default',
            emailMessage03 ?? 'Default');
        EmailJS.send(
            context,
            toUserEmail ?? 'customer@gmail.com',
            toUserName ?? 'user',
            'FVIS Investment',
            emailMessage ?? 'Default',
            emailMessageTo01 ?? 'Default',
            emailMessageTo02 ?? 'Default',
            emailMessageTo03 ?? 'Default');
      } else if (userLoad.smsVerifiedAt != null) {
        SMSNigeriaAPI.send(context, userPhone ?? '000', message ?? 'default');
        SMSNigeriaAPI.send(context, toUserId ?? '000', messageTo ?? 'default');
      }

      WalletMethods.addTransaction(context, toUserBody);
      WalletMethods.update(context, updateWalletBody, widget.walletId ?? '2');

      if (widget.user!.userType != Field.customer) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          // Navigator.pushReplacementNamed(context, routePath!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                userType: userLoad.userType,
                type: type,
                routePath: routePath,
                pageName: pageName,
              ),
            ),
          );
        });
      } else {
        Navigator.popAndPushNamed(context, RouteSTR.walletListM);
      }
    } else {
      if (userLoad.emailVerifiedAt != null) {
        EmailJS.send(
            context,
            // 'alfreeanaalfie@gmail.com',
            userLoad.email ?? 'customer@gmail.com',
            userLoad.name ?? 'user',
            'FVIS Investment',
            emailMessage ?? 'Default',
            emailMessage01 ?? 'Default',
            emailMessage02 ?? 'Default',
            emailMessage03 ?? 'Default');
      } else if (userLoad.smsVerifiedAt != null) {
        SMSNigeriaAPI.send(context, userPhone ?? '000', message ?? 'default');
      }

      if (widget.user!.userType != Field.customer) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          // Navigator.pushReplacementNamed(context, routePath!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                userType: userLoad.userType,
                type: type,
                routePath: routePath,
                pageName: pageName,
              ),
            ),
          );
        });
      } else {
        Navigator.popAndPushNamed(context, RouteSTR.walletListM);
      }
    }
  }

  @override
  void initState() {
    loadSharedPrefs();
    plugin.initialize(
        publicKey: 'pk_live_2ee9513a81f8ed69087a9749e04dc71d50b22365');
    Stripe.publishableKey =
        'pk_test_51KGRXdIxzlmpkVE9Kaq0XxbZyt5k0XKltesUqyquUB4sPmWMuVXpFOmdrJIKs0Q6VnQW3yfytRoIwuqnEkID0VZ100aow4FDWK';

    super.initState();
  }

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
                  // //** CASH DEPOSIT
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         bottomLeft: Radius.circular(15),
                  //         bottomRight: Radius.circular(15)),
                  //     color: Styles.primaryColor,
                  //   ),
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  //   child: elevatedButton(
                  //     color: Styles.secondaryColor,
                  //     context: context,
                  //     callback: () {
                  //       sendData(
                  //         widget.amount,
                  //         widget.currentRate,
                  //         widget.method,
                  //         widget.walletBalance,
                  //         widget.walletId,
                  //         widget.accountId,
                  //         widget.toUserId,
                  //         widget.toUserName,
                  //         widget.toUserEmail,
                  //         widget.userPhone,
                  //         widget.message,
                  //         widget.messageTo,
                  //         widget.routePath,
                  //         widget.exchangeRate,
                  //         'Cash Deposit',
                  //         widget.type,
                  //         widget.pageName,
                  //       );
                  //     },
                  //     text: Str.cashDeposit,
                  //   ),
                  // ),
                  // const Gap(5),
                  //** PayStack
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
                        Timer(const Duration(seconds: 3), () {
                          _btnController.stop();
                        });
                        chargeCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Str.payWithPaystack),
                          const Gap(10),
                          Container(
                              constraints: const BoxConstraints(
                                  minWidth: 10, maxWidth: 100),
                              child: Image.asset(Values.paystackLogoPath))
                        ],
                      ),
                    ),
                  ),
                  const Gap(5),
                  //** Stripe
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: elevatedButtonWithGraphic(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () async {
                        double newAmount = double.parse(widget.amount);
                        setState(() => newAmount *= double.parse(widget.exchangeRate));

                        double rateCharge = newAmount;
                        setState(() =>
                            rateCharge *= (double.parse(widget.currentRate ?? '0-') / 100));

                        // Calculation - Amount
                        double updatedAmount = newAmount;
                        setState(() => updatedAmount -= rateCharge);

                        // Calculation - Wallet subtract Updated Amount
                        double updatedBalance = double.parse(widget.walletBalance!);
                        if (widget.method == Type.deposit || widget.method == Type.topUp) {
                          double convertBalance = updatedAmount;
                          setState(() =>
                              convertBalance /= double.parse(widget.exchangeRate!));
                          setState(() => updatedBalance += convertBalance);
                        } else {
                          setState(() => updatedBalance -= updatedAmount);
                        }
                        await makePayment();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Str.payWithPaystack),
                          const Gap(10),
                          Container(
                              constraints: const BoxConstraints(
                                  minWidth: 10, maxWidth: 100),
                              child: Image.asset(
                                Values.stripeLogoPath,
                                color: Styles.primaryColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                  elevatedButton(
                      color: Styles.dangerColor,
                      context: context,
                      callback: () {
                        Navigator.pop(context);
                      },
                      text: Str.back.toUpperCase()),
                ],
              ),
            ),
          ),
        ],
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

  chargeCard(String amount) async {
    Timer(const Duration(seconds: 3), () {
      _btnController.stop();
    });

    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Map accessCode = await createAccessCode(
        'sk_live_191f9699f7b137c981b6f6c2299e2adaa0b5b073',
        amount,
        userLoad.email);

    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Charge charge = Charge()
      ..amount = int.parse(amount) * 100
      ..accessCode = accessCode['data']['access_code']
      ..email = userLoad.email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method:
          CheckoutMethod.selectable, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      sendData(
        widget.amount,
        widget.currentRate,
        widget.method,
        widget.walletBalance,
        widget.walletId,
        widget.accountId,
        widget.toUserId,
        widget.toUserName,
        widget.toUserEmail,
        widget.userPhone,
        widget.message,
        widget.messageTo,
        widget.routePath,
        widget.exchangeRate,
        'PayStack',
        widget.type,
        widget.pageName,
      );
      _showDialog();
    } else {
      _showErrorDialog();
    }
  }

  //?? Stripe SETUP
  Future<void> makePayment(String amount) async {
    Timer(const Duration(seconds: 3), () {
      _btnController.stop();
    });

    try {
      paymentIntentData = await createPaymentIntent(amount, 'ngn');
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
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final price = (int.parse(amount)) * 100;
    return price.toString();
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

      sendData(
        widget.amount,
        widget.currentRate,
        widget.method,
        widget.walletBalance,
        widget.walletId,
        widget.accountId,
        widget.toUserId,
        widget.toUserName,
        widget.toUserEmail,
        widget.userPhone,
        widget.message,
        widget.messageTo,
        widget.routePath,
        widget.exchangeRate,
        'Stripe',
        widget.type,
        widget.pageName,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Paid Successfully!')));
    } on StripeException catch (e) {
      print(e.toString());
      _showErrorDialog();
    }
  }
}
