import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/constant/app_color.dart';
import 'package:flutter_banking_app/constant/constants.dart';
import 'package:flutter_banking_app/constant/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/clickable_text.dart';
import 'package:flutter_banking_app/widgets/gradient_button.dart';
import 'package:flutter_banking_app/widgets/password_text_field.dart';
import 'package:flutter_banking_app/widgets/text_field.dart';
import 'package:flutter_banking_app/widgets/title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              colors: [primaryColor, primaryColor]),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [primaryColor, primaryColor]),
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
      color: Styles.primaryColor,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTitle(
              title: signInText.toUpperCase(),
              textStyle: GoogleFonts.roboto(
                  fontSize: 32, color: textColor, fontWeight: FontWeight.w800),
              alignment: Alignment.topCenter,
              margin: defaultMargin,
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
              hintText: emailHintText,
            ),
            CustomTitle(
              title: passwordText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomPassword(
              onSaved: (value) => password = value!,
              hintText: passwordHintText,
              isObsecureText: true,
            ),
            ClickableText(
              alignment: Alignment.centerLeft,
              text: forgotPasswordText,
              selectedTextColor: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              tapGestureRecognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/forgot');
                },
              margin: const EdgeInsets.symmetric(
                  horizontal: horizontalValue, vertical: 5),
            ),
            GradientButton(
              beginColorAlignment: Alignment.topLeft,
              endColorAlignment: Alignment.bottomRight,
              colorList: const [greenSecondColor, greenFirstColor],
              onPressed: () {
                // signIn(email, password, context);
              },
              child: Text(
                signInText,
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              margin: defaultMargin,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 150, vertical: verticalValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildDivider(),
                  CustomTitle(
                    alignment: Alignment.topCenter,
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black12),
                    title: 'OR',
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                  buildDivider(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  signupForAccount,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                ClickableText(
                  alignment: Alignment.centerLeft,
                  text: signUpText,
                  selectedTextColor: greenFirstColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  tapGestureRecognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                  margin: const EdgeInsets.symmetric(
                      horizontal: horizontalValue, vertical: 5),
                ),
              ],
            )
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
