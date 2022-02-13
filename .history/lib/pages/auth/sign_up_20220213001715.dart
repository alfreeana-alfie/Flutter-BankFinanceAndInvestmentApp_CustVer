import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/clickable_text.dart';
import 'package:flutter_banking_app/widgets/header_1.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String name = '';
  String email = '';
  String countryCode = '';
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
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
      decoration: BoxDecoration(
        color: Styles.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.always,
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
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Header1(
                title: Str.signUp,
                textStyle: GoogleFonts.nunitoSans(
                  fontSize: 22,
                  color: Styles.darkBlueColor,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(5.0),
              ),
            ),
            // ** Name
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Empty Name';
                  }
                  if (value.trim().length < 4) {
                    return 'Name must be at least 4 characters in length';
                  }
                  if (!value.isAlphabet()) {
                    return 'Invalid Name';
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onSaved: (value) => name = value!,
                hintText: Str.name,
              ),
            ),
            // **  Email address
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
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
                hintText: Str.email,
              ),
            ),
            // **  Country Code + Phone No
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
                        padding: const EdgeInsets.all(12),
                        dialogSize: const Size(350, 450),
                        textStyle: GoogleFonts.nunitoSans(
                          color: Styles.textColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFieldCustom(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Empty Phone Number';
                        }
                        if (value.isPhone() && value.length < 4) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => phoneNo = value!,
                      hintText: Str.phoneNumber,
                    ),
                  ),
                ],
              ),
            ),
            // ** Password
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
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
                hintText: Str.password,
              ),
            ),
            // ** Confirm Password
            Padding(
              padding: const EdgeInsets.only(
                  left: Values.horizontalValue * 2,
                  right: Values.horizontalValue * 2,
                  bottom: 10),
              child: TextFieldCustom(
                obsecure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Empty Confirm Password';
                  }

                  if (value != password && value.trim().length < 8) {
                    return 'Confimation password does not match the entered password';
                  }

                  return null;
                },
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onSaved: (value) => confirmPassword = value!,
                hintText: Str.confirm,
              ),
            ),
            // ** Button SIGN UP
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: RoundedLoadingButton(
                  controller: _btnController,
                  width: double.maxFinite,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      Map<String, String> body = {
                        Field.name: name,
                        Field.email: email,
                        Field.phone: phoneNo,
                        Field.userType: Field.customer,
                        Field.password: password,
                        Field.status: Status.pending.toString(),
                      };

                      signUp(context, body, _btnController);
                      EmailJS.verifyEmail(context, name,
                          'https://villasearch.de/fvis-bank-member-backend/public/api/verification/$name');
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        Navigator.pushReplacementNamed(
                            context, RouteSTR.signIn);
                      });
                    }

                    _btnController.stop();
                  },
                  child: Text(Str.createMyAccount.toUpperCase()),
                  color: Styles.secondaryColor,
                  elevation: 0.0,
                  borderRadius: 7),
            ),
            // ** Button SIGN IN
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
                    Str.alreadyHaveAnAcc,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Styles.textColor,
                    ),
                  ),
                  ClickableText(
                    text: Str.signIn,
                    selectedTextColor: Styles.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    tapGestureRecognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, RouteSTR.signIn);
                      },
                    margin: const EdgeInsets.symmetric(
                        horizontal: Values.horizontalValue, vertical: 5),
                    alignment: Alignment.center,
                  ),
                ],
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
}
