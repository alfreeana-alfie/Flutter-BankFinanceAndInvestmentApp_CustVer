import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/clickable_text.dart';
import 'package:bank_fvisng_admin/widgets/header_1.dart';
import 'package:bank_fvisng_admin/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Values.loginBgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Container(
              width: 150,
              height: 150,
              child: Image.asset(Values.logoPath),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Header1(
                title: Str.loginToYourAccountTxt,
                textStyle: GoogleFonts.nunitoSans(
                  fontSize: 24,
                  color: Styles.darkBlueColor,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(5.0),
              ),
            ),
            // Email address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Values.horizontalValue*2, vertical: Values.verticalValue),
              child: TextFieldCustom(
                onSaved: (value) => email = value!,
                hintText: Str.emailTxt,
              ),
            ),
            // Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Values.horizontalValue*2),
              child: TextFieldCustom(
                onSaved: (value) => password = value!,
                hintText: Str.passwordTxt,
              ),
            ),
            // Remember Me
            // Button Sign In
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(Str.signInTxt),
                style: ElevatedButton.styleFrom(
                  primary: Styles.secondaryColor,
                  elevation: 0.0,
                ),
              ),
            ),
            // Button Sign Up
            ClickableText(
              text: Str.createAccountTxt,
              selectedTextColor: Styles.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              tapGestureRecognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/sign_up');
                },
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue, vertical: 5),
              alignment: Alignment.center,
            ),
            // Forgot Password
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClickableText(
                text: Str.forgotPasswordTxt,
                selectedTextColor: Styles.secondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                tapGestureRecognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                margin: const EdgeInsets.symmetric(
                    horizontal: Values.horizontalValue, vertical: 5),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
