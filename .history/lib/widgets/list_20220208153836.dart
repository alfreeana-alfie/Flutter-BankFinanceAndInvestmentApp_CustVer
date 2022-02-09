import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/card/card_branch.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'card/card_currency.dart';
import 'left_menu.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key, this.type, this.routePath}) : super(key: key);

  final String? type, routePath;

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Uri? url;
  List<Branch> branchList = [];
  List<Currency> currencyList = [];

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
      case Type.loanManagement:
        url = AdminAPI.listOfFdrPackage;
        break;
      case Type.fdrPlan:
        url = AdminAPI.listOfFdrPackage;
        break;
      case Type.fdrPlan:
        url = AdminAPI.listOfFdrPackage;
        break;
      case Type.fdrPlan:
        url = AdminAPI.listOfFdrPackage;
        break;
      case Type.fdrPlan:
        url = AdminAPI.listOfFdrPackage;
        break;

      default:
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
      case 'branch':
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => CardBranch(
              branch: branchList[index],
              branchList: branchList,
              index: index,
            ),
            itemCount: branchList.length,
          ),
        );
      case 'currency':
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
}
