import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_shop/constant/app_color.dart';
import 'package:local_shop/constant/constants.dart';
import 'package:local_shop/constant/string.dart';
import 'package:local_shop/widgets/clickable_text.dart';
import 'package:local_shop/widgets/gradient_button.dart';
import 'package:local_shop/widgets/password_text_field.dart';
import 'package:local_shop/widgets/text_field.dart';
import 'package:local_shop/widgets/title.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String address1 = '';
  String address2 = '';
  String postCode = '';
  String division = '';
  String district = '';
  String state = '';

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
              title: signUpText.toUpperCase(),
              textStyle: GoogleFonts.roboto(
                  fontSize: 32, color: textColor, fontWeight: FontWeight.w800),
              alignment: Alignment.topCenter,
              margin: defaultMargin,
            ),
            CustomTitle(
              title: nameText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => name = value!,
              hintText: nameHintText,
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
            CustomTitle(
              title: confirmPasswordText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomPassword(
              onSaved: (value) => confirmPassword = value!,
              hintText: passwordHintText,
              isObsecureText: true,
            ),
            CustomTitle(
              title: addr1Text,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => address1 = value!,
              hintText: addr1HintText,
            ),
            CustomTitle(
              title: addr2Text,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => address2 = value!,
              hintText: addr2HintText,
            ),
            CustomTitle(
              title: postcodeText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => postCode = value!,
              hintText: postcodeHintText,
            ),
            CustomTitle(
              title: divisionText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => division = value!,
              hintText: divisionHintText,
            ),
            CustomTitle(
              title: districtText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => district = value!,
              hintText: districtHintText,
            ),
            CustomTitle(
              title: stateText,
              textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: greenFirstColor,
                  fontWeight: FontWeight.w500),
              alignment: Alignment.centerLeft,
              margin: marginLabel,
            ),
            CustomTextField(
              onSaved: (value) => state = value!,
              hintText: stateHintText,
            ),
            GradientButton(
              beginColorAlignment: Alignment.topLeft,
              endColorAlignment: Alignment.bottomRight,
              colorList: const [greenSecondColor, greenFirstColor],
              onPressed: () {
                // print(email);
              },
              child: Text(
                signInText,
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              margin: defaultMargin,
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(
            //       horizontal: 150, vertical: verticalValue),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       buildDivider(),
            //       CustomTitle(
            //         alignment: Alignment.topCenter,
            //         textStyle: GoogleFonts.roboto(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 12,
            //             color: Colors.black12),
            //         title: 'OR',
            //         margin: const EdgeInsets.symmetric(horizontal: 0),
            //       ),
            //       buildDivider(),
            //     ],
            //   ),
            // ),
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
