import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/clickable_text.dart';
import 'package:bank_fvisng_admin/widgets/header_1.dart';
import 'package:bank_fvisng_admin/widgets/text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String countryCode = ''; // Change to drop down
  String phoneNo = '';
  String password = '';
  String confirmPassword = '';

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
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Header1(
                title: Str.signUpTxt,
                textStyle: GoogleFonts.nunitoSans(
                  fontSize: 22,
                  color: Styles.darkBlueColor,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(5.0),
              ),
            ),
            // Name
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                onSaved: (value) => name = value!,
                hintText: Str.nameTxt,
              ),
            ),
            // Email address
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                onSaved: (value) => email = value!,
                hintText: Str.emailTxt,
              ),
            ),
            // Country Code + Phone No
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: CountryCodePicker(
                        onChanged: (value) {
                          setState(() {
                            countryCode = value.toString();
                          });
                        },
                        onInit: (value) {
                          countryCode = value.toString();
                        },
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: '+60',
                        // favorite: ['+60','MS'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                        padding: EdgeInsets.all(12),
                        dialogSize: Size(350, 450),
                        textStyle: GoogleFonts.nunitoSans(
                          color: Styles.textColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFieldCustom(
                      onSaved: (value) => phoneNo = value!,
                      hintText: Str.phoneNumberTxt,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                onSaved: (value) => password = value!,
                hintText: Str.passwordTxt,
              ),
            ),
            // Confirm Password
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                onSaved: (value) => confirmPassword = value!,
                hintText: Str.confirmTxt,
              ),
            ),
            // Button Sign In
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: ElevatedButton(
                onPressed: () {
                  print(countryCode);
                },
                child: Text(Str.createMyAccountTxt),
                style: ElevatedButton.styleFrom(
                  primary: Styles.secondaryColor,
                  elevation: 0.0,
                ),
              ),
            ),
            // Button Sign Up
            Padding(
              padding: const EdgeInsets.only(
                left: Values.horizontalValue * 2,
                right: Values.horizontalValue * 2,
                top: 30, 
                bottom: 30,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Str.alreadyHaveAnAccTxt,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Styles.textColor,
                    ),
                  ),
                  ClickableText(
                    text: Str.signInTxt,
                    selectedTextColor: Styles.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    tapGestureRecognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/sign_in');
                      },
                    margin: const EdgeInsets.symmetric(
                        horizontal: Values.horizontalValue, vertical: 5),
                    alignment: Alignment.center,
                  ),
                ],
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
