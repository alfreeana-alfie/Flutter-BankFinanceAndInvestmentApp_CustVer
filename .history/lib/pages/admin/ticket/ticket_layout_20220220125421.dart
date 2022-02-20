import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/ticket.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SupportTicketLayout extends StatefulWidget {
  const SupportTicketLayout({Key? key, this.ticket,  this.type}) : super(key: key);

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

  String? subject, message, supportTicketId, userId;

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
      case :
        
        break;
      default:
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
                    initialValue: widget.type == Field.update ? widget.ticket?.subject : Field.empty,
                    onSaved: (val) => subject = val,
                    hintText: Str.subject,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  const Gap(20.0),
                  NewField(
                    onSaved: (val) => message = val,
                    hintText: Str.message,
                    maxLines: 10,
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
                      width: double.maxFinite,
                      onPressed: () {
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

                        // SupportTicketMethods.add(context, body);
                        Method.add(
                            context,
                            _btnController,
                            body,
                            API.createSupportTicket,
                            Type.ticket,
                            SupportTicketLayout(
                              type: Field.create,
                            ),
                            Str.supportTicketList);
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
