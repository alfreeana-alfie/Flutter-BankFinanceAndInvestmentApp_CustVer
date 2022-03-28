import 'dart:io';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  SharedPref sharedPref = SharedPref();
  // User userLoad = User();
  Wallet wallet = Wallet();

  String? name,
      email,
      phone,
      branchId,
      emailVerifiedAt,
      smsVerifiedAt,
      countryCode;
  String? membershipId;

  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    Widget fileDetails(PlatformFile file) {
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final szize = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';

      file = result!.files.first;
      Uint8List? fileBytes = result!.files.first.bytes;

      if (kIsWeb) {
        // running on the web!
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kIsWeb)
                CircleAvatar(
                  backgroundImage: MemoryImage(fileBytes!),
                  minRadius: 10,
                  maxRadius: 50,
                ),
            ],
          ),
        );
      } else {
        // NOT running on the web! You can check for additional platforms here.
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kIsWeb)
                CircleAvatar(
                  backgroundImage: FileImage(File(file.path!)),
                  minRadius: 10,
                  maxRadius: 50,
                ),
              // if (file.path != null)
              //   CircleAvatar(
              //     backgroundImage: FileImage(File(file.path!)),
              //     // backgroundImage: MemoryImage(fileBytes),
              //     minRadius: 10,
              //     maxRadius: 50,
              //   ),
            ],
          ),
        );
      }
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
        title: Str.editProfile,
        implyLeading: true,
        context: context,
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (file != null)
                        fileDetails(file!)
                      else
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.user.profilePicture ??
                                  Values.userDefaultImage),
                          // backgroundImage: AssetImage(Values.userPath),
                          minRadius: 10,
                          maxRadius: 50,
                        ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                          color: Styles.cardColor,
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                pickFiles('Image');
                              },
                              child: Text(Str.uploadPicture),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Styles.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      NewField(
                          readOnly: true,
                          initialValue: widget.user.memberId,
                          onSaved: (val) => membershipId = val,
                          hintText: Str.membershipId),
                      const Gap(20.0),
                      NewField(
                          initialValue: widget.user.name,
                          onSaved: (val) => name = val,
                          hintText: Str.name),
                      const Gap(20.0),
                      // NewField(
                      //     initialValue: widget.user.email,
                      //     onSaved: (val) => email = val,
                      //     hintText: Str.email),
                      // const Gap(20.0),
                      // NewField(
                      //     initialValue:
                      //         '${widget.user.countryCode}-${widget.user.phone}',
                      //     onSaved: (val) => phone = val,
                      //     hintText: Str.phoneNumber),
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
                                  countryCode = widget.user.countryCode;
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
                            child: NewField(
                              initialValue: widget.user.phone,
                              onSaved: (value) => phone = value!,
                              hintText: Str.phoneNumber,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20.0),
                      RoundedLoadingButton(
                        controller: _btnController,
                        color: Styles.secondaryColor,
                        onPressed: () async {
                          if (file?.name == null) {
                            var split = widget.user.profilePicture!.split(
                                'https://villasearch.de/fvis-bank-member-backend/storage/app/profile_picture/');
                            // var fileName = split1[1];

                            print(widget.user.id.toString());

                            Map<String, String> body = {
                              Field.name: name ?? widget.user.name ?? Field.emptyString,
                              Field.profilePicture: split[1],
                              Field.countryCode:
                                  countryCode ?? widget.user.countryCode ?? Field.emptyString,
                              Field.phone: phone ?? widget.user.phone ?? Field.emptyString,
                              'upload': 'not_uploaded'
                            };

                            updateProfileTesting(
                                context,
                                _btnController,
                                body,
                                widget.user.id.toString());
                          } else {
                            Map<String, String> body = {
                              Field.name: name ?? widget.user.name ?? Field.emptyString,
                              Field.profilePicture:
                                  file?.name ?? Values.userDefaultImage,
                              Field.countryCode:
                                  countryCode ?? widget.user.countryCode ?? Field.emptyString,
                              Field.phone: phone ?? widget.user.phone ?? Field.emptyString,
                              'upload': 'upload'
                            };

                            if(kIsWeb){
                              updateProfileBytes(
                                context,
                                _btnController,
                                body,
                                file!.bytes,
                                // API.updateProfile,
                                Field.profilePicture,
                                // Field.putMethod,
                                widget.user.id.toString());
                            }else{
                              updateProfile(
                                context,
                                _btnController,
                                body,
                                file!.path,
                                // API.updateProfile,
                                Field.profilePicture,
                                // Field.putMethod,
                                widget.user.id.toString());
                            }
                          }
                        },
                        child: Text(Str.save.toUpperCase()),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   loadSharedPrefs();
  //   super.initState();
  // }

  // loadSharedPrefs() async {
  //   try {
  //     User user = User.fromJSON(await sharedPref.read(Pref.userData));
  //     setState(() {
  //       userLoad = user;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
