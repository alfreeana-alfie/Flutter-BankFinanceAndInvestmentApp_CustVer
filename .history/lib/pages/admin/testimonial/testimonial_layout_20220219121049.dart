import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/testimonial_methods.dart';
import 'package:flutter_banking_app/models/testimonial.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TestimonialLayout extends StatefulWidget {
  const TestimonialLayout({Key? key, required this.testimonial})
      : super(key: key);

  final Testimonial testimonial;

  @override
  _TestimonialLayoutState createState() => _TestimonialLayoutState();
}

class _TestimonialLayoutState extends State<TestimonialLayout> {
  // final ScrollController _scrollController = ScrollController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? name, locale, testimonial;
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
    
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createTestimonial,
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
                      initialValue: widget.testimonial.name,
                      onSaved: (val) => name = val,
                      hintText: Str.name),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.testimonial.locale,
                      onSaved: (val) => locale = val,
                      hintText: Str.locale),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.testimonial.testimonials,
                      onSaved: (val) => testimonial = val,
                      hintText: Str.testimonial),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.status, style: Styles.primaryTitle),
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
                    initialLabelIndex: int.parse(widget.testimonial.status!),
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
                  const Gap(20),
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
                        int.parse(widget.testimonial.status!);
                        Map<String, String> body = {
                          Field.name: name ??
                              widget.testimonial.name ??
                              Field.emptyString,
                          Field.locale: locale ??
                              widget.testimonial.locale ??
                              Field.emptyAmount,
                          Field.testimonials: testimonial ??
                              widget.testimonial.testimonials ??
                              Field.emptyString,
                          Field.status: status.toString()
                        };

                        // TestimonialMethods.edit(
                        //     context, body, widget.testimonial.id.toString());
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
