import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FailedPage extends StatelessWidget {
  const FailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        backgroundColor: Styles.primaryColor,
        body: Dialog(
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
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Failed to process payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Error in processing payment, please try again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!kIsWeb) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const BottomNav()));
                        } else {
                          SystemNavigator.pop();
                        }
                      },
                      child: const Text(
                        'PROCEED',
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Styles.secondaryColor, elevation: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
