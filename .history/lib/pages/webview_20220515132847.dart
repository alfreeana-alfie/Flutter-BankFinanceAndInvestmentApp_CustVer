import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking_app/widgets/back_event_notifier.dart';

class Webpage extends StatelessWidget {
  Webpage(
      {Key? key,
      required this.loan,
      required this.loanList,
      required this.index})
      : super(key: key);
  late WebViewController _control;


  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text('Webview Back Button '),
        ),
        body: WebView(
          initialUrl: 'https://www.billplz.com/bills/rs1x6nzm',
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

            if(url.contains(redirectUrl)){
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
