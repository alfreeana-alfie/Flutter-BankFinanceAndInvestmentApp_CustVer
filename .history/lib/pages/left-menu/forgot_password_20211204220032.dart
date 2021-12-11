import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_shop/constant/app_color.dart';
import 'package:local_shop/constant/constants.dart';
import 'package:local_shop/constant/string.dart';
import 'package:local_shop/widgets/clickable_text.dart';
import 'package:local_shop/widgets/gradient_button.dart';
import 'package:local_shop/widgets/text_field.dart';
import 'package:local_shop/widgets/title.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        elevation: 0.0,
        gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [greenSecondColor, greenFirstColor]),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [greenSecondColor, greenFirstColor]),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [secondContainer()],
          ),
        ),
      ),
    );
  }

  Widget secondContainer() {
    return Container(
      margin: const EdgeInsets.only(top: homeSecondContainer),
      color: primaryColor,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTitle(
              title: forgotPasswordText.toUpperCase(),
              textStyle: GoogleFonts.roboto(
                  fontSize: 32, color: textColor, fontWeight: FontWeight.w800),
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(
                  left: horizontalValue,
                  right: horizontalValue,
                  top: verticalValue,
                  bottom: 20),
            ),
            CustomTitle(
              title: emailText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => email = value!,
              hintText: emailHintText
            ),
            GradientButton(
              beginColorAlignment: Alignment.topLeft,
              endColorAlignment: Alignment.bottomRight,
              colorList: const [greenSecondColor, greenFirstColor],
              onPressed: () {
                // print(email);
              },
              child: Text(
                verifyText,
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              margin: defaultMargin,
            ),
            Container(
              margin: marginGotoSignIn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signInToAccount,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                  ClickableText(
                    alignment: Alignment.centerLeft,
                    text: signInText,
                    selectedTextColor: greenFirstColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    tapGestureRecognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // print('Forgot Password');
                      },
                    margin: const EdgeInsets.symmetric(
                        horizontal: horizontalValue, vertical: 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Expanded(
      child: Divider(
          height: 2,
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: Colors.black12),
    );
  }
}
