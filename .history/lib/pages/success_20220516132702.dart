import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:gap/gap.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

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
                    Icons.check_box,
                    color: Styles.successColor,
                    size: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Payment Completed!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Please allow a few minutes to allow ',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Text('the payment updated in your account',
                      style: TextStyle(fontSize: 13)),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomNav()));
                            
                      },
                      child: const Text(
                        'PROCEED',
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Styles.secondaryColor,
                        elevation: 0.1
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
