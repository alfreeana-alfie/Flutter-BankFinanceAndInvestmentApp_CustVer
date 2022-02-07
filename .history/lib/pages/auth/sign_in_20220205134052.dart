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
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
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

  Future check() async {
    try {
      String? expiredAt = await sharedPref.read(Pref.expiredAt);

      User user = User.fromJSON(await sharedPref.read(Pref.userData));

      DateTime expires = DateTime.parse(expiredAt!);

      print(expires);

      // if (expiredAt.isNotEmpty) {
      //   // if (expires.compareTo(now) < 0) {
      //     if (user.userType == Field.customerTxt) {
      //       Navigator.pushNamed(context, RouteSTR.dashboardMember);
      //     } else {
      //       Navigator.pushNamed(context, RouteSTR.dashboardAdmin);
      //     }
      //   // }
      // } else {
      //   Navigator.pushNamed(context, RouteSTR.signIn);
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Values.loginBgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: _innerContainer(),
        ),
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
            SizedBox(
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
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: TextFieldCustom(
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
              child: RoundedLoadingButton(
                controller: _btnController,
                onPressed: () {
                  // Navigator.pushNamed(context, RouteSTR.dashboardAdmin);
                  Map<String, String> body = {
                    Field.email: email,
                    Field.password: password,
                  };

                  signIn(context, body, _btnController);
                },
                child: Text(Str.signInTxt.toUpperCase()),
                color: Styles.secondaryColor,
                elevation: 0.0,
                borderRadius: 7
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
    return FutureBuilder(
      future: check(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Styles.accentColor,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
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
      },
    );
  }
}
