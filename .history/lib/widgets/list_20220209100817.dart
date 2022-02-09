import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/models/deposit.dart';
import 'package:flutter_banking_app/models/faq.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
import 'package:flutter_banking_app/models/gift_card.dart';
import 'package:flutter_banking_app/models/loan_product.dart';
import 'package:flutter_banking_app/models/navigation.dart';
import 'package:flutter_banking_app/models/navigation_item.dart';
import 'package:flutter_banking_app/models/permission.dart';
import 'package:flutter_banking_app/models/rate.dart';
import 'package:flutter_banking_app/models/role.dart';
import 'package:flutter_banking_app/models/service.dart';
import 'package:flutter_banking_app/models/team.dart';
import 'package:flutter_banking_app/models/testimonial.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/pages/admin/loan_managements/loan_product_list.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/card/card_branch.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'card/card_currency.dart';
import 'left_menu.dart';

class CardList extends StatefulWidget {
  const CardList(
      {Key? key,
      required this.type,
      required this.routePath,
      required this.pageName})
      : super(key: key);

  final String type, routePath, pageName;

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Uri? url;
  List<Branch> branchList = [];
  List<Bank> bankList = [];
  List<Currency> currencyList = [];
  List<Question> questionList = [];
  List<PlanFDR> fdrPlanList = [];
  List<GiftCard> giftCardList = [];
  List<LoanProduct> productList = [];
  List<Navigation> navigationList = [];
  List<NavigationItem> navigationItemList = [];
  List<Transaction> transactionList = [];
  List<Deposit> depositList = [];
  List<WalletTransaction> walletTransactionList = [];
  List<Permission> permissionList = [];
  List<UserRole> roleList = [];
  List<Users> userList = [];
  List<Rate> rateList = [];
  List<Service> serviceList = [];
  List<Team> teamList = [];
  List<Testimonial> testimonialList = [];

  // List<Users> _foundUsers = [];
  List<Branch> _foundBranchList = [];
  List<Bank> _foundBankList = [];
  List<Currency> _foundCurrencyList = [];
  List<Question> _foundQuestionList = [];
  List<PlanFDR> _foundFdrPlanList = [];
  List<GiftCard> _foundGiftCardList = [];
  List<LoanProduct> _founPdroductList = [];
  List<Navigation> _foundNavigationList = [];
  List<NavigationItem> _foundNavigationItemList = [];
  List<Transaction> _foundTransactionList = [];
  List<Deposit> _foundDepositList = [];
  List<WalletTransaction> _foundWalletTransactionList = [];
  List<Permission> _foundPermissionList = [];
  List<UserRole> _foundRoleList = [];
  List<Users> _foundUserList = [];
  List<Rate> _foundRateList = [];
  List<Service> _foundServiceList = [];
  List<Team> _foundTeamList = [];
  List<Testimonial> _foundTestimonialList = [];

  Future view() async {
    switch (widget.type) {
      case Type.branch:
        url = AdminAPI.listOfBranch;
        break;
      case Type.currency:
        url = AdminAPI.listOfCurrency;
        break;
      case Type.deposit:
        url = AdminAPI.listOfDeposit;
        break;
      case Type.exchangeMoney:
        url = AdminAPI.listOfExchangeMoney;
        break;
      case Type.faq:
        url = AdminAPI.listOfFaq;
        break;
      case Type.fdrPlan:
        url = AdminAPI.listOfFdrPackage;
        break;
      case Type.giftCard:
        url = AdminAPI.listOfGiftCard;
        break;
      case Type.loanProduct:
        url = AdminAPI.listOfLoanProduct;
        break;
      case Type.navigation:
        url = AdminAPI.listOfNavigation;
        break;
      case Type.navigationItem:
        url = AdminAPI.listOfNavigationItem;
        break;
      case Type.otherBank:
        url = AdminAPI.listOfOtherBank;
        break;
      case Type.userPermission:
        url = AdminAPI.listOfPermission;
        break;
      case Type.rate:
        url = AdminAPI.listOfRate;
        break;
      case Type.sendMoney:
        url = AdminAPI.listOfSendMoney;
        break;
      case Type.service:
        url = AdminAPI.listOfService;
        break;
      case Type.team:
        url = AdminAPI.listOfTeam;
        break;
      case Type.testimonial:
        url = AdminAPI.listOfTestimonial;
        break;
      case Type.giftCardUsed:
        url = AdminAPI.listOfUsedGiftCard;
        break;
      case Type.userList:
        url = AdminAPI.listOfUser;
        break;
      case Type.userRole:
        url = AdminAPI.listOfUserRole;
        break;
      case Type.walletTransaction:
        url = AdminAPI.listOfWalletTransactions;
        break;
      case Type.wireTransfer:
        url = AdminAPI.listOfWireTransfer;
        break;

      default:
        print('NULL URL');
    }

    final response = await http.get(url!, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      switch (widget.type) {
        case Type.branch:
          for (var req in jsonBody[Field.data]) {
            final data = Branch.fromMap(req);
            setState(() {
              branchList.add(data);
            });
          }
          break;
        case Type.currency:
          for (var req in jsonBody[Field.data]) {
            final data = Currency.fromMap(req);
            setState(() {
              currencyList.add(data);
            });
          }
          break;
        case Type.deposit:
          for (var req in jsonBody[Field.data]) {
            final data = Deposit.fromMap(req);
            setState(() {
              depositList.add(data);
            });
          }
          break;
        case Type.exchangeMoney:
          for (var req in jsonBody[Field.data]) {
            final data = Transaction.fromMap(req);
            setState(() {
              transactionList.add(data);
            });
          }
          break;
        case Type.faq:
          for (var req in jsonBody[Field.data]) {
            final data = Question.fromMap(req);
            setState(() {
              questionList.add(data);
            });
          }
          break;
        case Type.fdrPlan:
          for (var req in jsonBody[Field.data]) {
            final data = PlanFDR.fromMap(req);
            setState(() {
              fdrPlanList.add(data);
            });
          }
          break;
        case Type.giftCard:
          for (var req in jsonBody[Field.data]) {
            final data = GiftCard.fromMap(req);
            setState(() {
              giftCardList.add(data);
            });
          }
          break;
        case Type.loanProduct:
          for (var req in jsonBody[Field.data]) {
            final data = LoanProduct.fromMap(req);
            setState(() {
              productList.add(data);
            });
          }
          break;
        case Type.navigation:
          for (var req in jsonBody[Field.data]) {
            final data = Navigation.fromMap(req);
            setState(() {
              navigationList.add(data);
            });
          }
          break;
        case Type.navigationItem:
          for (var req in jsonBody[Field.data]) {
            final data = NavigationItem.fromMap(req);
            setState(() {
              navigationItemList.add(data);
            });
          }
          break;
        case Type.otherBank:
          for (var req in jsonBody[Field.data]) {
            final data = Bank.fromMap(req);
            setState(() {
              bankList.add(data);
            });
          }
          break;
        case Type.userPermission:
          for (var req in jsonBody[Field.data]) {
            final data = Permission.fromMap(req);
            setState(() {
              permissionList.add(data);
            });
          }
          break;
        case Type.rate:
          for (var req in jsonBody[Field.data]) {
            final data = Rate.fromMap(req);
            setState(() {
              rateList.add(data);
            });
          }
          break;
        case Type.sendMoney:
          for (var req in jsonBody[Field.data]) {
            final data = Transaction.fromMap(req);
            setState(() {
              transactionList.add(data);
            });
          }
          break;
        case Type.service:
          for (var req in jsonBody[Field.data]) {
            final data = Service.fromMap(req);
            setState(() {
              serviceList.add(data);
            });
          }
          break;
        case Type.team:
          for (var req in jsonBody[Field.data]) {
            final data = Team.fromMap(req);
            setState(() {
              teamList.add(data);
            });
          }
          break;
        case Type.testimonial:
          for (var req in jsonBody[Field.data]) {
            final data = Testimonial.fromMap(req);
            setState(() {
              testimonialList.add(data);
            });
          }
          break;
        case Type.giftCardUsed:
          for (var req in jsonBody[Field.data]) {
            final data = GiftCard.fromMap(req);
            setState(() {
              giftCardList.add(data);
            });
          }
          break;
        case Type.userList:
          for (var req in jsonBody[Field.data]) {
            final data = Users.fromMap(req);
            setState(() {
              userList.add(data);
            });
          }
          break;
        case Type.userRole:
          for (var req in jsonBody[Field.data]) {
            final data = UserRole.fromMap(req);
            setState(() {
              roleList.add(data);
            });
          }
          break;
        case Type.walletTransaction:
          for (var req in jsonBody[Field.data]) {
            final data = WalletTransaction.fromMap(req);
            setState(() {
              walletTransactionList.add(data);
            });
          }
          break;
        case Type.wireTransfer:
          for (var req in jsonBody[Field.data]) {
            final data = Deposit.fromMap(req);
            setState(() {
              depositList.add(data);
            });
          }
          break;
        default:
          print(Status.failed);
          break;
      }
    } else {
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  void _runFilter(String enteredKeyword) {
    switch (widget.type) {
      case Type.branch:
        List<Branch> results = [];
        if (enteredKeyword.isEmpty) {
          results = branchList;
        } else {
          results = branchList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = branchList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundBranch = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundBranch = results;
        });
        break;
      case Type.currency:
        List<Currency> results = [];
        if (enteredKeyword.isEmpty) {
          results = currencyList;
        } else {
          results = currencyList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = currencyList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundCurrency = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundCurrency = results;
        });
        break;
      default:
    }
  }

  @override
  initState() {
    view();
    _foundBranchList = branchList;
    _foundBankList = bankList;
    _foundCurrencyList = currencyList;
    _foundQuestionList = questionList;
    _foundFdrPlanList = fdrPlanList;
    _foundGiftCardList = giftCardList;
    _founPdroductList = productList;
    _foundNavigationList = navigationList;
    _foundNavigationItemList = navigationItemList;
    _foundTransactionList = transactionList;
    _foundDepositList = depositList;
    _foundWalletTransactionList = walletTransactionList;
    _foundPermissionList = permissionList;
    _foundRoleList = roleList;
    _foundUserList = userList;
    _foundRateList = rateList;
    _foundServiceList = serviceList;
    _foundTeamList = teamList;
    _foundTestimonialList = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.transparentColor,
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Styles.accentColor,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Center(
                    child: Text(
                      widget.pageName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Styles.textColor,
                          fontSize: 19),
                    ),
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, widget.routePath),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Styles.transparentColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Styles.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: Str.search, suffixIcon: const Icon(Icons.search)),
            ),
            _card(),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    switch (widget.type) {
      case Type.branch:
        return Expanded(
          child: _foundBranch.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundBranch.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundBranch[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardBranch(
                        branch: _foundBranch[index],
                        branchList: _foundBranch,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: branchList.length,
                  itemBuilder: (context, index) {
                    return CardBranch(
                      branch: branchList[index],
                      branchList: branchList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.currency:
        return Expanded(
          child: _foundCurrency.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundCurrency.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundCurrency[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardCurrency(
                        currency: _foundCurrency[index],
                        currencyList: _foundCurrency,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: currencyList.length,
                  itemBuilder: (context, index) {
                    return CardCurrency(
                      currency: currencyList[index],
                      currencyList: currencyList,
                      index: index,
                    );
                  },
                ),
        );
      default:
        return const Text('No List');
    }
  }

  _innerContainer() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.transparentColor,
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Styles.accentColor,
                    ),
                  ),
                ),
                const Gap(10),
                Center(
                  child: Text(
                    widget.pageName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Styles.textColor,
                        fontSize: 19),
                  ),
                ),
                const Gap(10),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, widget.routePath),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.transparentColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Styles.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
                labelText: Str.search, suffixIcon: const Icon(Icons.search)),
          ),
          _card(),
        ],
      ),
    );
  }
}
