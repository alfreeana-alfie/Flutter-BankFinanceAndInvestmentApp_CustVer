import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/clickable_text.dart';
import 'package:flutter_banking_app/widgets/header_1.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexpattern/src/regex_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String email = '';
  String password = '';

  SharedPref sharedPref = SharedPref();

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
        child: _innerContainer(),
      ),
    );
  }

  _buildForm() {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
      decoration: BoxDecoration(
        color: Styles.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            const Gap(20),
            SizedBox(
              width: 80,
              height: 80,
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
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: TextFieldCustom(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Empty Email Address';
                  }
                  if (!value.isEmail()) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) => email = value!,
                hintText: Str.emailTxt,
              ),
            ),
            // Password
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2),
              child: TextFieldCustom(
                obsecure: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Empty Password';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  return null;
                },
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onSaved: (value) => password = value!,
                hintText: Str.passwordTxt,
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  // horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> body = {
                        Field.email: email,
                        Field.password: password,
                      };
                      signIn(context, body, _btnController);
                    }
                    _btnController.stop();
                  },
                  child: Text(Str.signInTxt.toUpperCase()),
                  color: Styles.secondaryColor,
                  elevation: 0.0,
                  borderRadius: 7),
            ),
            ClickableText(
              text: Str.createAccountTxt,
              selectedTextColor: Styles.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              tapGestureRecognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.signUp);
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
                    Navigator.pushNamed(context, RouteSTR.forgotPassword);
                  },
                margin: const EdgeInsets.symmetric(
                    horizontal: Values.horizontalValue, vertical: 5),
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _innerContainer() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildForm(),
          ],
        ),
      ),
    );
  }
}
