import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/support_ticket_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/bigger_new_text_field.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class MCreateSupportTicket extends StatefulWidget {
  const MCreateSupportTicket({Key? key}) : super(key: key);

  @override
  _MCreateSupportTicketState createState() => _MCreateSupportTicketState();
}

class _MCreateSupportTicketState extends State<MCreateSupportTicket> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();

  String? subject, message, supportTicketId, userId;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userId = user.id.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final size = Layouts.getSize(context);
    
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.createSupportTicketTxt,
            implyLeading: true,
            context: context),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            // padding: const EdgeInsets.all(15),
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Styles.greyColor,
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
                          NewField(
                              onSaved: (val) => subject = val,
                              hintText: Str.subjectTxt),
                          const Gap(20.0),
                          NewField(
                            onSaved: (val) => message = val,
                            hintText: Str.messageTxt,
                            maxLines: 10,
                          ),
                          const Gap(20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: elevatedButton(
                              color: Styles.secondaryColor,
                              context: context,
                              callback: () {
                                Map<String, String> body = {
                                  Field.supportTicketId:
                                      '#${getRandomString(12)}',
                                  Field.subject: subject ?? Field.emptyString,
                                  Field.message: message ?? Field.emptyAmount,
                                  Field.senderId: userId ?? Field.emptyString,
                                  Field.status: Status.pending.toString(),
                                  Field.priority: Status.pending.toString(),
                                  Field.operatorId: '0',
                                  Field.closedUserId: '0',
                                };

                                SupportTicketMethods.add(context, body);
                              },
                              text: Str.submitTxt.toUpperCase(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
