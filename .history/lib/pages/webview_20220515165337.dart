import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/wallet_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking_app/widgets/back_event_notifier.dart';

class WebPage extends StatefulWidget {
  const WebPage({ Key? key, required this.initialUrl, 
      required this.amount,
      this.paymentMethod, 
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
      this.userId }) : super(key: key);

  final String initialUrl;
  final String? 
      paymentMethod,
      method,
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
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  late WebViewController _control;
  GlobalKey _globalKey = GlobalKey();

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

  void sendData() {
    double newAmount = double.parse(widget.amount);
    setState(() => newAmount *= double.parse(widget.exchangeRate!));

    double rateCharge = newAmount;
    setState(() => rateCharge *= (double.parse(widget.currentRate!) / 100));

    // Calculation - Amount
    double updatedAmount = newAmount;
    setState(() => updatedAmount -= rateCharge);

    // Calculation - Wallet subtract Updated Amount
    double updatedBalance = double.parse(widget.walletBalance!);
    if (widget.method == Type.deposit || widget.method == Type.topUp) {
      double convertBalance = updatedAmount;
      setState(() => convertBalance /= double.parse(widget.exchangeRate!));
      setState(() => updatedBalance += convertBalance);
    } else {
      setState(() => updatedBalance -= updatedAmount);
    }

    switch (widget.method) {
      case 'send_money':
        emailMessage =
            'Send Money You have just send ${double.parse(widget.amount).toStringAsFixed(2)} to ${widget.toUserName}.';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo =
            'Send Money You have just received ${double.parse(widget.amount).toStringAsFixed(2)} from $userName.';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'exchange_money':
        emailMessage =
            'Exchange Money You have just exchanged ${double.parse(widget.amount).toStringAsFixed(2)} from your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'wire_transfer':
        emailMessage =
            'Wire Transfer You have just transferred ${double.parse(widget.amount).toStringAsFixed(2)} into your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'top_up':
        emailMessage =
            'Top-Up Wallet You have just top-up ${double.parse(widget.amount).toStringAsFixed(2)} into your account.';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case 'sms_subcribed':
        emailMessage =
            'Congratulations, You have subcribed to SMS Notification. FVIS Investment ';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      case Field.topUpAccountant:
        emailMessage =
            'Wallet Transaction Your account has been credited ${double.parse(widget.amount).toStringAsFixed(2)}.';
        emailMessage01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessage02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessage03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        emailMessageTo = '';
        emailMessageTo01 =
            'Amount: NGN ${double.parse(widget.amount).toStringAsFixed(2)} ';
        emailMessageTo02 =
            'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
        emailMessageTo03 =
            'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
        break;
      default:
    }

    Map<String, String> body = {
      Field.userId: widget.userId ?? userId ?? '0',
      Field.walletId: widget.walletId ?? '0',
      Field.accountId: widget.accountId ?? '0',
      Field.method: widget.method ?? 'default',
      Field.creditDebit: widget.method ?? 'default',
      Field.amount: double.parse(widget.amount).toStringAsFixed(2),
      Field.rateAmount: rateCharge.toStringAsFixed(2),
      Field.grandTotal: updatedAmount.toStringAsFixed(2),
      Field.paymentMethod: widget.paymentMethod!,
      Field.currentRate: widget.currentRate ?? '0',
      Field.updatedBy: userId ?? '0',
      Field.currencyId: widget.currencyId ?? '10',
      Field.transactionCode: Field.transactionCodeInitials +
          '${widget.currencyName}-' +
          getRandomString(6),
    };

    Map<String, String> toUserBody = {
      Field.userId: widget.toUserId ?? '0',
      Field.walletId: widget.walletId ?? '0',
      Field.accountId: widget.accountId ?? '0',
      Field.method: widget.method ?? 'default',
      Field.creditDebit: widget.method ?? 'default',
      Field.amount: double.parse(widget.amount).toStringAsFixed(2),
      Field.rateAmount: rateCharge.toStringAsFixed(2),
      Field.grandTotal: updatedAmount.toStringAsFixed(2),
      Field.paymentMethod: widget.paymentMethod!,
      Field.updatedBy: widget.toUserId ?? '0',
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: const Text('Payment Method'),
        ),
        body: WebView(
          initialUrl: widget.initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) {
            _control = webViewController;
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: {
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            var redirectUrl = 'https://villasearch.de/pay/public/redirect';

            if (url.contains(redirectUrl)) {
              var uri = Uri.dataFromString(url);
              var paid = uri.pathSegments.contains('paid=');
              if (paid.toString() == 'true') {
                Navigator.popAndPushNamed(context, RouteSTR.success);
              } else {
                Navigator.popAndPushNamed(context, RouteSTR.failed);
              }
            }
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Future<bool> _onBack() async {
    bool goBack;

    var value = await _control.canGoBack(); // check webview can go back

    if (value) {
      _control.goBack(); // perform webview back operation

      return false;
    } else {
      late BackEventNotifier? _notifier;
      await showDialog(
          context: _globalKey.currentState!.context,
          builder: (context) =>
              Consumer(builder: (context, BackEventNotifier event, child) {
                _notifier = event;
                return AlertDialog(
                  title: const Text('Confirmation ',
                      style: TextStyle(color: Colors.purple)),
                  content: const Text('Do you want exit app ? '),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        event.add(false);
                      },

                      child: Text("No"), // No
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        event.add(true);
                      },
                      child: Text("Yes"), // Yes
                    ),
                  ],
                );
              }));

      //Navigator.pop(_globalKey.currentState!.context);
      print("_notifier.isBack ${_notifier!.isBack}");
      return _notifier!.isBack;
    }
  }
}