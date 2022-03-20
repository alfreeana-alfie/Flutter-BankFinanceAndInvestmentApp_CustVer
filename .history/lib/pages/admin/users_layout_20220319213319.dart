import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UsersLayout extends StatefulWidget {
  const UsersLayout(
      {Key? key,
      this.user,
      this.type,
      this.userType,
      this.creatorType,
      this.userLoad})
      : super(key: key);

  final Users? user;
  final User? userLoad;
  final String? type;
  final String? userType, creatorType;

  @override
  _CreateUsersState createState() => _CreateUsersState();
}

class _CreateUsersState extends State<UsersLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? name,
      email,
      phone,
      userType,
      roleId,
      branchId,
      profilePicture,
      password,
      confirmPassword,
      provider,
      providerId,
      countryCode,
      memberId;
  int? status;

  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    setState(() {
      memberId = Field.transactionCodeInitials + getRandomCode(6);
    });

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
            Image.file(
              File(file.path!),
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 100,
            ),
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

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateUser : Str.createUser,
          implyLeading: true,
          context: context),
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
                  widget.type == Field.update
                      ? const Gap(1)
                      : Container(
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
                                child: Text(Str.profilePicture,
                                    style: Styles.primaryTitle),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  pickFiles('Image');
                                },
                                child: Text(Str.browse),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  primary: Styles.accentColor,
                                ),
                              ),
                              if (file != null) fileDetails(file!),
                            ],
                          ),
                        ),
                  const Gap(20),
                  NewField(
                    readOnly: true,
                    mandatory: true,
                    initialValue: widget.userLoad!.id.toString(),
                    // onSaved: (val) => memberId = val,
                    hintText: Str.creatorId,
                    // textInputAction: TextInputAction.next,
                    // textInputType: TextInputType.text,
                  ),
                  const Gap(20),
                  NewField(
                    readOnly: true,
                    mandatory: true,
                    initialValue: memberId,
                    onSaved: (val) => memberId = val,
                    hintText: Str.memberId,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update
                        ? widget.user?.name
                        : Field.empty,
                    onSaved: (val) => name = val,
                    hintText: Str.name,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update
                        ? widget.user?.email
                        : Field.empty,
                    onSaved: (val) => email = val,
                    hintText: Str.email,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                  ),
                  // const Gap(20.0),
                  // NewField(
                  //   mandatory: true,
                  //   onSaved: (val) => phone = val,
                  //   hintText: Str.phoneNumber,
                  // ),
                  // const Gap(20.0),
                  // NewField(
                  //   mandatory: true,
                  //   onSaved: (val) => userType = val,
                  //   hintText: Str.userType,
                  //   text
                  // ),
                  const Gap(20.0),
                  // NewField(
                  //   mandatory: true,
                  //   onSaved: (val) => profilePicture = val,
                  //   hintText: Str.profilePicture,
                  // ),
                  // const Gap(20.0),
                  NewField(
                    mandatory: true,
                    // obsecure: true,
                    initialValue: widget.type == Field.update
                        ? widget.user?.password
                        : Field.empty,
                    onSaved: (val) => password = val,
                    hintText: Str.password,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    // obsecure: true,
                    initialValue: widget.type == Field.update
                        ? widget.user?.password
                        : Field.empty,
                    onSaved: (val) => confirmPassword = val,
                    hintText: Str.confirm,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const Gap(20.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.phoneNumber, style: Styles.primaryTitle),
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
                              countryCode = widget.type == Field.update
                                  ? widget.user?.countryCode
                                  : value.toString();
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
                          initialValue: widget.type == Field.update
                              ? widget.user?.phone
                              : Field.empty,
                          onSaved: (value) => phone = value!,
                          hintText: Str.phoneNumber,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  // const Gap(20),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(Str.status, style: Styles.primaryTitle),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(
                  //         '*',
                  //         style: TextStyle(color: Styles.dangerColor),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // ToggleSwitch(
                  //   initialLabelIndex: int.parse(
                  //       widget.user?.status.toString() ?? '1'),
                  //   minWidth: 120,
                  //   cornerRadius: 7.0,
                  //   activeBgColors: const [
                  //     [Styles.dangerColor],
                  //     [Styles.successColor]
                  //   ],
                  //   activeFgColor: Colors.white,
                  //   inactiveBgColor: Colors.black12.withOpacity(0.05),
                  //   inactiveFgColor: Styles.textColor,
                  //   totalSwitches: 2,
                  //   labels: Field.statusList,
                  //   onToggle: (index) {
                  //     // print('switched to: $index');
                  //     status = index;
                  //   },
                  // ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      width: double.maxFinite,
                      elevation: 0.0,
                      borderRadius: 15,
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        if (confirmPassword == password) {
                          String? accountNo = getRandomCode(6);

                          status ??= int.parse(
                              widget.user?.status.toString() ?? Field.emptyInt);
                          Map<String, String> body = {
                            Field.name: name ?? Field.emptyString,
                            Field.email: email ?? Field.emptyString,
                            Field.phone: phone ?? Field.emptyString,
                            Field.userType: userType ??
                                widget.userType ??
                                Field.emptyString,
                            Field.roleId: roleId ?? Field.emptyInt,
                            Field.branchId: branchId ?? Field.emptyInt,
                            Field.status: status.toString(),
                            Field.profilePicture: file?.name ??
                                widget.user?.profilePicture ??
                                Values.userDefaultImage,
                            Field.password: password ?? Field.emptyString,
                            Field.provider: provider ?? Field.emptyString,
                            Field.providerId: providerId ?? Field.emptyInt,
                            Field.countryCode: countryCode ?? Field.emptyString,
                            Field.memberId: memberId ?? Field.emptyInt,
                            Field.accountNo: accountNo,
                          };

                          print(countryCode! + phone!);

                          SMSNigeriaAPI.send(context, countryCode! + phone!,
                              'FVIS: Welcome! Registration completed successfully. Please check your registered email for email verification');
                          EmailJS.verifyEmail(context, name!, email!,
                              'https://villasearch.de/fvis-bank-member-backend/public/api/verification/$accountNo');

                          widget.creatorType != Field.admin
                              ? widget.type == Field.update
                                  ? Method.edit(
                                      context,
                                      _btnController,
                                      body,
                                      Uri.parse(AdminAPI.updateUser.toString() +
                                          widget.user!.id.toString()),
                                      Type.customer,
                                      UsersLayout(
                                        type: Field.create,
                                        userLoad: widget.userLoad,
                                        creatorType: widget.creatorType,
                                      ),
                                      Str.customerList,
                                      Field.empty,
                                      widget.userLoad!.userType!)
                                  : Method.addFile(
                                      context,
                                      _btnController,
                                      body,
                                      file!.path ?? file!.name,
                                      AdminAPI.createUser,
                                      Type.customer,
                                      UsersLayout(
                                        type: Field.create,
                                        userLoad: widget.userLoad,
                                        creatorType: widget.userLoad!.userType!,
                                      ),
                                      Str.customerList,
                                      Field.profilePicture,
                                      widget.userLoad!.userType!)
                              : widget.type == Field.update
                                  ? Method.edit(
                                      context,
                                      _btnController,
                                      body,
                                      Uri.parse(AdminAPI.updateUser.toString() +
                                          widget.user!.id.toString()),
                                      Type.customerAdmin,
                                      UsersLayout(
                                        type: Field.create,
                                        userLoad: widget.userLoad,
                                        creatorType: widget.userLoad!.userType!,
                                      ),
                                      Str.userList,
                                      Field.empty,
                                      widget.userLoad!.userType!)
                                  : Method.addFile(
                                      context,
                                      _btnController,
                                      body,
                                      file!.path ?? file!.name,
                                      AdminAPI.createUser,
                                      Type.customerAdmin,
                                      UsersLayout(
                                        type: Field.create,
                                        userLoad: widget.userLoad,
                                        creatorType: widget.userLoad!.userType!,
                                      ),
                                      Str.userList,
                                      Field.profilePicture,
                                      widget.userLoad!.userType!);
                        } else {
                          CustomToast.showMsg(
                              Str.invalidConfirmPassword, Styles.dangerColor);
                        }
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
                  ),
                  backButton(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
