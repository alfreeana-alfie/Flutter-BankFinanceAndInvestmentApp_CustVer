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
              child: Header1(
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
            // ** Password
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
                    if (_formKey.currentState!.validate() && isChecked == true) {
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClickableText(
                text: Str.forgotPassword,
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

  _socialMedia() {
    return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Running on: $_platformVersion\n',
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  onPressed: () async {
                    final file = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    SocialShare.shareInstagramStory(
                      file.path,
                      backgroundTopColor: "#ffffff",
                      backgroundBottomColor: "#000000",
                      attributionURL: "https://deep-link-url",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share On Instagram Story"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      final directory = await getApplicationDocumentsDirectory();
                      final file = await File('${directory.path}/temp.png').create();
                      await file.writeAsBytes(image);

                      SocialShare.shareInstagramStory(
                        file.path,
                        backgroundTopColor: "#ffffff",
                        backgroundBottomColor: "#000000",
                        attributionURL: "https://deep-link-url",
                        backgroundImagePath: file.path,
                      ).then((data) {
                        print(data);
                      });
                    });
                  },
                  child: Text("Share On Instagram Story with background"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      final directory = await getApplicationDocumentsDirectory();
                      final file = await File('${directory.path}/temp.png').create();
                      await file.writeAsBytes(image);
                      //facebook appId is mandatory for andorid or else share won't work
                      Platform.isAndroid
                          ? SocialShare.shareFacebookStory(
                        file.path,
                        "#ffffff",
                        "#000000",
                        "https://google.com",
                        appId: "xxxxxxxxxxxxx",
                      ).then((data) {
                        print(data);
                      })
                          : SocialShare.shareFacebookStory(
                        file.path,
                        "#ffffff",
                        "#000000",
                        "https://google.com",
                      ).then((data) {
                        print(data);
                      });
                    });
                  },
                  child: Text("Share On Facebook Story"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.copyToClipboard(
                      "This is Social Share plugin",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Copy to clipboard"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTwitter(
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareSms(
                      "This is Social Share Sms example",
                      url: "\nhttps://google.com/",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Sms"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      SocialShare.shareOptions("Hello world").then((data) {
                        print(data);
                      });
                    });
                  },
                  child: Text("Share Options"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Whatsapp"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTelegram(
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Telegram"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.checkInstalledAppsForShare().then((data) {
                      print(data.toString());
                    });
                  },
                  child: Text("Get all Apps"),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
