import 'package:flutter/material.dart';

class Values {
  static String logoPath = 'assets/images/logo.png';
  static String loginBgPath = 'assets/images/login.jpg';
  static String userPath = 'assets/images/user.png';
  static String paymentRequestPath = 'assets/icons/payment_request.svg';

  static const double horizontalValue = 10.0;
  static const double verticalValue = 15.0;
  static const double appHeight = 65.0;

  static const EdgeInsets drawerMargin =
      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 17);

  
}

Uri getUserList =
    Uri.parse("https://villasearch.de/admin/public/api/get-user-list");
Uri addNewUser =
    Uri.parse("https://villasearch.de/admin/public/api/add-new-user");
Uri editUser = Uri.parse("https://villasearch.de/admin/public/api/edit-user");
Uri delUser = Uri.parse("https://villasearch.de/admin/public/api/del-user/");
