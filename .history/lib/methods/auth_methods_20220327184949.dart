import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/auth/profile_overview.dart';
import 'package:flutter_banking_app/pages/member/profile.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/models/token.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'config.dart';

SharedPref sharedPref = SharedPref();

void signIn(BuildContext context, Map<String, String> body,
    RoundedLoadingButtonController controller) async {
  final response = await http.post(
    API.login,
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.ok) {
    var jsonBody = Token.fromJSON(jsonDecode(response.body));

    if (sharedPref.read(Pref.userData) != null) {
      sharedPref.remove(Pref.expiredAt);
      sharedPref.remove(Pref.accessToken);

      sharedPref.save(Pref.accessToken, jsonBody.token);
      sharedPref.save(Pref.expiredAt, jsonBody.expiredAt);
    } else {
      sharedPref.save(Pref.accessToken, jsonBody.token);
      sharedPref.save(Pref.expiredAt, jsonBody.expiredAt);
    }

    getUserDetails(context, controller);
  } else {
    controller.stop();
    // print(AuthSTR.failedAuth);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void welcome(BuildContext context, String userId) async {
  Uri viewSingleUser = Uri.parse(
      'https://villasearch.de/fvis-bank-member-backend/public/api/welcome/' +
          userId);
  final response = await http.get(viewSingleUser, headers: headers);

  if (response.statusCode == Status.ok) {
    //
  } else {
    // print(Status.failed);
    // CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void getUserDetails(
    BuildContext context, RoundedLoadingButtonController controller) async {
  try {
    String? accessToken = await sharedPref.read(Pref.accessToken);

    final response = await http.get(API.getUserDetails, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == Status.ok) {
      if (sharedPref.read(Pref.userData) != null) {
        // sharedPref.remove(Pref.expiredAt);
        // sharedPref.remove(Pref.accessToken);
        sharedPref.remove(Pref.userData);

        sharedPref.save(
            Pref.userData, User.fromJSON(jsonDecode(response.body)));
      } else {
        sharedPref.save(
            Pref.userData, User.fromJSON(jsonDecode(response.body)));
      }

      var jsonBody = User.fromJSON(jsonDecode(response.body));
      if (jsonBody.userType == Field.customer &&
          jsonBody.emailVerifiedAt != null) {
        if (jsonBody.welcomeMessage != null) {
          controller.stop();
          Navigator.pushNamed(context, RouteSTR.dashboardMember);
        } else {
          EmailJS.welcomeMessage(
              context,
              jsonBody.email!,
              Field.transactionCodeInitials + getRandomCode(6),
              jsonBody.id.toString());
          welcome(context, jsonBody.id.toString());
          controller.stop();
          Navigator.pushNamed(context, RouteSTR.dashboardMember);
        }
      } else if (jsonBody.userType == Field.accountant) {
        Navigator.pushNamed(context, RouteSTR.dashboardAccountant);
      } else if (jsonBody.userType == Field.admin) {
        Navigator.pushNamed(context, RouteSTR.dashboardAdmin);
      } else if (jsonBody.userType == Field.accountManager) {
        Navigator.pushNamed(context, RouteSTR.dashboardAccountManager);
      } else {
        _showDialogError(context);
      }
    } else {
      CustomToast.showMsg('Incorrect Email/Password', Styles.dangerColor);
    }
  } catch (e) {
    print(e);
    CustomToast.showMsg('Incorrect Email/Password', Styles.dangerColor);
  }
}

void getDetails(BuildContext context) async {
  try {
    String? accessToken = await sharedPref.read(Pref.accessToken);

    final response = await http.get(API.getUserDetails, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == Status.ok) {
      if (sharedPref.read(Pref.userData) != null) {
        sharedPref.remove(Pref.userData);

        sharedPref.save(
            Pref.userData, User.fromJSON(jsonDecode(response.body)));
      } else {
        sharedPref.save(
            Pref.userData, User.fromJSON(jsonDecode(response.body)));
      }
    }
  } catch (e) {
    print(e);
    CustomToast.showMsg('Incorrect Email/Password', Styles.dangerColor);
  }
}

void signOut(BuildContext context) async {
  String? accessToken = await sharedPref.read(Pref.accessToken);

  final response = await http.get(API.logout, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == Status.created) {
    sharedPref.remove(Pref.accessToken);
    sharedPref.remove(Pref.expiredAt);
    sharedPref.remove(Pref.userData);

    if (response.statusCode == Status.ok) {
      Navigator.pushNamed(context, RouteSTR.dashboardMember);
    } else {
      // print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  } else {
    // print(Status.failed);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void signUp(BuildContext context, Map<String, String> body,
    RoundedLoadingButtonController controller) async {
  final response = await http.post(
    API.signUp,
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.created) {
    controller.stop();
    _showDialog(context);
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   Navigator.pushReplacementNamed(context, RouteSTR.signIn);
    // });
  } else {
    // print(response.body);
    controller.stop();
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void _showDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return successDialog(context);
    },
  );
}

void _showDialogError(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return verifyEmailDialog(context);
    },
  );
}

void updateSMS(BuildContext context, String id) async {
  Uri url = Uri.parse(API.updateSMS.toString() + id);

  final response = await http.put(url, headers: headers);

  if (response.statusCode == Status.ok) {
    CustomToast.showMsg(Status.success, Styles.successColor);
  } else {
    print(response.body);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void updateProfile(
    BuildContext context,
    RoundedLoadingButtonController controller,
    Map<String, String> body,
    String filename,
    String image,
    String userId) async {
  // final request = http.MultipartRequest(
  //     Field.postMethod, Uri.parse(API.updateProfile.toString() + userId))
  //   ..fields.addAll(body)
  //   ..headers.addAll(headersMultiPart)
  //   ..files.add(
  //     await http.MultipartFile.fromPath(Field.profilePicture, filename),
  //   );
  final request = http.MultipartRequest(
      Field.postMethod, Uri.parse(API.updateProfile.toString() + userId))
    ..fields.addAll(body)
    ..headers.addAll(headersMultiPart)
    ..files.addAll(
        {await http.MultipartFile.fromPath(Field.profilePicture, filename)});

  var response = await request.send();

  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);

  if (response.statusCode == Status.ok) {
    CustomToast.showMsg(Status.success, Styles.successColor);
    getDetails(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      controller.stop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
      );
    });
  } else {
    // print(response.request);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void updateProfileBytes(
    BuildContext context,
    RoundedLoadingButtonController controller,
    Map<String, String> body,
    Uint8List filename,
    String image,
    String userId) async {
  // final request = http.MultipartRequest(
  //     Field.postMethod, Uri.parse(API.updateProfile.toString() + userId))
  //   ..fields.addAll(body)
  //   ..headers.addAll(headersMultiPart)
  //   ..files.add(
  //     await http.MultipartFile.fromPath(Field.profilePicture, filename),
  //   );
  List<int> listData = filename.cast();

  final request = http.MultipartRequest(
      Field.postMethod, Uri.parse(API.updateProfile.toString() + userId))
    ..fields.addAll(body)
    ..headers.addAll(headersMultiPart)
    ..files.addAll(
        {await http.MultipartFile.fromBytes(Field.profilePicture, listData)});

  var response = await request.send();

  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);

  if (response.statusCode == Status.ok) {
    CustomToast.showMsg(Status.success, Styles.successColor);
    getDetails(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      controller.stop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
      );
    });
  } else {
    // print(response.request);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}

void updateProfileTesting(
    BuildContext context,
    RoundedLoadingButtonController controller,
    Map<String, String> body,
    String userId) async {
  final response = await http.post(
    Uri.parse(API.updateProfile.toString() + userId),
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.ok) {
    CustomToast.showMsg(Status.success, Styles.successColor);
    getDetails(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      controller.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ProfileOverview(),
        ),
      );
    });
  } else {
    print(response.body);
    CustomToast.showMsg(Status.failed, Styles.dangerColor);
  }
}
