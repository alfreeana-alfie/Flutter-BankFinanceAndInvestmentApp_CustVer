import 'package:flutter/material.dart';
import 'pathdashboard.dart';
import 'package:flutter_banking_app/pages/member/profile.dart';
import 'package:flutter_banking_app/pages/member/stats.dart';
import 'package:flutter_banking_app/pages/member/wallet.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/left_side_menu.dart';

String path = "";
/// This is the stateful widget that the main application instantiates.
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    const Wallet(),
    const Stats(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Styles.primaryWithOpacityColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontSize: 20, color: Styles.primaryColor),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Styles.blueColor,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.Home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.Wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.Chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.Profile),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
