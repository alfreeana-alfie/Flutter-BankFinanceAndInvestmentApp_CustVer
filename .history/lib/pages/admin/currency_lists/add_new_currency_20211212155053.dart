import 'dart:convert';
import 'dart:io';

import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/app_bar.dart';
import 'package:bank_fvisng_admin/widgets/header_1.dart';
import 'package:bank_fvisng_admin/widgets/text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCurrencyPage extends StatefulWidget {
  const AddNewCurrencyPage({Key? key}) : super(key: key);

  @override
  _AddNewCurrencyPageState createState() => _AddNewCurrencyPageState();
}

class _AddNewCurrencyPageState extends State<AddNewCurrencyPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '',
      email = '',
      password = '',
      countryCode = '',
      phone = '',
      branch = '',
      profilePicture = '';

  List<String> verifyList = ['YES', 'NO'];
  List<String> statusList = ['ACTIVE', 'NOT ACTIVE'];

  String? emailVerified, smsVerified, status;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void addNew(BuildContext context, Map<String, String> body, String profilePicture) async {
    // void addNew(BuildContext context,name, email, password, countryCode, phone, branch,
    //                 status, emailVerified, smsVerified, profilePicture) async {
    final request = http.MultipartRequest('POST', addNewUser)
      ..fields.addAll(body)
      // ..headers.addAll(Values.headersMultiPart)
      ..files.add(await http.MultipartFile.fromPath('profile_picture', profilePicture));
    // final response = await http.put(addNewUser, headers: Values.headers, body: {
    //   "name": name,
    //   "email": email,
    //   "password": password,
    //   "country_code": countryCode,
    //   "phone": phone,
    //   "branch": branch,
    //   "status": status,
    //   "email_verified": emailVerified,
    //   "sms_verified": smsVerified,
    //   "profile_picture": profilePicture,
    //   "user_type": 'customer',
    //   "role_id": '',
    // });

    var response = await request.send();

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(Str.addSuccessTxt)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(Str.addFailedTxt)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Values.appHeight),
        child: MainAppBar(title: Str.addNewTxt),
      ),
      backgroundColor: Styles.backgroundColor,
      body: Container(
        color: Styles.backgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              _buildContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  // Form Container
  _buildContainer(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Header1(
                title: UserSTR.createUserTxt.toUpperCase(),
                textStyle: Theme.of(context).textTheme.headline5!,
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(5.0),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  // Form
  _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // NAME
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Values.horizontalValue * 2,
              vertical: Values.verticalValue),
          child: TextFieldCustom(
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onSaved: (value) => name = value!,
            hintText: Str.nameTxt,
          ),
        ),
        // Email address
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: TextFieldCustom(
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (value) => email = value!,
            hintText: Str.emailTxt,
          ),
        ),
        // Password
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: TextFieldCustom(
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            onSaved: (value) => password = value!,
            hintText: Str.passwordTxt,
          ),
        ),
        // Country Code + Phone No
        Padding(
          padding: const EdgeInsets.only(
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2,
              bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: CountryCodePicker(
                    onChanged: (value) {
                      setState(() {
                        countryCode = value.toString();
                      });
                    },
                    onInit: (value) {
                      countryCode = value.toString();
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: '+60',
                    // favorite: ['+60','MS'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                    padding: EdgeInsets.all(12),
                    dialogSize: Size(350, 450),
                    textStyle: GoogleFonts.nunitoSans(
                      color: Styles.textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFieldCustom(
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => phone = value!,
                  hintText: Str.phoneNumberTxt,
                ),
              ),
            ],
          ),
        ),
        // Branch
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: TextFieldCustom(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onSaved: (value) => branch = value!,
            hintText: Str.branchTxt,
          ),
        ),
        // Status
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.05),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                dropdownColor: Styles.primaryColor,
                hint: status == null
                    ? Text(Str.statusTxt)
                    : Text(
                        status!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: Theme.of(context).textTheme.bodyText1,
                items: statusList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      status = val as String?;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        // Email Verified
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.05),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: emailVerified == null
                    ? Text(UserSTR.emailVerifiedTxt)
                    : Text(
                        emailVerified!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: Theme.of(context).textTheme.bodyText1,
                items: verifyList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      emailVerified = val as String?;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        // SMS Verified
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.05),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: smsVerified == null
                    ? Text(UserSTR.smsVerifiedTxt)
                    : Text(
                        smsVerified!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: Theme.of(context).textTheme.bodyText1,
                items: verifyList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      smsVerified = val as String?;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        // Profile Picture
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              left: Values.horizontalValue * 2,
              right: Values.horizontalValue * 2),
          child: Container(
              child: OutlineButton(onPressed: getImage, child: _buildImage())),
          // TextFieldCustom(
          //   onSaved: (value) => profilePicture = value!,
          //   hintText: Str.profilePictureTxt,
          // ),
        ),
        // Button Sign In
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(
              horizontal: Values.horizontalValue * 2,
              vertical: Values.verticalValue),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // print(_image?.path);

              }
              Map<String, String> body = {
                "name": name,
                "email": email,
                "password": password,
                "country_code": countryCode,
                "phone": phone,
                "branch": branch,
                "status": status ?? '',
                "email_verified": emailVerified ?? '',
                "sms_verified": smsVerified ?? '',
                "profile_picture": _image!.path,
                "user_type": 'customer',
                "role_id": '',
              };

              print(_image?.path);

              addNew(context, body, _image!.path);

              // addNew(context, name, email, password, countryCode, phone, branch,
              //     status, emailVerified, smsVerified, profilePicture);
            },
            child: Text(UserSTR.createUserTxt),
            style: ElevatedButton.styleFrom(
              primary: Styles.darkBlueColor,
              elevation: 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }
}
