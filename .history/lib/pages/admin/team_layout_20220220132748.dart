import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/team_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/team.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TeamLayout extends StatefulWidget {
  const TeamLayout({Key? key, this.team, this.type}) : super(key: key);

  final Team? team;
  final String? type;

  @override
  _TeamLayoutState createState() => _TeamLayoutState();
}

class _TeamLayoutState extends State<TeamLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? name, role;
  // String? image;
  // FilePickerResult? result;
  // PlatformFile? file;
  // String fileType = 'All';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // Widget fileDetails(PlatformFile file) {
    //   final kb = file.size / 1024;
    //   final mb = kb / 1024;
    //   final szize = (mb >= 1)
    //       ? '${mb.toStringAsFixed(2)} MB'
    //       : '${kb.toStringAsFixed(2)} KB';
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text('File Name: ${file.name}'),
    //         // Text('File Size: $size'),
    //         // Text('File Extension: ${file.extension}'),
    //         // Text('File Path: ${file.path}'),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateTeam : Str.createTeam,
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
                  const Gap(20),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update
                        ? widget.team?.name
                        : Field.empty,
                    onSaved: (val) => name = val,
                    hintText: Str.name,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20),
                  NewField(
                    mandatory: true,
                    initialValue: widget.type == Field.update
                        ? widget.team?.role
                        : Field.empty,
                    onSaved: (val) => role = val,
                    hintText: Str.role,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  // const Gap(20),
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.vertical(
                  //       bottom: Radius.circular(15),
                  //     ),
                  //     color: Styles.cardColor,
                  //   ),
                  //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //         child: Text(Str.attachment,
                  //             style: Styles.primaryTitle),
                  //       ),
                  //       ElevatedButton(
                  //         onPressed: () async {
                  //           pickFiles(fileType);
                  //         },
                  //         child: Text(Str.browse),
                  //         style: ElevatedButton.styleFrom(
                  //           elevation: 0.0,
                  //           primary: Styles.accentColor,
                  //         ),
                  //       ),
                  //       if (file != null) fileDetails(file!),
                  //     ],
                  //   ),
                  // ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 40),
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.name:
                              name ?? widget.team?.name ?? Field.emptyString,
                          Field.role:
                              role ?? widget.team?.role ?? Field.emptyString,
                          // Field.image: file!.name,
                        };

                        // TeamMethods.edit(
                        //     context, body,widget.team?.id.toString());=
                        widget.type == Field.update
                            ? Method.edit(
                                context,
                                _btnController,
                                body,
                                Uri.parse(AdminAPI.updateTeam.toString() +
                                    widget.team!.id.toString()),
                                Type.team,
                                TeamLayout(
                                  type: Field.create,
                                ),
                                Str.teamList,
                                Field.empty)
                            : Method.add(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createTeam,
                                Type.team,
                                TeamLayout(
                                  type: Field.create,
                                ),
                                Str.teamList);
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void pickFiles(String? filetype) async {
  //   switch (filetype) {
  //     case 'Image':
  //       result = await FilePicker.platform.pickFiles(type: FileType.image);
  //       if (result == null) return;
  //       file = result!.files.first;
  //       setState(() {});
  //       break;
  //     case 'Video':
  //       result = await FilePicker.platform.pickFiles(type: FileType.video);
  //       if (result == null) return;
  //       file = result!.files.first;
  //       setState(() {});
  //       break;
  //     case 'Audio':
  //       result = await FilePicker.platform.pickFiles(type: FileType.audio);
  //       if (result == null) return;
  //       file = result!.files.first;
  //       setState(() {});
  //       break;
  //     case 'All':
  //       result = await FilePicker.platform.pickFiles();
  //       if (result == null) return;
  //       file = result!.files.first;
  //       setState(() {});
  //       break;
  //     case 'MultipleFile':
  //       result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //       if (result == null) return;
  //       break;
  //   }
  // }
}
