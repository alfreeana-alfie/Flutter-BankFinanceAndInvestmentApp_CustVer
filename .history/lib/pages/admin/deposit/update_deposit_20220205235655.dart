import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/deposit_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/customer.dart';
import 'package:flutter_banking_app/models/deposit.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateDeposit extends StatefulWidget {
  const UpdateDeposit(
      {Key? key, required this.deposit, required this.notUsed})
      : super(key: key);

  final Transaction deposit;
  final Deposit notUsed;

  @override
  _UpdateDepositState createState() => _UpdateDepositState();
}

class _UpdateDepositState extends State<UpdateDeposit> {
  final ScrollController _scrollController = ScrollController();

  late FocusNode myFocusNode;
  var controller = ScrollController();
  var currentPage = 0;
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  List<Customer> customerNewList = [];

  String? amount, note, currency, currencyName, toUserId, toUserName, userId;
  int? status;
  String? fee,
      otherBankId,
      otherBankName,
      drCr,
      type,
      method,
      loanId,
      refId,
      parentId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      transactionsDetails;

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
          title: Str.createDepositTxt, implyLeading: true, context: context),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.userAccountTxt,
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
                      users: toUserId,
                      usersName: toUserName,
                      onChanged: (val) {
                        setState(
                          () {
                            toUserId = val!.id.toString();
                            toUserName = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => amount = val,
                    hintText: Str.amountTxt,
                    labelText: Str.amountNumTxt,
                    // maxLines: 10,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.currencyTxt, style: Styles.primaryTitle),
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
                  const Gap(20),
                  NewField(
                      initialValue: widget.deposit.note,
                      onSaved: (val) => note = val,
                      hintText: Str.noteTxt),
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
                    initialLabelIndex: status,
                    minWidth: 120,
                    cornerRadius: 7.0,
                    activeBgColors: const [
                      [Styles.warningColor],
                      [Styles.successColor],
                      [Styles.dangerColor]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.black12.withOpacity(0.05),
                    inactiveFgColor: Styles.textColor,
                    totalSwitches: 3,
                    labels: Field.approvelList,
                    onToggle: (index) {
                      // print('switched to: $index');
                      status = index;
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
                        Map<String, String> body = {
                          Field.userId:
                              userId ?? widget.deposit.userId.toString(),
                          Field.currencyId: currency ??
                              widget.deposit.currencyId.toString(),
                          Field.amount: amount ??
                              widget.deposit.amount ??
                              Field.emptyAmount,
                          Field.fee:
                              fee ?? widget.deposit.fee ?? Field.emptyAmount,
                          Field.drCr: drCr ??
                              widget.deposit.drCr ??
                              Field.emptyString,
                          Field.type: type ??
                              widget.deposit.type ??
                              Field.emptyAmount,
                          Field.method: method ??
                              widget.deposit.method ??
                              Field.emptyAmount,
                          Field.status: status.toString(),
                          Field.note: note ??
                              widget.deposit.note ??
                              Field.emptyAmount,
                          Field.loanId: loanId ??
                              widget.deposit.loanId.toString(),
                          Field.refId: refId ??
                              widget.deposit.refId.toString(),
                          Field.parentId: parentId ??
                              widget.deposit.parentId.toString(),
                          Field.otherBankId: otherBankId ??
                              widget.deposit.otherBankId.toString(),
                          Field.gatewayId: gatewayId ??
                              widget.deposit.gatewayId.toString(),
                          Field.createdUserId:
                              userId ?? widget.deposit.userId.toString(),
                          Field.updatedUserId:
                              userId ?? widget.deposit.userId.toString(),
                          Field.branchId: branchId ??
                              widget.deposit.branchId.toString(),
                          Field.transactionsDetails: transactionsDetails ??
                              widget.deposit.transactionsDetails ??
                              Field.emptyAmount
                        };

                        DepositMethods.edit(
                            context, body, widget.deposit.id.toString());
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
