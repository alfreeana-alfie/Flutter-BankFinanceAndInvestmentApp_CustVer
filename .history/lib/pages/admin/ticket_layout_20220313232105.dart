import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/ticket.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SupportTicketLayout extends StatefulWidget {
  const SupportTicketLayout({Key? key, this.ticket, this.type})
      : super(key: key);

  final Ticket? ticket;
  final String? type;

  @override
  _CreateSupportTicketState createState() => _CreateSupportTicketState();
}

class _CreateSupportTicketState extends State<SupportTicketLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  int? status, priority;

  String? subject,
      message,
      supportTicketId,
      userId,
      operatorId,
      operatorName,
      closedId,
      closedName;

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
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    switch (widget.type) {
      case Field.updateStatus:
        setState(() {
          subject = widget.ticket!.subject;
          message = widget.ticket!.message;
        });
        break;
      case Field.updatePriority:
        setState(() {
          subject = widget.ticket!.subject;
          message = widget.ticket!.message;
        });
        break;
      case Field.updateOperator:
        setState(() {
          subject = widget.ticket!.subject;
          message = widget.ticket!.message;
        });
        break;
      case Field.updateClosed:
        setState(() {
          subject = widget.ticket!.subject;
          message = widget.ticket!.message;
        });
        break;
      default:
        setState(() {
          subject = Field.empty;
          message = Field.empty;
        });
        break;
    }

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createSupportTicket, implyLeading: true, context: context),
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
                    initialValue: subject,
                    onSaved: (val) => subject = val,
                    hintText: Str.subject,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                    initialValue: message,
                    onSaved: (val) => message = val,
                    hintText: Str.message,
                    maxLines: 10,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20),
                  // ** UPDATE STATUS
                  widget.type == Field.updateStatus
                      ? Row(
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
                        )
                      : const Gap(0),
                  widget.type == Field.updateStatus
                      ? ToggleSwitch(
                          initialLabelIndex:
                              int.parse(widget.ticket?.status ?? Field.empty),
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
                        )
                      : const Gap(0),
                  const Gap(20),
                  // ** UPDATE PRIORITY
                  widget.type == Field.updatePriority
                      ? Row(
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
                        )
                      : const Gap(0),
                  widget.type == Field.updatePriority
                      ? ToggleSwitch(
                          initialLabelIndex: int.parse(
                              widget.ticket?.priority ?? Field.emptyInt),
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
                        )
                      : const Gap(0),
                  const Gap(20),
                  // ** UPDATE OPERATOR
                  widget.type == Field.updateOperator
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                              child: Text(Str.userAccount,
                                  style: Styles.primaryTitle),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                              child: Text(
                                '*',
                                style: TextStyle(color: Styles.dangerColor),
                              ),
                            ),
                          ],
                        )
                      : const Gap(0),
                  widget.type == Field.updateOperator
                      ? SizedBox(
                          child: DropDownUser(
                            users: operatorId,
                            usersName: operatorName,
                            onChanged: (val) {
                              setState(
                                () {
                                  operatorId = val!.id.toString();
                                  operatorName = val.name;
                                },
                              );
                            },
                          ),
                        )
                      : const Gap(0),
                  const Gap(0),
                  // ** UPDATE CLOSED
                  widget.type == Field.updateClosed
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                              child: Text(Str.userAccount,
                                  style: Styles.primaryTitle),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                              child: Text(
                                '*',
                                style: TextStyle(color: Styles.dangerColor),
                              ),
                            ),
                          ],
                        )
                      : const Gap(0),
                  widget.type == Field.updateClosed
                      ? SizedBox(
                          child: DropDownUser(
                            users: closedId,
                            usersName: closedName,
                            onChanged: (val) {
                              setState(
                                () {
                                  closedId = val!.id.toString();
                                  closedName = val.name;
                                },
                              );
                            },
                          ),
                        )
                      : const Gap(0),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      width: double.maxFinite,
                      elevation: 0.0,
                      borderRadius: 15,
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        if (widget.type == Field.updateStatus) {
                          status ??= int.parse(
                              widget.ticket?.status ?? Field.emptyInt);
                          Map<String, String> body = {
                            Field.status: status.toString(),
                          };

                          Method.edit(
                              context,
                              _btnController,
                              body,
                              Uri.parse(
                                  API.updateSupportTicketStatus.toString() +
                                      widget.ticket!.id.toString()),
                              Type.ticket,
                              SupportTicketLayout(
                                type: Field.create,
                              ),
                              Str.supportTicketList,
                              Field.empty);
                        } else if (widget.type == Field.updatePriority) {
                          priority ??= int.parse(widget.ticket?.priority ?? Field.emptyInt);
                          Map<String, String> body = {
                            Field.priority: priority.toString(),
                          };

                          Method.edit(
                              context,
                              _btnController,
                              body,
                              Uri.parse(
                                  API.updateSupportTicketPriority.toString() +
                                      widget.ticket!.id.toString()),
                              Type.ticket,
                              SupportTicketLayout(
                                type: Field.create,
                              ),
                              Str.supportTicketList,
                              Field.empty);
                        } else if (widget.type == Field.updateOperator) {
                          Map<String, String> body = {
                            Field.operatorId: operatorId ??
                                widget.ticket!.operatorId.toString(),
                          };

                          Method.edit(
                              context,
                              _btnController,
                              body,
                              Uri.parse(
                                  API.updateSupportTicketOperator.toString() +
                                      widget.ticket!.id.toString()),
                              Type.ticket,
                              SupportTicketLayout(
                                type: Field.create,
                              ),
                              Str.supportTicketList,
                              Field.empty);
                        } else if (widget.type == Field.updateClosed) {
                          Map<String, String> body = {
                            Field.closedUserId: closedId ??
                                widget.ticket!.closedUserId.toString(),
                          };

                          Method.edit(
                              context,
                              _btnController,
                              body,
                              Uri.parse(
                                  API.updateSupportTicketClosed.toString() +
                                      widget.ticket!.id.toString()),
                              Type.ticket,
                              SupportTicketLayout(
                                type: Field.create,
                              ),
                              Str.supportTicketList,
                              Field.empty);
                        } else {
                          Map<String, String> body = {
                            Field.supportTicketId: '#${getRandomString(12)}',
                            Field.subject: subject ?? Field.emptyString,
                            Field.message: message ?? Field.emptyAmount,
                            Field.senderId: userId ?? Field.emptyString,
                            Field.status: Status.pending.toString(),
                            Field.priority: Status.pending.toString(),
                            Field.operatorId: Field.emptyInt,
                            Field.closedUserId: Field.emptyInt,
                          };

                          Method.add(
                              context,
                              _btnController,
                              body,
                              API.createSupportTicket,
                              Type.ticket,
                              SupportTicketLayout(
                                type: Field.create,
                              ),
                              Str.supportTicketList, user);
                        }
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
