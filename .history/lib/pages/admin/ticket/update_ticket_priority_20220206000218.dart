import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/support_ticket_methods.dart';
import 'package:flutter_banking_app/models/ticket.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateSupportTicketPriority extends StatefulWidget {
  const UpdateSupportTicketPriority({Key? key, required this.ticket})
      : super(key: key);

  final Ticket ticket;

  @override
  _UpdateSupportTicketPriorityState createState() =>
      _UpdateSupportTicketPriorityState();
}

class _UpdateSupportTicketPriorityState
    extends State<UpdateSupportTicketPriority> {
  final ScrollController _scrollController = ScrollController();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  String? subject, message, supportTicketId, userId;
  int? priority;

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

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
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.sendMoneyTxt, implyLeading: true, context: context),
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
                      readOnly: true,
                      initialValue: widget.ticket.subject,
                      onSaved: (val) => subject = val,
                      hintText: Str.subjectTxt),
                  const Gap(20.0),
                  NewField(
                    readOnly: true,
                    initialValue: widget.ticket.message,
                    onSaved: (val) => message = val,
                    hintText: Str.messageTxt,
                    maxLines: 10,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.statusTxt, style: Styles.primaryTitle),
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
                    initialLabelIndex: int.parse(widget.ticket.priority!),
                    minWidth: 70,
                    cornerRadius: 7.0,
                    activeBgColors: const [
                      [Styles.successColor],
                      [Styles.warningColor],
                      [Styles.dangerColor]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.black12.withOpacity(0.05),
                    inactiveFgColor: Styles.textColor,
                    totalSwitches: 3,
                    labels: Field.priorityList,
                    onToggle: (index) {
                      // print('switched to: $index');
                      priority = index;
                    },
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        priority ??= int.parse(widget.ticket.priority!);
                        Map<String, String> body = {
                          // Field.supportTicketId: '#${getRandomString(12)}',
                          // Field.subject: subject ?? Field.emptyString,
                          // Field.message: message ?? Field.emptyAmount,
                          // Field.senderId: userId ?? Field.emptyString,
                          // Field.status: Status.pending.toString(),
                          Field.priority: priority.toString(),
                          // Field.operatorId: '0',
                          // Field.closedUserId: '0',
                        };

                        SupportTicketMethods.editPriority(context, body, widget.ticket.id.toString());
                      },
                      text: Str.submitTxt.toUpperCase(),
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
