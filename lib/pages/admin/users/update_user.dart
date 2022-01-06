import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/users_methods.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key, required this.user}) : super(key: key);

  final Users user;
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
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
  int? status;
  
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
                      initialValue: widget.user.name,
                      onSaved: (val) => name = val,
                      hintText: Str.nameTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      initialValue: widget.user.email,
                      onSaved: (val) => email = val,
                      hintText: Str.emailTxt,
                    ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      initialValue: widget.user.userType,
                      onSaved: (val) => userType = val,
                      hintText: Str.userTypeTxt,
                    ),
                    // const Gap(20.0),
                    // NewField(
                    //   mandatory: true,
                    //   readOnly: true,
                    //   onSaved: (val) => profilePicture = val,
                    //   hintText: Str.profilePictureTxt,
                    // ),
                    const Gap(20.0),
                    // NewField(
                    //   mandatory: true,
                    //   initialV,
                    //   onSaved: (val) => password = val,
                    //   hintText: Str.passwordTxt,
                    // ),
                    const Gap(20.0),
                    NewField(
                      mandatory: true,
                      initialValue: widget.user.provider,
                      onSaved: (val) => provider = val,
                      hintText: Str.providerTxt,
                    ),
                    const Gap(20.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(Str.phoneNumberTxt,
                              style: Styles.primaryTitle),
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
                              initialSelection: widget.user.countryCode,
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
                            initialValue: widget.user.phone,
                            onSaved: (value) => phone = value!,
                            hintText: Str.phoneNumberTxt,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.statusTxt, style: Styles.primaryTitle),
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
                    ToggleSwitch(
                      initialLabelIndex: int.parse(widget.user.status!),
                      minWidth: 120,
                      cornerRadius: 7.0,
                      activeBgColors: const [
                        [Styles.dangerColor],
                        [Styles.successColor]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.black12.withOpacity(0.05),
                      inactiveFgColor: Styles.textColor,
                      totalSwitches: 2,
                      labels: Field.statusList,
                      onToggle: (index) {
                        // print('switched to: $index');
                        status = index;
                      },
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
                            status ??= int.parse(widget.user.status!);
                          Map<String, String> body = {
                            Field.name: name ?? widget.user.name ?? Field.emptyString,
                            Field.email: email ?? widget.user.email ?? Field.emptyString,
                            Field.phone: phone ?? widget.user.phone ?? Field.emptyString,
                            Field.userType: userType ?? widget.user.userType ?? Field.emptyString,
                            Field.roleId: roleId ?? widget.user.roleId.toString(),
                            Field.branchId: branchId ?? widget.user.branchId.toString(),
                            Field.status: status.toString(),
                            // Field.profilePicture:
                            //     profilePicture ?? Field.emptyString,
                            Field.password: password ?? widget.user.password ?? Field.emptyString,
                            Field.provider: provider ?? widget.user.provider ?? Field.emptyString,
                            Field.providerId: providerId ?? widget.user.providerId ?? Field.emptyString,
                            Field.countryCode: countryCode ?? widget.user.countryCode ?? Field.emptyString,
                          };

                          UserMethods.edit(context, body, widget.user.id.toString());
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
