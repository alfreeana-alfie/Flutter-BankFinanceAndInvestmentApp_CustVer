import 'package:flutter/material.dart';
import 'package:flutter_banking_app/constant/string.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';

class SideDrawer extends StatelessWidget {
  List<ListTile> menu = [
    ListTile(
      leading: Icon(Icons.home),
      title: Text(dashboardText),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(homepageText),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(aboutUsText),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(ourServicesText),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(faqText),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(contactUsText),
      onTap: () => {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                'Side menu FlutterCorner',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(IconlyBold.Document),
            title: Text(dashboardText),
            onTap: () => {
              Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.Home),
            title: Text(homepageText),
            onTap: () => {
              Navigator.pushNamed(context, '/home')
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.User1),
            title: Text(aboutUsText),
            onTap: () => {
              Navigator.pushNamed(context, '/about')
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.Bag_2),
            title: Text(ourServicesText),
            onTap: () => {
              Navigator.pushNamed(context, '/services')
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.Info_Circle),
            title: Text(faqText),
            onTap: () => {
              Navigator.pushNamed(context, '/faq')
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.Chat),
            title: Text(contactUsText),
            onTap: () => {
              Navigator.pushNamed(context, '/contact')
            },
          ),
        ],
      ),
    );
  }
}
