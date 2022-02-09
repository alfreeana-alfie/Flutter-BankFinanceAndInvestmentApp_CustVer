
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/deposit_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/customer.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateDeposit extends StatefulWidget {
  const CreateDeposit({Key? key}) : super(key: key);

  @override
  _CreateDepositState createState() => _CreateDepositState();
}

class _CreateDepositState extends State<CreateDeposit> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
      
  late FocusNode myFocusNode;
  SharedPref sharedPref = SharedPref();
  var controller = ScrollController();
  var currentPage = 0;
  User userLoad = User();
  List<Customer> customerNewList = [];

  String? amount, note, currency, currencyName, toUserId, toUserName, userId;
  String fee = '12.50',
      drCr = 'Y',
      type = 'deposit',
      method = 'deposit',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      otherBankId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = '1';

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
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createDeposit, implyLeading: true, context: context),
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
                    hintText: Str.amount,
                    labelText: Str.amountNum,
                    // maxLines: 10,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.currency, style: Styles.primaryTitle),
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
                      onSaved: (val) => note = val, 
                      hintText: Str.note,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.userId: userId ?? Field.empty,
                          Field.currencyId: currency ?? Field.emptyString,
                          Field.amount: amount ?? Field.emptyAmount,
                          Field.fee: fee,
                          Field.drCr: drCr,
                          Field.type: type,
                          Field.method: method,
                          Field.status: status,
                          Field.note: note ?? Field.emptyString,
                          Field.loanId: loanId,
                          Field.refId: refId,
                          Field.parentId: parentId,
                          Field.otherBankId: otherBankId,
                          Field.gatewayId: gatewayId,
                          Field.createdUserId: toUserId ?? Field.emptyString,
                          Field.updatedUserId: updatedUserId,
                          Field.branchId: branchId,
                          Field.transactionsDetails: note ?? Field.emptyString
                        };

                        // DepositMethods.add(context, body);
                        Method.add(
                            context,
                            _btnController,
                            body,
                            AdminAPI.createDeposit,
                            Type.deposit,
                            RouteSTR.createDeposit,
                            Str.depositList);
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
