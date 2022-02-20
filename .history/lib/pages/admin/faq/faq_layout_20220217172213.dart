import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/faq_methods.dart';
import 'package:flutter_banking_app/models/faq.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateFaq extends StatefulWidget {
  const UpdateFaq({Key? key, this.faq, this.type}) : super(key: key);

  final Question? faq;
  final String? type;

  @override
  _UpdateFaqState createState() => _UpdateFaqState();
}

class _UpdateFaqState extends State<UpdateFaq> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? answer, question;
  int? status;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar:
          myAppBar(title: widget.type == Field.update 
          ? Str.updateFaq 
          : Str.createFaq, 
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
                      mandatory: true,
                      initialValue: widget.type == Field.update 
                      ? widget.faq?.question
                      : Field.empty,
                      onSaved: (val) => question = val,
                      hintText: Str.question,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
                  const Gap(20),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update 
                      ? widget.faq?.answer 
                      : Field.empty,
                      onSaved: (val) => answer = val,
                      hintText: Str.answer,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.status, style: Styles.primaryTitle),
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
                    initialLabelIndex: int.parse(widget.faq?.status ?? Field.emptyInt),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        status ??= int.parse(widget.faq?.status ?? Field.emptyInt);
                        Map<String, String> body = {
                          Field.question: question ??
                              widget.faq?.question ??
                              Field.emptyString,
                          Field.answer:
                              answer ?? widget.faq.answer ?? Field.emptyString,
                          Field.locale: widget.faq.locale ?? Field.emptyString,
                          Field.status: status.toString()
                        };

                        // FaqMethods.edit(
                        //     context, body, widget.faq.id.toString());
                        widget.type == Field.update
                            ? Method.edit(
                                context,
                                _btnController,
                                body,
                                Uri.parse(AdminAPI.updateBranch.toString() + widget.branch!.id.toString()),
                                Type.branch,
                                BranchLayout(
                                  type: Field.create,
                                ),
                                Str.branchList)
                            : Method.add(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createBranch,
                                Type.branch,
                                BranchLayout(
                                  type: Field.create,
                                ),
                                Str.branchList);
                      },
                      text: Str.submit.toUpperCase(),
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
