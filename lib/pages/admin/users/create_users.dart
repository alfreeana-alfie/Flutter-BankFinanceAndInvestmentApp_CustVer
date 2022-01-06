import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/other_bank_methods.dart';
import 'package:flutter_banking_app/methods/admin/users_methods.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

class CreateUsers extends StatefulWidget {
  const CreateUsers({Key? key}) : super(key: key);

  @override
  _CreateUsersState createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {
  final ScrollController _scrollController = ScrollController();

  String? name,
      email,
      phone,
      userType,
      roleId,
      branchId,
      profilePicture,
      password,
      provider,
      providerId,
      countryCode;

  
  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';


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

    
    Widget fileDetails(PlatformFile file) {
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final szize = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File Name: ${file.name}'),
            // Text('File Size: $size'),
            // Text('File Extension: ${file.extension}'),
            // Text('File Path: ${file.path}'),
          ],
        ),
      );
    }
    
  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        break;
    }
  } 

    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.createUserTxt, implyLeading: true, context: context),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NewField(
                      mandatory: true,
                      onSaved: (val) => name = val,
                      hintText: Str.nameTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => email = val,
                      hintText: Str.emailTxt,
                    ),
                    // const Gap(20.0),
                    // NewField(
                    //   mandatory: true,
                    //   onSaved: (val) => phone = val,
                    //   hintText: Str.phoneNumberTxt,
                    // ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => userType = val,
                      hintText: Str.userTypeTxt,
                    ),
                    const Gap(20.0),
                    // NewField(
                    //   mandatory: true,
                    //   onSaved: (val) => profilePicture = val,
                    //   hintText: Str.profilePictureTxt,
                    // ),
                    // const Gap(20.0),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => password = val,
                      hintText: Str.passwordTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => provider = val,
                      hintText: Str.providerTxt,
                    ),
                    const Gap(20.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.phoneNumberTxt, style: Styles.primaryTitle),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(
                            '*',
                            style: TextStyle(color: Styles.dangerColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                              padding: const EdgeInsets.all(12),
                              dialogSize: const Size(350, 450),
                              textStyle: GoogleFonts.nunitoSans(
                                color: Styles.textColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldCustom(
                            onSaved: (value) => phone = value!,
                            hintText: Str.phoneNumberTxt,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                        color: Styles.cardColor,
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                            child: Text(Str.profilePictureTxt,
                                style: Styles.primaryTitle),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              pickFiles(fileType);
                            },
                            child: Text(Str.browseTxt),
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: Styles.accentColor,
                            ),
                          ),
                          if (file != null) fileDetails(file!),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Styles.primaryColor,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
                          Map<String, String> body = {
                            Field.name: name ?? Field.emptyString,
                            Field.email: email ?? Field.emptyString,
                            Field.phone: phone ?? Field.emptyString,
                            Field.userType: userType ?? Field.emptyString,
                            Field.roleId: roleId ?? Field.empty,
                            Field.branchId: branchId ?? Field.empty,
                            Field.status: Status.pending.toString(),
                            Field.profilePicture: file!.name,
                            Field.password: password ?? Field.emptyString,
                            Field.provider: provider ?? Field.emptyString,
                            Field.providerId:
                                providerId ?? Field.empty,
                            Field.countryCode:
                                countryCode ?? Field.emptyString,
                          };

                          UserMethods.add(context, body, file!.path ?? file!.name);
                        },
                        text: Str.submitTxt.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
