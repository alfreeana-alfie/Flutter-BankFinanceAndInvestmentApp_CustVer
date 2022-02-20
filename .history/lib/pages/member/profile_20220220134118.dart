import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/json/shortcut_list.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/no_back_add_appbar.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:gap/gap.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name, email;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        name = user.name;
        email = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: noBackAddAppBar(title: '', implyLeading: true, context: context),
      body: _innerContainer(),
    );
  }

  Widget customListTile(
      {required IconData icon,
      required String title,
      VoidCallback? callback,
      required Color color,
      bool? isDarkMode,
      BuildContext? context,
      required String type, 
      String? routePath,
      required String pageName, 
      Widget? path
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: InkWell(
        child: Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Styles.primaryWithOpacityColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        onTap: () => Navigator.of(context!).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: type,
                        routePath: routePath,
                        pageName: pageName,
                        path: path,
                      ),
                    ),
                  ),
      ),
      minLeadingWidth: 50,
      horizontalTitleGap: 13,
      title: Text(title,
          style: const TextStyle(fontSize: 17, color: Styles.textColor)),
      trailing: isDarkMode == true
          ? CupertinoSwitch(
              // trackColor: Styles.blueColor,
              activeColor: Styles.accentColor,
              trackColor: Styles.accentColor,
              value: true,
              onChanged: (v) {},
            )
          : Icon(CupertinoIcons.arrow_right,
              color: Styles.accentColor.withOpacity(0.7)),
      onTap: callback,
    );
  }

  Widget signOut(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: InkWell(
        child: Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Styles.primaryWithOpacityColor,
            shape: BoxShape.circle,
          ),
          child:
              const Icon(IconlyBold.Logout, color: Color(0xFF229e76), size: 18),
        ),
        onTap: () => Navigator.pushNamed(context, RouteSTR.signIn),
        // onTap: () => signOut(context),
      ),
      minLeadingWidth: 50,
      horizontalTitleGap: 13,
      title: const Text('Sign Out',
          style: TextStyle(fontSize: 17, color: Styles.textColor)),
      trailing: Icon(CupertinoIcons.arrow_right,
          color: Styles.accentColor.withOpacity(0.7)),
      // onTap: callback,
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
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const Gap(40),
                Stack(
                  children: [
                    Container(
                      height: 280,
                      alignment: Alignment.bottomCenter,
                      color: Styles.primaryColor,
                      child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Styles.accentColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Gap(60),
                            Center(
                                child: Text(name ?? Field.emptyString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25))),
                            const Gap(10),
                            Text(email ?? Field.emptyString,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7))),
                            const Gap(25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: profilesShortcutList.map<Widget>((e) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, RouteSTR.profileOverview),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.all(13),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(e['icon'], color: e['color']),
                                  ),
                                );
                              }).toList(),
                            ),
                            const Gap(25)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      right: 30,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE486DD),
                        ),
                        child: Transform.scale(
                          scale: 0.55,
                          child: Container(
                            width: 100,
                            height: 100,
                            constraints: const BoxConstraints(
                                minWidth: 20, maxWidth: 70),
                            child: CircleAvatar(
                              // backgroundImage: AssetImage(Values.userPath),
                              backgroundImage:
                                  NetworkImage(Values.userDefaultImage),
                              minRadius: 10,
                              maxRadius: 40,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(35),
                customListTile(
                    icon: IconlyBold.User,
                    color: const Color(0xFF064c6d),
                    title: Str.supportTicket,
                    context: context,
                    type: Type.ticket,
                    routePath),
                signOut(context),
              ],
            );
          }
        }
      },
    );
  }
}
