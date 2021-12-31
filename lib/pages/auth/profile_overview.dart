import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({Key? key}) : super(key: key);

  @override
  _ProfileOverviewState createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  String? name, email, phone, branchId, emailVerifiedAt, smsVerifiedAt;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        userLoad = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     print(_scrollController.offset);
  //   });
  //   super.initState();
  //   loadSharedPrefs();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.profileOverviewTxt,
        implyLeading: true,
        context: context,
        onPressedBack: () => Navigator.pop(context),
      ),
      body: _innerContainer(),
    );
  }

  _innerContainer() {
    return FutureBuilder(
      future: loadSharedPrefs(),
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
            DateTime emailtempDate =
                DateTime.parse(userLoad.emailVerifiedAt ?? '-');
            String emailVerifiedAt =
                DateFormat('yyyy-MM-dd hh:mm:ss').format(emailtempDate);

            // DateTime smstempDate =
            //     DateTime.parse(userLoad.smsVerifiedAt ?? '-');
            // String smsVerifiedAt =
            //     DateFormat('yyyy-MM-dd hh:mm:ss').format(smstempDate);

            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Styles.accentColor,
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
                            // const Gap(20.0),
                            TextFormField(
                              initialValue: userLoad.name,
                              onChanged: (val) {
                                name = val;
                              },
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
                              initialValue: userLoad.email,
                              onChanged: (val) {
                                email = val;
                              },
                              style: Styles.subtitleStyle,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
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
                              initialValue: userLoad.phone,
                              onChanged: (val) {
                                phone = val;
                              },
                              style: Styles.subtitleStyle,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
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
                            const Gap(20.0),

                            TextFormField(
                              initialValue: userLoad.branchId ?? 'Default',
                              onChanged: (val) {
                                branchId = val;
                              },
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
                              readOnly: true,
                              initialValue: emailVerifiedAt,
                              onChanged: (val) {
                                emailVerifiedAt = val;
                              },
                              style: Styles.subtitleStyle,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: Str.emailVerifiedAtTxt,
                                labelStyle: Styles.subtitleStyle,
                                hintText: Str.emailVerifiedAtTxt,
                                hintStyle: Styles.subtitleStyle03,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  gapPadding: 0.0,
                                ),
                              ),
                            ),
                            const Gap(20.0),
                            TextFormField(
                              readOnly: true,
                              initialValue: userLoad.smsVerifiedAt ?? 'NO',
                              onChanged: (val) {
                                smsVerifiedAt = val;
                              },
                              style: Styles.subtitleStyle,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: Str.smsVerifiedAtTxt,
                                labelStyle: Styles.subtitleStyle,
                                hintText: Str.smsVerifiedAtTxt,
                                hintStyle: Styles.subtitleStyle03,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  gapPadding: 0.0,
                                ),
                              ),
                            ),
                            // const Gap(20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Gap(20),
                // elevatedButton(
                //   color: Styles.secondaryColor,
                //   context: context,
                //   callback: () {},
                //   text: Str.saveTxt.toUpperCase(),
                // ),
              ],
            );
          }
        }
      },
    );
  }
}
