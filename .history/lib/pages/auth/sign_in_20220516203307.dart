import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:flutter_banking_app/widgets/clickable_text.dart';
import 'package:flutter_banking_app/widgets/header.dart';
import 'package:flutter_banking_app/widgets/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexpattern/src/regex_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool isCheckedTermConditions = false;
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String email = '';

  String password = '';
  SharedPref sharedPref = SharedPref();

  @override
  void initState() async {
    super.initState();
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        switch (user.userType) {
          case 'customer':
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNav(),
                ));
            break;

          case 'admin':
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNav(),
                ));
            break;

          case 'account_manager':
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNav(),
                ));
            break;

          case 'accountant':
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNav(),
                ));
            break;

          default:
        }
      }
    } catch (e) {
      print(e);
    }
  }

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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Styles.secondaryColor;
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
            // ** Logo
            const Gap(20),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(Values.logoPath),
            ),
            // ** Title
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Header(
                title: Str.loginToYourAccount,
                textStyle: GoogleFonts.nunitoSans(
                  fontSize: 24,
                  color: Styles.darkBlueColor,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(5.0),
              ),
            ),
            // ** Email address
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: NewField(
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
            // ** Password
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2),
              child: NewField(
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
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onSaved: (value) => password = value!,
                hintText: Str.password,
              ),
            ),
            // ** PRIVACY POLICY
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  // Text('I have read and agree to the Privacy Policy '),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'I have read and agree to the ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy \nPolicy',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch(
                                  'https://fvis.live/public/FVIS-PRIVACY-POLICY.pdf')) {
                                await launch(
                                    'https://fvis.live/public/FVIS-PRIVACY-POLICY.pdf');
                              } else {
                                throw 'Could not launch Privacy Policy Link';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: Values.horizontalValue * 2),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         fillColor: MaterialStateProperty.resolveWith(getColor),
            //         value: isCheckedTermConditions,
            //         onChanged: (bool? value) {
            //           setState(() {
            //             isCheckedTermConditions = value!;
            //           });
            //         },
            //       ),
            //       // Text('I have read and agree to the Terms & Condition'),
            //       RichText(
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //         text: TextSpan(
            //           children: [
            //             const TextSpan(
            //               text: 'I have read and agree to the ',
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             TextSpan(
            //               text: 'Term &\n Condition',
            //               style: const TextStyle(
            //                 fontSize: 14,
            //                 color: Colors.blue,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //               recognizer: TapGestureRecognizer()
            //                 ..onTap = () async {
            //                   if (await canLaunch(
            //                       'https://fvis.live/public/TERMS-OF-USE-SERVICES.pdf')) {
            //                     await launch(
            //                         'https://fvis.live/public/TERMS-OF-USE-SERVICES.pdf');
            //                   } else {
            //                     throw 'Could not launch Term and Condition Link';
            //                   }
            //                 },
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // ** Button SIGN IN
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2,
                  vertical: Values.verticalValue),
              child: RoundedLoadingButton(
                  controller: _btnController,
                  width: double.maxFinite,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        isChecked == true) {
                      Map<String, String> body = {
                        Field.email: email,
                        Field.password: password,
                      };
                      signIn(context, body, _btnController);
                    }
                    _btnController.stop();
                  },
                  child: Text(Str.signIn.toUpperCase()),
                  color: Styles.secondaryColor,
                  elevation: 0.0,
                  borderRadius: 7),
            ),
            // ** SIGN UP
            ClickableText(
              text: Str.createAccount,
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
            // ** Forgot Password
            // Padding(
            //   padding: const EdgeInsets.all(30.0),
            //   child: ClickableText(
            //     text: Str.forgotPassword,
            //     selectedTextColor: Styles.secondaryColor,
            //     fontSize: 14,
            //     fontWeight: FontWeight.w400,
            //     tapGestureRecognizer: TapGestureRecognizer()
            //       ..onTap = () {
            //         Navigator.pushNamed(context, RouteSTR.forgotPassword);
            //       },
            //     margin: const EdgeInsets.symmetric(
            //         horizontal: Values.horizontalValue, vertical: 5),
            //     alignment: Alignment.center,
            //   ),
            // ),
            const Gap(20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Forgot Password?',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(
                              'https://villasearch.de/fvis-bank-member-backend/public/forget-password')) {
                            await launch(
                                'https://villasearch.de/fvis-bank-member-backend/public/forget-password');
                          } else {
                            throw 'Could not launch Forgot Password Link';
                          }
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
            // _socialMedia(),
          ],
        ),
      ),
    );
  }
}
