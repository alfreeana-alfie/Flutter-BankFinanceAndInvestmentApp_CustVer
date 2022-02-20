import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/branch_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/branch.dart';
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

class UpdateBranch extends StatefulWidget {
  const UpdateBranch({Key? key, this.branch, this.type})
      : super(key: key);

  final Branch? branch;
  final String? type;

  @override
  _UpdateBranchState createState() => _UpdateBranchState();
}

class _UpdateBranchState extends State<UpdateBranch> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? name, contactEmail, contactPhone, address, descriptions;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title:
              widget.type == Field.update ? Str.updateBranch : Str.createBranch,
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
                  NewField(
                    initialValue: widget.type == Field.update
                        ? widget.branch?.name
                        : Field.empty,
                    onSaved: (val) => name = val,
                    hintText: Str.name,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                  const Gap(20.0),
                  NewField(
                    initialValue: widget.type == Field.update
                        ? widget.branch.contactEmail
                        : Field.empty,
                    onSaved: (val) => contactEmail = val,
                    hintText: Str.contactEmail,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    // maxLines: 10,
                  ),
                  const Gap(20.0),
                  NewField(
                    initialValue: widget.type == Field.update
                        ? widget.branch.contactPhone
                        : Field.empty,
                    onSaved: (val) => contactPhone = val,
                    hintText: Str.contactPhone,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                  ),
                  const Gap(20.0),
                  NewField(
                    initialValue: widget.type == Field.update
                        ? widget.branch.address
                        : Field.empty,
                    onSaved: (val) => address = val,
                    hintText: Str.address,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.streetAddress,
                    // maxLines: 10,
                  ),
                  const Gap(20.0),
                  NewField(
                    initialValue: widget.type == Field.update
                        ? widget.branch.descriptions
                        : Field.empty,
                    onSaved: (val) => descriptions = val,
                    hintText: Str.descriptions,
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.name:
                              name ?? widget.branch.name ?? Field.emptyString,
                          Field.contactEmail: contactEmail ??
                              widget.branch.contactEmail ??
                              Field.emptyString,
                          Field.contactPhone: contactPhone ??
                              widget.branch.contactPhone ??
                              Field.emptyString,
                          Field.address: address ??
                              widget.branch.address ??
                              Field.emptyString,
                          Field.descriptions: descriptions ??
                              widget.branch.descriptions ??
                              Field.emptyString,
                        };

                        widget.type == Field.update
                            ? Method.edit(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createBranch,
                                Type.branch,
                                RouteSTR.branch,
                                Str.branchList)
                            : Method.add(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createBranch,
                                Type.branch,
                                RouteSTR.branch,
                                Str.branchList);
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
}
