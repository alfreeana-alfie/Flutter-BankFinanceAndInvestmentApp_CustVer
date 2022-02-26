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
import 'package:flutter_banking_app/models/ticket.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user_wallet.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/models/withdraw.dart';
import 'package:flutter_banking_app/pages/admin/branches/branch_layout.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/card/card_bank.dart';
import 'package:flutter_banking_app/widgets/card/card_branch.dart';
import 'package:flutter_banking_app/widgets/card/card_deposit.dart';
import 'package:flutter_banking_app/widgets/card/card_faq.dart';
import 'package:flutter_banking_app/widgets/card/card_fdr_plan.dart';
import 'package:flutter_banking_app/widgets/card/card_gift_card.dart';
import 'package:flutter_banking_app/widgets/card/card_loan_product.dart';
import 'package:flutter_banking_app/widgets/card/card_navigation.dart';
import 'package:flutter_banking_app/widgets/card/card_navigation_item.dart';
import 'package:flutter_banking_app/widgets/card/card_rate.dart';
import 'package:flutter_banking_app/widgets/card/card_service.dart';
import 'package:flutter_banking_app/widgets/card/card_team.dart';
import 'package:flutter_banking_app/widgets/card/card_testimonial.dart';
import 'package:flutter_banking_app/widgets/card/card_user_permission.dart';
import 'package:flutter_banking_app/widgets/card/card_user_role.dart';
import 'package:flutter_banking_app/widgets/card/card_users.dart';
import 'package:flutter_banking_app/widgets/card/card_wallet_transaction.dart';
import 'package:flutter_banking_app/widgets/card/card_withdraw.dart';
import 'package:flutter_banking_app/widgets/card/card_withdraw_admin.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'card/card_currency.dart';
import 'card/card_send_exchange_money.dart';
import 'card/card_users_wallet.dart';
import 'left_menu.dart';

class CardList extends StatefulWidget {
  const CardList(
      {Key? key,
      required this.type,
      this.routePath,
      required this.pageName,
      this.path,
      this.userType})
      : super(key: key);

  final String type, pageName;
  final String? routePath, userType;
  final Widget? path;

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
  List<UserWallet> userWalletList = [];
  List<Withdraw> withdrawList = [];
  List<Ticket> ticketList = [];

  // List<Users> _foundUsers = [];
  List<Branch> _foundBranchList = [];
  List<Bank> _foundBankList = [];
  List<Currency> _foundCurrencyList = [];
  List<Question> _foundQuestionList = [];
  List<PlanFDR> _foundFdrPlanList = [];
  List<GiftCard> _foundGiftCardList = [];
  List<LoanProduct> _foundProductList = [];
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
  List<UserWallet> _foundUserWalletList = [];
  List<Withdraw> _foundWithdrawList = [];
  List<Ticket> _foundTicketList = [];

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
        url = AdminAPI.listOfCustomer;
        break;
      case Type.accountant:
        url = AdminAPI.listOfAccountant;
        break;
      // case Type.ambassador:
      //   url = AdminAPI.listOfAmbassador;
      //   break;
      case Type.accountManager:
        url = AdminAPI.listOfAccountManager;
        break;
      case Type.admin:
        url = AdminAPI.listOfAdmin;
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
      case Type.customer:
        url = AdminAPI.showSavings;
        break;
      case Type.withdraw:
        url = AdminAPI.listOfWithdraw;
        break;
      case Type.ticket:
        url = API.listOfSupportTicket;
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
            final data = Deposit.fromMap(req);
            setState(() {
              depositList.add(data);
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
            final data = Deposit.fromMap(req);
            setState(() {
              depositList.add(data);
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
        case Type.accountant:
          for (var req in jsonBody[Field.data]) {
            final data = Users.fromMap(req);
            setState(() {
              userList.add(data);
            });
          }
          break;
        // case Type.ambassador:
        //   for (var req in jsonBody[Field.data]) {
        //     final data = Users.fromMap(req);
        //     setState(() {
        //       userList.add(data);
        //     });
        //   }
        //   break;
        case Type.accountManager:
          for (var req in jsonBody[Field.data]) {
            final data = Users.fromMap(req);
            setState(() {
              userList.add(data);
            });
          }
          break;
        case Type.admin:
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
        case Type.customer:
          for (var req in jsonBody[Field.data]) {
            final data = UserWallet.fromMap(req);
            setState(() {
              userWalletList.add(data);
            });
          }
          break;
        case Type.withdraw:
          for (var req in jsonBody[Field.data]) {
            final data = Withdraw.fromMap(req);
            setState(() {
              withdrawList.add(data);
            });
          }
          break;
        case Type.ticket:
          for (var req in jsonBody[Field.data]) {
            final data = Ticket.fromMap(req);
            setState(() {
              ticketList.add(data);
            });
          }
          break;
        default:
          print(Status.failed);
          break;
      }
    } else {
      print(response.body);
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
              _foundBranchList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundBranchList = results;
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
              _foundCurrencyList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundCurrencyList = results;
        });
        break;
      case Type.deposit:
        List<Deposit> results = [];
        if (enteredKeyword.isEmpty) {
          results = depositList;
        } else {
          results = depositList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = depositList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundDepositList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundDepositList = results;
        });
        break;
      case Type.exchangeMoney:
        List<Deposit> results = [];
        if (enteredKeyword.isEmpty) {
          results = depositList;
        } else {
          results = depositList
              .where((data) => data.transactionCode!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = depositList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundDepositList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundDepositList = results;
        });
        break;
      case Type.faq:
        List<Question> results = [];
        if (enteredKeyword.isEmpty) {
          results = questionList;
        } else {
          results = questionList
              .where((data) => data.question!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = questionList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundQuestionList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundQuestionList = results;
        });
        break;
      case Type.fdrPlan:
        List<PlanFDR> results = [];
        if (enteredKeyword.isEmpty) {
          results = fdrPlanList;
        } else {
          results = fdrPlanList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = fdrPlanList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundFdrPlanList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundFdrPlanList = results;
        });
        break;
      case Type.giftCard:
        List<GiftCard> results = [];
        if (enteredKeyword.isEmpty) {
          results = giftCardList;
        } else {
          results = giftCardList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = giftCardList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundGiftCardList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundGiftCardList = results;
        });
        break;
      case Type.loanProduct:
        List<LoanProduct> results = [];
        if (enteredKeyword.isEmpty) {
          results = productList;
        } else {
          results = productList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = productList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundProductList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundProductList = results;
        });
        break;
      case Type.navigation:
        List<Navigation> results = [];
        if (enteredKeyword.isEmpty) {
          results = navigationList;
        } else {
          results = navigationList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = navigationList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundNavigationList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundNavigationList = results;
        });
        break;
      case Type.navigationItem:
        List<NavigationItem> results = [];
        if (enteredKeyword.isEmpty) {
          results = navigationItemList;
        } else {
          results = navigationItemList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = navigationItemList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundNavigationItemList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundNavigationItemList = results;
        });
        break;
      case Type.otherBank:
        List<Bank> results = [];
        if (enteredKeyword.isEmpty) {
          results = bankList;
        } else {
          results = bankList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = bankList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundBankList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundBankList = results;
        });
        break;
      case Type.userPermission:
        List<Permission> results = [];
        if (enteredKeyword.isEmpty) {
          results = permissionList;
        } else {
          results = permissionList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = permissionList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundPermissionList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundPermissionList = results;
        });
        break;
      case Type.rate:
        List<Rate> results = [];
        if (enteredKeyword.isEmpty) {
          results = rateList;
        } else {
          results = rateList
              .where((data) => data.functionName!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = rateList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundRateList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundRateList = results;
        });
        break;
      case Type.sendMoney:
        List<Deposit> results = [];
        if (enteredKeyword.isEmpty) {
          results = depositList;
        } else {
          results = depositList
              .where((data) => data.transactionCode!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = depositList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundDepositList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundDepositList = results;
        });
        break;
      case Type.service:
        List<Service> results = [];
        if (enteredKeyword.isEmpty) {
          results = serviceList;
        } else {
          results = serviceList
              .where((data) => data.icon!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = serviceList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundServiceList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundServiceList = results;
        });
        break;
      case Type.team:
        List<Team> results = [];
        if (enteredKeyword.isEmpty) {
          results = teamList;
        } else {
          results = teamList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = teamList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundTeamList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundTeamList = results;
        });
        break;
      case Type.testimonial:
        List<Testimonial> results = [];
        if (enteredKeyword.isEmpty) {
          results = testimonialList;
        } else {
          results = testimonialList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = testimonialList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundTestimonialList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundTestimonialList = results;
        });
        break;
      case Type.giftCardUsed:
        List<GiftCard> results = [];
        if (enteredKeyword.isEmpty) {
          results = giftCardList;
        } else {
          results = giftCardList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = giftCardList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundGiftCardList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundGiftCardList = results;
        });
        break;
      case Type.userList:
        List<Users> results = [];
        if (enteredKeyword.isEmpty) {
          results = userList;
        } else {
          results = userList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = userList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundUserList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundUserList = results;
        });
        break;
      case Type.accountant:
        List<Users> results = [];
        if (enteredKeyword.isEmpty) {
          results = userList;
        } else {
          results = userList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = userList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundUserList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundUserList = results;
        });
        break;
      case Type.accountManager:
        List<Users> results = [];
        if (enteredKeyword.isEmpty) {
          results = userList;
        } else {
          results = userList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = userList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundUserList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundUserList = results;
        });
        break;
      // case Type.ambassador:
      //   List<Users> results = [];
      //   if (enteredKeyword.isEmpty) {
      //     results = userList;
      //   } else {
      //     results = userList
      //         .where((data) => data.name!
      //             .toLowerCase()
      //             .contains(enteredKeyword.toLowerCase()))
      //         .toList();

      //     if (results.isEmpty) {
      //       results = userList
      //           .where((data) => data.id
      //               .toString()
      //               .toLowerCase()
      //               .contains(enteredKeyword.toLowerCase()))
      //           .toList();

      //       setState(() {
      //         _foundUserList = results;
      //       });
      //     }
      //   }

      //   // Refresh the UI
      //   setState(() {
      //     _foundUserList = results;
      //   });
      //   break;
      case Type.admin:
        List<Users> results = [];
        if (enteredKeyword.isEmpty) {
          results = userList;
        } else {
          results = userList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = userList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundUserList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundUserList = results;
        });
        break;
      case Type.userRole:
        List<UserRole> results = [];
        if (enteredKeyword.isEmpty) {
          results = roleList;
        } else {
          results = roleList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = roleList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundRoleList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundRoleList = results;
        });
        break;
      case Type.walletTransaction:
        List<WalletTransaction> results = [];
        if (enteredKeyword.isEmpty) {
          results = walletTransactionList;
        } else {
          results = walletTransactionList
              .where((data) => data.userId!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = walletTransactionList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundWalletTransactionList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundWalletTransactionList = results;
        });
        break;
      case Type.wireTransfer:
        List<Deposit> results = [];
        if (enteredKeyword.isEmpty) {
          results = depositList;
        } else {
          results = depositList
              .where((data) => data.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = depositList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundDepositList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundDepositList = results;
        });
        break;
      case Type.customer:
        List<UserWallet> results = [];
        if (enteredKeyword.isEmpty) {
          results = userWalletList;
        } else {
          results = userWalletList
              .where((data) => data.userPhone!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = userWalletList
                .where((data) => data.memberId
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundUserWalletList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundUserWalletList = results;
        });
        break;
      case Type.withdraw:
        List<Withdraw> results = [];
        if (enteredKeyword.isEmpty) {
          results = withdrawList;
        } else {
          results = withdrawList
              .where((data) => data.id
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = withdrawList
                .where((data) => data.name
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundWithdrawList = results;
            });
          }
        }
        // Refresh the UI
        setState(() {
          _foundWithdrawList = results;
        });
        break;
      case Type.withdraw:
        List<Withdraw> results = [];
        if (enteredKeyword.isEmpty) {
          results = withdrawList;
        } else {
          results = withdrawList
              .where((data) => data.id
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = withdrawList
                .where((data) => data.name
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundWithdrawList = results;
            });
          }
        }
        // Refresh the UI
        setState(() {
          _foundWithdrawList = results;
        });
        break;
      default:
        print('Unable to find');
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
    _foundProductList = productList;
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
    _foundTestimonialList = testimonialList;
    _foundUserWalletList = userWalletList;
    _foundWithdrawList = withdrawList;

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
                  widget.routePath == Type.nullable
                      ? InkWell(
                          // onTap: () => Navigator.pushNamed(context, widget.routePath),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.transparentColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Styles.whiteColor,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => widget.path!,
                            ),
                          ),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Values.horizontalValue * 2),
              child: TextFormField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12.withOpacity(0.05),
                  labelText: Str.search,
                  suffixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                        color: Colors.black12.withOpacity(0.05), width: 0.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                        const BorderSide(color: Styles.dangerColor, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
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
          child: _foundBranchList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundBranchList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundBranchList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardBranch(
                        branch: _foundBranchList[index],
                        branchList: _foundBranchList,
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
          child: _foundCurrencyList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundCurrencyList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundCurrencyList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardCurrency(
                        currency: _foundCurrencyList[index],
                        currencyList: _foundCurrencyList,
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
      case Type.deposit:
        return Expanded(
          child: _foundDepositList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundDepositList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundDepositList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardDeposit(
                        deposit: _foundDepositList[index],
                        depositList: _foundDepositList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return CardDeposit(
                      deposit: depositList[index],
                      depositList: depositList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.exchangeMoney:
        return Expanded(
          child: _foundDepositList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundDepositList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundDepositList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardDeposit(
                        deposit: _foundDepositList[index],
                        depositList: _foundDepositList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return CardDeposit(
                      deposit: depositList[index],
                      depositList: depositList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.faq:
        return Expanded(
          child: _foundQuestionList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundQuestionList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundQuestionList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardFaq(
                        question: _foundQuestionList[index],
                        questionList: _foundQuestionList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: questionList.length,
                  itemBuilder: (context, index) {
                    return CardFaq(
                      question: questionList[index],
                      questionList: questionList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.fdrPlan:
        return Expanded(
          child: _foundFdrPlanList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundFdrPlanList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundFdrPlanList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardPlanFDR(
                        plan: _foundFdrPlanList[index],
                        fdrList: _foundFdrPlanList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: fdrPlanList.length,
                  itemBuilder: (context, index) {
                    return CardPlanFDR(
                      plan: fdrPlanList[index],
                      fdrList: fdrPlanList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.giftCard:
        return Expanded(
          child: _foundGiftCardList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundGiftCardList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundGiftCardList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardGiftCard(
                        giftCard: _foundGiftCardList[index],
                        giftCardList: _foundGiftCardList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: giftCardList.length,
                  itemBuilder: (context, index) {
                    return CardGiftCard(
                      giftCard: giftCardList[index],
                      giftCardList: giftCardList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.loanProduct:
        return Expanded(
          child: _foundProductList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundProductList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundProductList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardLoanProduct(
                        product: _foundProductList[index],
                        productList: _foundProductList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return CardLoanProduct(
                      product: productList[index],
                      productList: productList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.navigation:
        return Expanded(
          child: _foundNavigationList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundNavigationList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundNavigationList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardNavigation(
                        navigation: _foundNavigationList[index],
                        navigationList: _foundNavigationList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: navigationList.length,
                  itemBuilder: (context, index) {
                    return CardNavigation(
                      navigation: navigationList[index],
                      navigationList: navigationList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.navigationItem:
        return Expanded(
          child: _foundNavigationItemList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundNavigationItemList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundNavigationItemList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardNavigationItem(
                        navigationItem: _foundNavigationItemList[index],
                        navigationList: _foundNavigationItemList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: navigationItemList.length,
                  itemBuilder: (context, index) {
                    return CardNavigationItem(
                      navigationItem: navigationItemList[index],
                      navigationList: navigationItemList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.otherBank:
        return Expanded(
          child: _foundBankList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundBankList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundBankList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardBank(
                        bank: _foundBankList[index],
                        bankList: _foundBankList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: bankList.length,
                  itemBuilder: (context, index) {
                    return CardBank(
                      bank: bankList[index],
                      bankList: bankList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.userPermission:
        return Expanded(
          child: _foundPermissionList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundPermissionList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundPermissionList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardPermission(
                        permission: _foundPermissionList[index],
                        permissionList: _foundPermissionList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: permissionList.length,
                  itemBuilder: (context, index) {
                    return CardPermission(
                      permission: permissionList[index],
                      permissionList: permissionList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.rate:
        return Expanded(
          child: _foundRateList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundRateList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundRateList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardRate(
                        rate: _foundRateList[index],
                        rateList: _foundRateList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: rateList.length,
                  itemBuilder: (context, index) {
                    return CardRate(
                      rate: rateList[index],
                      rateList: rateList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.sendMoney:
        return Expanded(
          child: _foundDepositList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundDepositList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundDepositList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardDeposit(
                        deposit: _foundDepositList[index],
                        depositList: _foundDepositList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return CardDeposit(
                      deposit: depositList[index],
                      depositList: depositList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.service:
        return Expanded(
          child: _foundServiceList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundServiceList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundServiceList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardService(
                        service: _foundServiceList[index],
                        serviceList: _foundServiceList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: serviceList.length,
                  itemBuilder: (context, index) {
                    return CardService(
                      service: serviceList[index],
                      serviceList: serviceList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.team:
        return Expanded(
          child: _foundTeamList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundTeamList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundTeamList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardTeam(
                        team: _foundTeamList[index],
                        teamList: _foundTeamList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: teamList.length,
                  itemBuilder: (context, index) {
                    return CardTeam(
                      team: teamList[index],
                      teamList: teamList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.testimonial:
        return Expanded(
          child: _foundTestimonialList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundTestimonialList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundTestimonialList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardTestimonial(
                        testimonial: _foundTestimonialList[index],
                        testimonialList: _foundTestimonialList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: testimonialList.length,
                  itemBuilder: (context, index) {
                    return CardTestimonial(
                      testimonial: testimonialList[index],
                      testimonialList: testimonialList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.giftCardUsed:
        return Expanded(
          child: _foundGiftCardList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundGiftCardList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundGiftCardList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardGiftCard(
                        giftCard: _foundGiftCardList[index],
                        giftCardList: _foundGiftCardList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: giftCardList.length,
                  itemBuilder: (context, index) {
                    return CardGiftCard(
                      giftCard: giftCardList[index],
                      giftCardList: giftCardList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.userList:
        return Expanded(
          child: _foundUserList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUserList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUserList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUser(
                        users: _foundUserList[index],
                        userList: _foundUserList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return CardUser(
                      users: userList[index],
                      userList: userList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.accountant:
        return Expanded(
          child: _foundUserList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUserList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUserList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUser(
                        users: _foundUserList[index],
                        userList: _foundUserList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return CardUser(
                      users: userList[index],
                      userList: userList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.accountManager:
        return Expanded(
          child: _foundUserList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUserList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUserList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUser(
                        users: _foundUserList[index],
                        userList: _foundUserList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return CardUser(
                      users: userList[index],
                      userList: userList,
                      index: index,
                    );
                  },
                ),
        );
      // case Type.ambassador:
      //   return Expanded(
      //     child: _foundUserList.isNotEmpty
      //         ? ListView.builder(
      //             itemCount: _foundUserList.length,
      //             itemBuilder: (context, index) => Card(
      //                 key: ValueKey(_foundUserList[index].id),
      //                 color: Styles.transparentColor,
      //                 elevation: 0.0,
      //                 margin: const EdgeInsets.symmetric(vertical: 10),
      //                 child: CardUser(
      //                   users: _foundUserList[index],
      //                   userList: _foundUserList,
      //                   index: index,
      //                 )),
      //           )
      //         : ListView.builder(
      //             scrollDirection: Axis.vertical,
      //             shrinkWrap: true,
      //             itemCount: userList.length,
      //             itemBuilder: (context, index) {
      //               return CardUser(
      //                 users: userList[index],
      //                 userList: userList,
      //                 index: index,
      //               );
      //             },
      //           ),
      //   );
      case Type.admin:
        return Expanded(
          child: _foundUserList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUserList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUserList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUser(
                        users: _foundUserList[index],
                        userList: _foundUserList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return CardUser(
                      users: userList[index],
                      userList: userList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.userRole:
        return Expanded(
          child: _foundRoleList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundRoleList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundRoleList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUserRole(
                        role: _foundRoleList[index],
                        roleList: _foundRoleList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: roleList.length,
                  itemBuilder: (context, index) {
                    return CardUserRole(
                      role: roleList[index],
                      roleList: roleList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.walletTransaction:
        return Expanded(
          child: _foundWalletTransactionList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundWalletTransactionList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundWalletTransactionList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardWalletTransaction(
                        transaction: _foundWalletTransactionList[index],
                        transactionList: _foundWalletTransactionList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: walletTransactionList.length,
                  itemBuilder: (context, index) {
                    return CardWalletTransaction(
                      transaction: walletTransactionList[index],
                      transactionList: walletTransactionList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.wireTransfer:
        return Expanded(
          child: _foundDepositList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundDepositList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundDepositList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardDeposit(
                        deposit: _foundDepositList[index],
                        depositList: _foundDepositList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return CardDeposit(
                      deposit: depositList[index],
                      depositList: depositList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.customer:
        return Expanded(
          child: _foundUserWalletList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUserWalletList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUserWalletList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUserWallet(
                        users: _foundUserWalletList[index],
                        userList: _foundUserWalletList,
                        index: index,
                        userType: widget.userType,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userWalletList.length,
                  itemBuilder: (context, index) {
                    return CardUserWallet(
                      users: userWalletList[index],
                      userList: userWalletList,
                      index: index,
                      userType: widget.userType,
                    );
                  },
                ),
        );
      case Type.withdraw:
        return Expanded(
          child: _foundWithdrawList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundWithdrawList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundWithdrawList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardWithdrawAdmin(
                        withdraw: _foundWithdrawList[index],
                        withdrawList: _foundWithdrawList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: withdrawList.length,
                  itemBuilder: (context, index) {
                    return CardWithdrawAdmin(
                      withdraw: withdrawList[index],
                      withdrawList: withdrawList,
                      index: index,
                    );
                  },
                ),
        );
      default:
        return const Text('No List');
    }
  }
}
