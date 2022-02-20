import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/service_methods.dart';
import 'package:flutter_banking_app/models/service.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ServiceLayout extends StatefulWidget {
  const ServiceLayout({Key? key, this.service, this.type}) : super(key: key);

  final Service? service;
  final String? type;

  @override
  _ServiceLayoutState createState() => _ServiceLayoutState();
}

class _ServiceLayoutState extends State<ServiceLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? icon;
  
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateService : Field.empty, implyLeading: true, context: context),
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
                      initialValue: widget.type == Field.update ? widget.service?.icon,
                      onSaved: (val) => icon = val,
                      hintText: Str.icon),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 40),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          'icon': icon ?? widget.service.icon ?? Field.emptyString,
                        };

                        ServiceMethods.edit(context, body, widget.service.id.toString());
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
