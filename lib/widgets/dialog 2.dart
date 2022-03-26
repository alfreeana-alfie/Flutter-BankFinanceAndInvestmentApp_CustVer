import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';

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
              color: Styles.successColor,
              size: 90,
            ),
            SizedBox(height: 15),
            Text(
              'Registration Successfully',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'been made',
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 17.0,
            //       fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 15),
            Text(
              'Your may proceed to Sign in',
              style: TextStyle(fontSize: 13),
            ),
            Text('into your account', style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    ),
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

Dialog verifyEmailDialog(context) {
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
              Icons.close,
              color: Styles.dangerColor,
              size: 90,
            ),
            SizedBox(height: 15),
            Text(
              'Please verify your email',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'been made',
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 17.0,
            //       fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 15),
            Text(
              'Before proceed sign in to the app.',
              style: TextStyle(fontSize: 13),
            ),
            // Text('into your account', style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    ),
  );
}
