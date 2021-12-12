import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({Key? key}) : super(key: key);

  @override
  _ProfileOverviewState createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();

  User userLoad = User();

  loadSharedPrefs() async {
    try {
      User user = User.from(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // do something
    }
  }
  
  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.newRequestTxt, implyLeading: true, context: context),
      bottomSheet: Container(
        color: Styles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: elevatedButton(
          color: Styles.secondaryColor,
          context: context,
          callback: () {},
          text: Str.newRequestTxt.toUpperCase(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Styles.primaryWithOpacityColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.nameTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.nameTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.emailTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.emailTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.phoneNumberTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.phoneNumberTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.branchTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.branchTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: UserSTR.emailVerifiedTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: UserSTR.emailVerifiedTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        // readOnly: true,
                        onChanged: (val) {},
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: UserSTR.smsVerifiedTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: UserSTR.smsVerifiedTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.vertical(
                //       bottom: Radius.circular(15),
                //     ),
                //     color: Styles.yellowColor,
                //   ),
                //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                //   child: TextFormField(
                //     onChanged: (val) {},
                //     style: Styles.subtitleStyleDark,
                //     textInputAction: TextInputAction.done,
                //     keyboardType: TextInputType.number,
                //     maxLines: 1,
                //     decoration: InputDecoration(
                //       labelText: Str.descriptionTxt,
                //       labelStyle: Styles.subtitleStyleDark02,
                //       hintText: Str.descriptionTxt,
                //       hintStyle: Styles.subtitleStyleDark03,
                //       border: const OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         gapPadding: 0.0,
                //       ),
                //     ),
                //   ),
                // ),
                // const Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customColumn({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(),
            style:
                TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
        const Gap(2),
        Text(subtitle,
            style:
                TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8))),
      ],
    );
  }
}
