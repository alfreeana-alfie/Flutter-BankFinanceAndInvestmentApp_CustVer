import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/app_bar.dart';
import 'package:bank_fvisng_admin/widgets/card_1.dart';
import 'package:bank_fvisng_admin/widgets/card_2.dart';
import 'package:bank_fvisng_admin/widgets/left_menu.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Values.appHeight),
        child: MainAppBar(title: Str.dashboardTxt),
      ),
      drawer: SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            // Card1(),
            // Card2(),
          ],
        ),
      ),
    );
  }
}


