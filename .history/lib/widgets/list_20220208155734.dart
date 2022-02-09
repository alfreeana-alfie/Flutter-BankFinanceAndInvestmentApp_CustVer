import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
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
import 'package:flutter_banking_app/models/role.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
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
  List<Currency> currencyList = [];
  List<Question> questionList = [];
  List<PlanFDR> fdrList = [];
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
  List<Users> _foundUsers = [];

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
            if (mounted) {
              branchList.add(data);
            }
          }
          break;
        case Type.currency:
          for (var req in jsonBody[Field.data]) {
            final data = Currency.fromMap(req);
            if (mounted) {
              currencyList.add(data);
            }
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
    List<Users> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = userList;
    } else {
      results = userList
          .where((user) =>
              user.phone!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      if (results.isEmpty) {
        results = userList
            .where((user) => user.id
                .toString()
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        setState(() {
          _foundUsers = results;
        });
      }
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  initState() {
    // at the beginning, all users are shown
    view();
    _foundUsers = userList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: FutureBuilder(
        future: view(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Styles.accentColor,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  SafeArea(
                    child: Padding(
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
                              Str.branchList,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Styles.textColor,
                                  fontSize: 19),
                            ),
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, widget.routePath!),
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
                  ),
                  _card(),
                  // for (Branch branch in branchList)
                  //   CardBranch(branch: branch),
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget _card() {
    switch (widget.type) {
      case Type.branch:
        // return Expanded(
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) => CardBranch(
        //       branch: branchList[index],
        //       branchList: branchList,
        //       index: index,
        //     ),
        //     itemCount: branchList.length,
        //   ),
        // );
        return Expanded(
          child: _foundUsers.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardBranch(
                        branch: _foundUsers[index],
                        branchList: _foundUsers,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CardBranch(
                        branch: branchList[index],
                        branchList: branchList,
                        index: index,
                      );
                  },
                  itemCount: userList.length,
                ),
        );
      case Type.currency:
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CardCurrency(
                currency: currencyList[index],
                currencyList: currencyList,
                index: index,
              );
            },
            itemCount: currencyList.length,
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
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].id),
                        color: Styles.transparentColor,
                        elevation: 0.0,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CardUser(
                          users: _foundUsers[index],
                          userList: _foundUsers,
                          index: index,
                        )),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardUser(
                        users: userList[index],
                        userList: userList,
                        index: index,
                      );
                    },
                    itemCount: userList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
