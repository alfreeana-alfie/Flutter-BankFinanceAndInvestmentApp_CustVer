import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/json/shortcut_list.dart';
import 'package:flutter_banking_app/json/transactions.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/balance_box.dart';
import 'package:flutter_banking_app/widgets/left_menu_member.dart';
import 'package:gap/gap.dart';

class MemberDasboard extends StatefulWidget {
  const MemberDasboard({Key? key}) : super(key: key);

  @override
  _MemberDasboardState createState() => _MemberDasboardState();
}

class _MemberDasboardState extends State<MemberDasboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  SharedPref sharedPref = SharedPref();

  String? userName;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if(mounted) {
        userName = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // final size = Layouts.getSize(context);
    return Material(
      color: Styles.primaryColor,
      elevation: 0,
      child: Scaffold(
        drawer: const SideDrawerMember(),
        body: _innerContainer(),
      ),
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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Gap(getProportionateScreenHeight(50)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.transparentColor,
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Styles.accentColor,
                        ),
                      ),
                    ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi $userName',
                                style: const TextStyle(
                                    color: Styles.textColor, fontSize: 16)),
                            const Gap(3),
                            Text(Str.welcomeBackTxt,
                                style: const TextStyle(
                                    color: Styles.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.thirdColor,
                        ),
                        child: const Icon(
                          IconlyBold.Notification,
                          color: Styles.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(25),
                const BalanceBox(),
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Styles.primaryWithOpacityColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: shortcutList.map<Widget>((item) {
                      return InkWell(
                        onTap: () => item['route'] == null
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => item['route'])),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item['color'].withOpacity(0.15),
                          ),
                          child: Icon(item['icon'], color: item['color']),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Transactions',
                        style: TextStyle(
                            color: Styles.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text('Today',
                            style: TextStyle(
                                color: Styles.textColor.withOpacity(0.5),
                                fontSize: 16)),
                        const Gap(3),
                        Icon(CupertinoIcons.chevron_down,
                            color: Styles.textColor.withOpacity(0.5), size: 17)
                      ],
                    )
                  ],
                ),
                const TransactionTodayList()
              ],
            );
          }
        }
      },
    );
  }
}

class TransactionTodayList extends StatelessWidget {
  const TransactionTodayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (c, i) {
        final trs = transactions[i];
        return ListTile(
          isThreeLine: true,
          minLeadingWidth: 10,
          contentPadding: const EdgeInsets.all(0),
          leading: Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Styles.primaryWithOpacityColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    color: Styles.textColor.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                image: i == 0
                    ? null
                    : DecorationImage(
                        image: AssetImage(trs['avatar']),
                        fit: BoxFit.cover,
                      ),
                shape: BoxShape.circle,
              ),
              child: i == 0
                  ? Icon(trs['icon'],
                      color: const Color(0xFFFF736C), size: 20)
                  : const SizedBox()),
          title: Text(trs['name'],
              style: const TextStyle(color: Styles.textColor)),
          subtitle: Text(trs['date'],
              style: TextStyle(
                  color: Styles.textColor.withOpacity(0.5))),
          trailing: Text(trs['amount'],
              style: const TextStyle(
                  fontSize: 17, color: Styles.textColor)),
        );
      },
    );
  }
}
