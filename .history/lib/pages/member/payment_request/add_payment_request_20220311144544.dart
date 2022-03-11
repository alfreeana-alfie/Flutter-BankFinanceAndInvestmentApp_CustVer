
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/payment_request_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_currency.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';

class MCreatePaymentRequest extends StatefulWidget {
  const MCreatePaymentRequest({Key? key}) : super(key: key);

  @override
  _MCreatePaymentRequestState createState() => _MCreatePaymentRequestState();
}

class _MCreatePaymentRequestState extends State<MCreatePaymentRequest> {
  final ScrollController _scrollController = ScrollController();
  SharedPref sharedPref = SharedPref();
  var controller = ScrollController();
  // late FocusNode myFocusNode;
  // var currentPage = 0;
  // User userLoad = User();
  // List<Customer> customerNewList = [];

  String? currency,
      currencyName,
      amount,
      receiverId,
      receiverName,
      description,
      userId;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.newRequest,
        implyLeading: true,
        context: context,
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      ),
                      SizedBox(
                        child: DropDownUser(
                          users: receiverId,
                          usersName: receiverName,
                          onChanged: (val) {
                            setState(
                              () {
                                receiverId = val!.id.toString();
                                receiverName = val.name;
                              },
                            );
                          },
                        ),
                      ),
                      const Gap(20.0),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                            child: Text(Str.currency,
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
                      ),
                      SizedBox(
                        child: DropDownCurrency(
                          currency: currency,
                          currencyName: currencyName,
                          onChanged: (val) {
                            setState(
                              () {
                                currency = val!.id.toString();
                                currencyName = val.name;
                              },
                            );
                          },
                        ),
                      ),
                      const Gap(20.0),
                      NewField(
                          mandatory: true,
                          onSaved: (val) => amount = val,
                          hintText: Str.amount,
                          labelText: Str.amountNum),
                      const Gap(20.0),
                      NewField(
                          onSaved: (val) => description = val,
                          hintText: Str.description),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Styles.primaryColor,
                  ),
                  // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: elevatedButton(
                    color: Styles.secondaryColor,
                    context: context,
                    callback: () {
                      Map<String, String> body = {
                        Field.currencyId: currency ?? Field.emptyString,
                        Field.amount: amount ?? Field.emptyAmount,
                        Field.status: Status.pending.toString(),
                        Field.description: description ?? Field.emptyString,
                        Field.senderId: userId ?? Field.emptyInt,
                        Field.receiverId: receiverId ?? Field.emptyString,
                        Field.transactionId: '1',
                        Field.branchId: '1',
                        Field.transactionCode:
                              Field.transactionCodeInitials+ '$currencyName-' + getRandomCode(6)
                      };

                      PaymentRequestMethods.add(context, body);
                    },
                    text: Str.newRequest.toUpperCase(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,10),
                  child: backButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();

    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        // userLoad = user;
        userId = user.id.toString();
      });
    } catch (e) {
      print(e);
    }
  }
}
