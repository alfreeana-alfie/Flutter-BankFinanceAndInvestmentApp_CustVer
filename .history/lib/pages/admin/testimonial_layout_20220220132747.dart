import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/testimonial_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/testimonial.dart';
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
import 'package:toggle_switch/toggle_switch.dart';

class TestimonialLayout extends StatefulWidget {
  const TestimonialLayout({Key? key, this.testimonial, this.type})
      : super(key: key);

  final Testimonial? testimonial;
  final String? type;

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
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateTestimonial : Str.createTestimonial,
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
                      initialValue: widget.type == Field.update ? widget.testimonial?.name : Field.empty,
                      onSaved: (val) => name = val,
                      hintText: Str.name,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update ? widget.testimonial?.locale : Field.empty,
                      onSaved: (val) => locale = val,
                      hintText: Str.locale,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
                  const Gap(20.0),
                  NewField(
                      mandatory: true,
                      initialValue: widget.type == Field.update ? widget.testimonial?.testimonials : Field.empty,
                      onSaved: (val) => testimonial = val,
                      hintText: Str.testimonial,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
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
                    initialLabelIndex: int.parse(widget.testimonial?.status ?? Field.emptyInt),
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
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        int.parse(widget.testimonial?.status ?? Field.emptyInt);
                        Map<String, String> body = {
                          Field.name: name ??
                              widget.testimonial?.name ??
                              Field.emptyString,
                          Field.locale: locale ??
                              widget.testimonial?.locale ??
                              Field.emptyAmount,
                          Field.testimonials: testimonial ??
                              widget.testimonial?.testimonials ??
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
                                Uri.parse(AdminAPI.updateTestimonial.toString() + widget.testimonial!.id.toString()),
                                Type.testimonial,
                                TestimonialLayout(
                                  type: Field.create,
                                ),
                                Str.testimonialList,
                                Field.empty)
                            : Method.add(
                                context,
                                _btnController,
                                body,
                                AdminAPI.createTestimonial,
                                Type.testimonial,
                                TestimonialLayout(
                                  type: Field.create,
                                ),
                                Str.testimonialList);
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
