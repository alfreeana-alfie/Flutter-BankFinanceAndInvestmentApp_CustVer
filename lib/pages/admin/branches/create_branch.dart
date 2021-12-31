import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/branch_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateBranch extends StatefulWidget {
  const CreateBranch({Key? key}) : super(key: key);

  @override
  _CreateBranchState createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final ScrollController _scrollController = ScrollController();

  String? name, contactEmail, contactPhone, address, descriptions;

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
            title: Str.createCurrencyTxt, implyLeading: true, context: context),
        // bottomSheet: Container(
        //   color: Styles.primaryColor,
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        //   child: elevatedButton(
        //     color: Styles.secondaryColor,
        //     context: context,
        //     callback: () {
        //       Map<String, String> body = {
        //         Field.name: name!,
        //         Field.contactEmail: contactEmail ?? Field.emptyString,
        //         Field.contactPhone: contactPhone ?? Field.emptyString,
        //         Field.address: address ?? Field.emptyString,
        //         Field.descriptions: descriptions ?? Field.emptyString
        //       };

        //       OtherBankMethods.add(context, body);
        //     },
        //     text: Str.createCurrencyTxt.toUpperCase(),
        //   ),
        // ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.accentColor,
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
                        TextFormField(
                          onChanged: (val) {
                            name = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.nameTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.nameTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            contactEmail = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.contactEmailTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.contactEmailTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            contactPhone = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.contactPhoneTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.contactPhoneTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            address = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.addressTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.addressTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20.0),
                        TextFormField(
                          onChanged: (val) {
                            descriptions = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.descriptionsTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.descriptionsTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Styles.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    Field.name: name!,
                    Field.contactEmail: contactEmail ?? Field.emptyString,
                    Field.contactPhone: contactPhone ?? Field.emptyString,
                    Field.address: address ?? Field.emptyString,
                    Field.descriptions: descriptions ?? Field.emptyString
                  };

                  BranchMethods.add(context, body);
                },
                text: Str.createBranchTxt.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
