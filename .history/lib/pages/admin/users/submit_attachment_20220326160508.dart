import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_branches.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_roles.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../users_layout.dart';

class SubmitAttachment extends StatefulWidget {
  const SubmitAttachment({Key? key, this.transactionId}) : super(key: key);

  final String? transactionId;

  @override
  _AssignWireTransferState createState() => _AssignWireTransferState();
}

class _AssignWireTransferState extends State<SubmitAttachment> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? users, usersName;

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
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.file(
            //   File(file.path!),
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   // height: 100,
            // ),
            Center(
              child: CircleAvatar(
                backgroundImage: FileImage(File(file.path!)),
                // backgroundImage: AssetImage(Values.userPath),
                minRadius: 10,
                maxRadius: 50,
              ),
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
          title: Str.assignStaff, implyLeading: true, context: context),
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
                          child:
                              Text(Str.attachment, style: Styles.primaryTitle),
                        ),
                        if (file != null) fileDetails(file!),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      width: double.maxFinite,
                      elevation: 0.0,
                      borderRadius: 15,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.assignTo: users ?? Field.emptyInt,
                          // Field.description: description ?? Field.emptyString
                        };
                        
                        Method.editFile(
                            context,
                            _btnController,
                            Uri.parse(AdminAPI.submitAttachment.toString() +
                                widget.transactionId!),
                            body,
                            Field.attachment,
                            file!.path ?? file!.name,
                            '',
                            Type.staffWireTransfer,
                            const SubmitAttachment(),
                            Str.wireTransfer);
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
