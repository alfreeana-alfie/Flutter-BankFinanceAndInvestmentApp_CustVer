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
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
  bool _autoValidate = false;

  static final validCharacters = RegExp(r'^[a-zA-Z0-9&%=]+$');

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
        autovalidateMode: AutovalidateMode.values,
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
                validator: (value) {
                  return (value == null || !value.contains(charac))
                      ? 'Please enter valid name'
                      : 'Valid Name';
                },
                // suffixIcon: _formKey.currentState!.validate() ? Icon(Icons.read_more) : Icon(Icons.exit_to_app),
                // suffixIconColor: _formKey.currentState!.validate() ? Styles.successColor : Styles.dangerColor,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
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
                validator: (value) {
                  return (value == null || !value.contains('$charac@'))
                      ? 'Please enter valid email address'
                      : 'Valid Email Address';
                },
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
                        if (value == null) {
                          return 'Empty Phone number';
                        } else if (!value.contains(numeric)) {
                          return 'Invalid phone Number';
                        }
                        return '';
                      },
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
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
                      _formKey.currentState.save();
                    } else {
//    If all data are not valid then start auto validation.
                      setState(() {
                        _autoValidate = true;
                      });
                    }

                    _btnController.stop();
                    // Map<String, String> body = {
                    //   Field.name: name,
                    //   Field.email: email,
                    //   Field.phone: phoneNo,
                    //   Field.userType: Field.customerTxt,
                    //   Field.password: password,
                    //   Field.status: Status.pending.toString(),
                    // };
                    // if (confirmPassword == password) {
                    //   signUp(context, body, _btnController);
                    // } else {
                    //   CustomToast.showMsg(
                    //       'Invalid Confirm Password!', Styles.dangerColor);
                    // }
                  },
                  child: Text(Str.createMyAccountTxt.toUpperCase()),
                  color: Styles.secondaryColor,
                  elevation: 0.0,
                  borderRadius: 7),
            ),
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
