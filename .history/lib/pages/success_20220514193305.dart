import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
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
                  Icon(
                    Icons.check_box,
                    color: Styles.successColor,
                    size: 90,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Payment Completed!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Please allow a few minutes to allow ',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text('the payment updated in your account', style: TextStyle(fontSize: 13)),
                  const Gap(10),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNac))
                  }, child: Text('Proceed')),
                ],
              ),
            ),
          ),
        ));
  }
}
