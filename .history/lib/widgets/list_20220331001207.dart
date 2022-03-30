import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/pdf_lib/mobile.dart'
    if (dart.library.html) 'package:flutter_banking_app/methods/pdf_lib/web.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/models/deposit.dart';
import 'package:flutter_banking_app/models/faq.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
import 'package:flutter_banking_app/models/gift_card.dart';
import 'package:flutter_banking_app/models/loan_product.dart';
import 'package:flutter_banking_app/models/loans.dart';
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
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_wallet.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/models/withdraw.dart';
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
import 'package:flutter_banking_app/widgets/card/card_ticket_admin.dart';
import 'package:flutter_banking_app/widgets/card/card_user_permission.dart';
import 'package:flutter_banking_app/widgets/card/card_user_role.dart';
import 'package:flutter_banking_app/widgets/card/card_users.dart';
import 'package:flutter_banking_app/widgets/card/card_wallet_transaction.dart';
import 'package:flutter_banking_app/widgets/card/card_admin_withdraw.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'card/card_admin_loan.dart';
import 'card/card_currency.dart';
import 'card/card_send_money.dart';
import 'card/card_staff_wire_transfer.dart';
import 'card/card_users_wallet.dart';
import 'card/card_admin_wire_transfer.dart';
import 'left_menu.dart';

class CardList extends StatefulWidget {
  const CardList(
      {Key? key,
      required this.type,
      this.routePath,
      required this.pageName,
      this.path,
      this.userType,
      this.month,
      this.startDate,
      this.endDate,
      this.branchId})
      : super(key: key);

  final String type, pageName;
  final String? routePath, userType;
  final Widget? path;
  final String? startDate, endDate, month, branchId;

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Uri? url;
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

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
  List<Loan> loanList = [];

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
  List<Loan> _foundLoanList = [];

  int? currentRate;

  Future view() async {
    switch (widget.type) {
      case Type.branch:
        url = AdminAPI.listOfBranch;
        break;
      case Type.branchStaff:
        url =
            Uri.parse(API.listofStaffByBranches.toString() + widget.branchId!);
        break;
      case Type.loan:
        url = AdminAPI.listOfLoanRequest;
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
      case Type.customerAdmin:
        url = AdminAPI.listOfCustomer;
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
      case Type.filterWalletTransaction:
        if (widget.startDate != null && widget.endDate != null) {
          url = Uri.parse(AdminAPI.listOfFilterWalletTransactions.toString() +
              widget.startDate! +
              '/' +
              widget.endDate!);
        } else {
          url = Uri.parse(
              AdminAPI.listOfFilterSingleDateWalletTransactions.toString() +
                  widget.startDate!);
        }
        break;
      case Type.filterWalletTransactionByMonth:
        url = Uri.parse(
            AdminAPI.listOfFilterWalletTransactionsByMonth.toString() +
                widget.month!);
        break;
      case Type.wireTransfer:
        url = AdminAPI.listOfWireTransfer;
        break;
      case Type.staffWireTransfer:
        User user = User.fromJSON(await sharedPref.read(Pref.userData));
        url = Uri.parse(AdminAPI.listOfAssignedWireTransfer.toString() +
            user.id.toString());
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
        case Type.branchStaff:
          for (var req in jsonBody[Field.data]) {
            final data = Users.fromMap(req);
            setState(() {
              userList.add(data);
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
        case Type.loan:
          for (var req in jsonBody[Field.data]) {
            final data = Loan.fromMap(req);
            setState(() {
              loanList.add(data);
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
        case Type.customerAdmin:
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
        case Type.filterWalletTransaction:
          for (var req in jsonBody[Field.data]) {
            final data = WalletTransaction.fromMap(req);
            setState(() {
              walletTransactionList.add(data);
            });
          }
          break;
        case Type.filterWalletTransactionByMonth:
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
        case Type.staffWireTransfer:
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
      case Type.branchStaff:
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
      case Type.loan:
        List<Loan> results = [];
        if (enteredKeyword.isEmpty) {
          results = loanList;
        } else {
          results = loanList
              .where((data) => data.transactionCode!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = loanList
                .where((data) => data.id
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundLoanList = results;
            });
          }
        }

        // Refresh the UI
        setState(() {
          _foundLoanList = results;
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
      case Type.customerAdmin:
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
              .where((data) => data.createdAt!
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
      case Type.filterWalletTransaction:
        List<WalletTransaction> results = [];
        if (enteredKeyword.isEmpty) {
          results = walletTransactionList;
        } else {
          results = walletTransactionList
              .where((data) => data.createdAt!
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
      case Type.filterWalletTransactionByMonth:
        List<WalletTransaction> results = [];
        if (enteredKeyword.isEmpty) {
          results = walletTransactionList;
        } else {
          results = walletTransactionList
              .where((data) => data.createdAt!
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
      case Type.staffWireTransfer:
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
      case Type.ticket:
        List<Ticket> results = [];
        if (enteredKeyword.isEmpty) {
          results = ticketList;
        } else {
          results = ticketList
              .where((data) => data.id
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            results = ticketList
                .where((data) => data.subject
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList();

            setState(() {
              _foundTicketList = results;
            });
          }
        }
        // Refresh the UI
        setState(() {
          _foundTicketList = results;
        });
        break;
      default:
        print('Unable to find');
    }
  }

  Future getWithdraw() async {
    Uri viewSingleUser =
        Uri.parse(API.getCurrentRateByFunctionName.toString() + 'withdraw');
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      setState(() {
        currentRate = jsonDecode(response.body);
      });
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    loadSharedPrefs();
    getWithdraw();
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
    _foundTicketList = ticketList;
    _foundLoanList = loanList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String monthName = '';

    switch (widget.month) {
      case '01':
        monthName = 'January';
        break;
      case '02':
        monthName = 'February';
        break;
      case '03':
        monthName = 'March';
        break;
      case '04':
        monthName = 'April';
        break;
      case '05':
        monthName = 'May';
        break;
      case '06':
        monthName = 'June';
        break;
      case '07':
        monthName = 'July';
        break;
      case '08':
        monthName = 'August';
        break;
      case '09':
        monthName = 'September';
        break;
      case '10':
        monthName = 'October';
        break;
      case '11':
        monthName = 'November';
        break;
      case '12':
        monthName = 'December';
        break;
      default:
        monthName = 'Month Date';
    }

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
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: widget.startDate != null
                        ? const EdgeInsets.fromLTRB(
                            Values.horizontalValue * 2, 0, 0, 0)
                        : const EdgeInsets.fromLTRB(Values.horizontalValue * 2,
                            0, Values.horizontalValue * 2, 0),
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
                              color: Colors.black12.withOpacity(0.05),
                              width: 0.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                              color: Styles.dangerColor, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.type == Type.walletTransaction)
                  widget.startDate == null
                      ? Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: const Icon(Icons.filter_alt),
                            onTap: () {
                              _showMyDialog(context);
                            },
                          ),
                        )
                      : const Gap(0),
                if (widget.type == Type.filterWalletTransaction)
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CardList(
                              type: Type.walletTransaction,
                              routePath: Type.nullable,
                              pageName: Str.transactionHistory,
                              // path: BranchLayout(
                              //   type: Field.create,
                              // ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
            const Gap(10),
            if (widget.type == Type.walletTransaction)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Values.horizontalValue * 2),
                      // width: double.maxFinite,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          _showMyDialog(context);
                        },
                        child: Text('Weekly Report'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Styles.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Values.horizontalValue * 2),
                      // width: double.maxFinite,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          _showMyDialogMonthly(context);
                        },
                        child: Text('Monthly Report'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Styles.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.type == Type.filterWalletTransaction ||
                widget.type == Type.filterWalletTransactionByMonth)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Values.horizontalValue * 2),
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    //Create a new PDF document
                    PdfDocument document = PdfDocument();
                    //Create a PdfGrid class.
                    PdfGrid grid = PdfGrid();
                    //Add columns to the grid.

                    grid.columns.add(count: 7);

                    //Add a header to the grid.
                    grid.headers.add(1);
                    grid.style = PdfGridStyle(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
                        cellPadding:
                            PdfPaddings(left: 5, right: 5, top: 5, bottom: 5));

                    //Add rows to the grid.
                    PdfGridRow headerTable = grid.headers[0];
                    headerTable.cells[0].value = Str.name;
                    headerTable.cells[1].value = Str.currency;
                    headerTable.cells[2].value = Str.amount;
                    headerTable.cells[3].value = Str.rateAmount;
                    headerTable.cells[4].value = Str.grandTotal;
                    headerTable.cells[5].value = Str.paymentMethod;
                    headerTable.cells[6].value = Str.created;

                    //Create the header with specific bounds
                    PdfPageTemplateElement header = PdfPageTemplateElement(
                        const Rect.fromLTWH(0, 0, 0, 90));

                    //Create the date and time field
                    PdfDateTimeField dateAndTimeField = PdfDateTimeField(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
                    dateAndTimeField.date =
                        DateTime(2020, 2, 10, 13, 13, 13, 13, 13);
                    dateAndTimeField.dateFormatString = 'yyyy';

                    var url =
                        "https://villasearch.de/assets/assets/images/logoTransparent.png";
                    var response = await http.get(Uri.parse(url));
                    var data = response.bodyBytes;

                    //Create the composite field with date field
                    PdfCompositeField compositeField;

                    if (widget.startDate != null && widget.endDate != null) {
                      compositeField = PdfCompositeField(
                          font: PdfStandardFont(PdfFontFamily.helvetica, 19,
                              style: PdfFontStyle.bold),
                          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                          text:
                              'Weekly Report \n Transaction Date: ${widget.startDate} - ${widget.endDate}',
                          fields: <PdfAutomaticField>[dateAndTimeField]);
                    } else if (widget.startDate != null &&
                        widget.endDate == null) {
                      compositeField = PdfCompositeField(
                          font: PdfStandardFont(PdfFontFamily.helvetica, 19,
                              style: PdfFontStyle.bold),
                          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                          text:
                              'Daily Report \n Transaction Date: ${widget.startDate}',
                          fields: <PdfAutomaticField>[dateAndTimeField]);
                    } else {
                      compositeField = PdfCompositeField(
                          font: PdfStandardFont(PdfFontFamily.helvetica, 19,
                              style: PdfFontStyle.bold),
                          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                          text:
                              'Monthly Report \n Transaction Date: $monthName ',
                          fields: <PdfAutomaticField>[dateAndTimeField]);
                    }

                    //Add composite field in header
                    compositeField.draw(
                        header.graphics,
                        Offset(
                            0,
                            50 -
                                PdfStandardFont(PdfFontFamily.helvetica, 19)
                                    .height));

                    //Create a bitmap object.
                    PdfBitmap image = PdfBitmap(data);
                    //Add the header at top of the document
                    document.template.top = header;

                    for (int i = 0; i < walletTransactionList.length; i++) {
                      DateTime tempDate = DateTime.parse(
                          walletTransactionList[i].createdAt ?? '2021-01-01');
                      String createdAt =
                          DateFormat(Styles.formatDate).format(tempDate);

                      //Add rows to the grid.
                      PdfGridRow row = grid.rows.add();
                      row.cells[0].value = walletTransactionList[i].userName;
                      row.cells[1].value = walletTransactionList[i].currency;
                      row.cells[2].value = walletTransactionList[i].amount;
                      row.cells[3].value = walletTransactionList[i].rateAmount;
                      row.cells[4].value = walletTransactionList[i].grandTotal;
                      row.cells[5].value =
                          walletTransactionList[i].paymentMethod;
                      row.cells[6].value = createdAt;
                    }
                    PdfGridBuiltInStyleSettings tableStyleOption =
                        PdfGridBuiltInStyleSettings();
                    tableStyleOption.applyStyleForBandedRows = true;
                    tableStyleOption.applyStyleForHeaderRow = true;
                    //Apply built-in table style.
                    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable1Light,
                        settings: tableStyleOption);
                    //Draw the grid.
                    grid.draw(
                        page: document.pages.add(),
                        bounds: const Rect.fromLTWH(10, 30, 0, 0));

                    //Add a page to the document and get page graphics
                    PdfGraphics graphics = document.pages[0].graphics;

                    //Watermark image
                    PdfGraphicsState state = graphics.save();
                    graphics.setTransparency(0.25);
                    graphics.drawImage(
                        image, const Rect.fromLTWH(0, 0, 512, 512));
                    graphics.restore(state);

                    //Create the footer with specific bounds
                    PdfPageTemplateElement footer =
                        PdfPageTemplateElement(Rect.fromLTWH(0, 0, 0, 50));

                    //Create the page number field
                    PdfPageNumberField pageNumber = PdfPageNumberField(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

                    //Sets the number style for page number
                    pageNumber.numberStyle = PdfNumberStyle.upperRoman;

                    //Create the page count field
                    PdfPageCountField count = PdfPageCountField(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

                    //set the number style for page count
                    count.numberStyle = PdfNumberStyle.upperRoman;

                    //Create the date and time field
                    PdfDateTimeField dateTimeField = PdfDateTimeField(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

                    //Sets the date and time
                    dateTimeField.date =
                        DateTime(2020, 2, 10, 13, 13, 13, 13, 13);

                    //Sets the date and time format
                    dateTimeField.dateFormatString = 'hh\':\'mm\':\'ss';

                    //Create the composite field with page number page count
                    PdfCompositeField compositeField1 = PdfCompositeField(
                        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
                        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                        text: '{0} of {1}',
                        fields: <PdfAutomaticField>[pageNumber, count]);
                    compositeField1.bounds = footer.bounds;

                    //Add the composite field in footer
                    compositeField1.draw(
                        footer.graphics,
                        Offset(
                            0,
                            50 -
                                PdfStandardFont(PdfFontFamily.helvetica, 12)
                                    .height));

                    //Add the footer at the bottom of the document
                    document.template.bottom = footer;
                    //Save the document.
                    List<int> bytes = document.save();
                    //Dispose the document.
                    document.dispose();

                    saveAndLaunchFile(bytes,
                        'weekly_report_${widget.startDate}_${widget.endDate}.pdf');
                  },
                  child: Text('Generate Report'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Styles.secondaryColor,
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
      case Type.branchStaff:
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
                        type: Type.branchStaff,
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
                      type: Type.branchStaff,
                      users: userList[index],
                      userList: userList,
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
      case Type.loan:
        return Expanded(
          child: _foundLoanList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundLoanList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundLoanList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardLoanAdmin(
                        loan: _foundLoanList[index],
                        loanList: _foundLoanList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: loanList.length,
                  itemBuilder: (context, index) {
                    return CardLoanAdmin(
                      loan: loanList[index],
                      loanList: loanList,
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
                      child: CardSendMoney(
                        deposit: _foundDepositList[index],
                        // depositList: _foundDepositList,
                        // index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return CardSendMoney(
                      deposit: depositList[index],
                      // depositList: depositList,
                      // index: index,
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
                        userLoad: userLoad,
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
      case Type.customerAdmin:
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
                        userLoad: userLoad,
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
                      userLoad: userLoad,
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
      case Type.filterWalletTransaction:
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
      case Type.filterWalletTransactionByMonth:
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
                      child: CardAdminWireTransfer(
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
                    return CardAdminWireTransfer(
                      deposit: depositList[index],
                      depositList: depositList,
                      index: index,
                    );
                  },
                ),
        );
      case Type.staffWireTransfer:
        if (depositList.isNotEmpty) {
          return Expanded(
            child: _foundDepositList.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundDepositList.length,
                    itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundDepositList[index].id),
                        color: Styles.transparentColor,
                        elevation: 0.0,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CardStaffWireTransfer(
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
                      return CardStaffWireTransfer(
                        deposit: depositList[index],
                        depositList: depositList,
                        index: index,
                      );
                    },
                  ),
          );
        } else {
          return const Center(child: Text('No List'));
        }
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
                        userType: widget.userType,
                        currentRate: currentRate,
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
                      userType: widget.userType,
                      currentRate: currentRate,
                      userId: userLoad.id.toString(),
                    );
                  },
                ),
        );
      case Type.ticket:
        return Expanded(
          child: _foundTicketList.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundTicketList.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundTicketList[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardTicketAdmin(
                        ticket: _foundTicketList[index],
                        ticketList: _foundTicketList,
                        index: index,
                      )),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ticketList.length,
                  itemBuilder: (context, index) {
                    return CardTicketAdmin(
                      ticket: ticketList[index],
                      ticketList: ticketList,
                      index: index,
                    );
                  },
                ),
        );
      default:
        return const Center(child: Text('No List'));
    }
  }

  DateTime? startDate;
  DateTime? endDate;
  String? month;
  final f = DateFormat('yyyy-MM-dd');
  final m = DateFormat('MM');

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 100),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            color: Styles.whiteColor,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              showTodayButton: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  // DateTime rangeStartDate = args.value.startDate;
                  // DateTime rangeEndDate = args.value.endDate;
                  setState(() {
                    startDate = args.value.startDate;
                    endDate = args.value.endDate;
                  });

                  // print(f.format(args.value.startDate));
                  // print(f.format(args.value.endDate));
                }
              },
              onSubmit: (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CardList(
                      type: Type.filterWalletTransaction,
                      routePath: Type.nullable,
                      pageName: Str.transactionHistory,
                      startDate: f.format(startDate!).toString(),
                      endDate:
                          endDate != null ? f.format(endDate!).toString() : '',
                      // path: BranchLayout(
                      //   type: Field.create,
                      // ),
                    ),
                  ),
                );
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
      },
    );
  }

  Future<void> _showMyDialogMonthly(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 100),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            color: Styles.whiteColor,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              view: DateRangePickerView.year,
              allowViewNavigation: false,
              showActionButtons: true,
              showTodayButton: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  startDate = args.value.startDate;
                });
              },
              onSubmit: (value) {
                print(m.format(startDate!).toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CardList(
                      type: Type.filterWalletTransactionByMonth,
                      routePath: Type.nullable,
                      pageName: Str.transactionHistory,
                      month: m.format(startDate!).toString(),
                    ),
                  ),
                );
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
      },
    );
  }
}
