String defaultUserImage =
    'https://villasearch.de/market/resources/assets/images/user.jpg';

// Header Settings
const Map<String, String> headers = {'Accept': 'application/json'};
const Map<String, String> headersMultiPart = {
  'Accept': 'application/json',
  'Content-Type': 'multipart/form-data'
};

String android = 'https://villasearch.de/fvis-bank-member-backend/public/api';
// String android = 'https://thegreen.studio/FVIS/fvis-bank-two/public/api';
// String android = 'http://10.0.2.2:8000/api';
String device = 'http://192.168.0.1:8000/api';
String ios = 'http://127.0.0.1:8000/api/';

Uri smsApi = Uri.parse('https://www.bulksmsnigeria.com/api/v1/sms/create');

// API SETUP(S)
class API {
  // User authorizations
  static Uri signUp = Uri.parse('$android/auth/signup');
  static Uri login = Uri.parse('$android/auth/login');
  static Uri getUserDetails = Uri.parse('$android/auth/user');
  static Uri logout = Uri.parse('$android/auth/logout');

  // Send Money
  static Uri sendMoney = Uri.parse('$android/send_money');
  // static Uri listOfSendMoney = Uri.parse('$android/list_of_send_money');
  static Uri userSendMoneyList = Uri.parse('$android/user_send_money_list/');

  static Uri getCurrentRateByFunctionName =
      Uri.parse('$android/get_current_rate/');

  static Uri userTransactionHistoryList =
      Uri.parse('$android/user_payment_history/');

  // Exchange Money
  static Uri exchangeMoney = Uri.parse('$android/exchange_money');
  // static Uri listOfExchangeMoney = Uri.parse('$android/list_of_exchange_money');
  static Uri userExchangeMoneyList =
      Uri.parse('$android/user_exchange_money_list/');

  // Wire Transfer
  static Uri wireTransfer = Uri.parse('$android/wire_transfer');
  // static Uri listOfWireTransfer = Uri.parse('$android/list_of_wire_transfer');
  static Uri userWireTransferList =
      Uri.parse('$android/user_wire_transfer_list/');

  // Payment Request
  static Uri paymentRequest = Uri.parse('$android/payment_request');
  static Uri listOfPaymentRequest =
      Uri.parse('$android/list_of_payment_request');
  static Uri userPaymentRequestList =
      Uri.parse('$android/user_payment_request_list/');

  // Loan Request
  static Uri loanRequest = Uri.parse('$android/loan_request');
  static Uri listOfLoanRequest = Uri.parse('$android/list_of_loan_request');
  static Uri userLoanRequestList =
      Uri.parse('$android/user_loan_request_list/');

  // Fixed Deposit
  static Uri fixedDeposit = Uri.parse('$android/fixed_deposit');
  static Uri listOfFixedDeposit = Uri.parse('$android/list_of_fixed_deposit');
  static Uri userFixedDepositList =
      Uri.parse('$android/user_fixed_deposit_list/');

  // Support Ticket
  static Uri createSupportTicket = Uri.parse('$android/support_ticket');
  static Uri updateSupportTicketStatus =
      Uri.parse('$android/update_support_ticket_status/');
  static Uri updateSupportTicketPriority =
      Uri.parse('$android/assign_priority/');
  static Uri updateSupportTicketOperator =
      Uri.parse('$android/assign_operator_id/');
  static Uri updateSupportTicketClosed =
      Uri.parse('$android/assign_closed_user_id/');
  static Uri listOfSupportTicket =
      Uri.parse('$android/list_of_support_tickets');

  static Uri listOfWallet = Uri.parse('$android/user_wallet_list/');
  static Uri userSavingsAccount = Uri.parse('$android/user_savings/');
  static Uri createWallet = Uri.parse('$android/wallet');
  static Uri updateWallet = Uri.parse('$android/update_wallet/');

  static Uri updateSMS = Uri.parse('$android/update_sms/');

  static Uri createWalletTransaction = Uri.parse('$android/wallet_transaction');
  static Uri updateWalletTransaction =
      Uri.parse('$android/update_wallet_transaction/');

  // Drop Down List(s)
  static Uri listOfCurrency = Uri.parse('$android/list_of_currency');
  static Uri listofFdrPlans = Uri.parse('$android/list_of_fdr_plans');
  static Uri listofUsers = Uri.parse('$android/users');
  static Uri listofCustomer = Uri.parse('$android/users/');

  // Membership
  static Uri upgradeMembership = Uri.parse('$android/upgrade');
  static Uri upgradeCurrentMembership = Uri.parse('$android/upgrade_current/');
  static Uri membershipPlanList = Uri.parse('$android/list_of_membership_plan');
  static Uri userMembershipPlan = Uri.parse('$android/user_membership_plan/');
}

class AdminAPI {
  // Account
  static Uri listOfAccount = Uri.parse('$android/list_of_account');

  // Deposit
  static Uri listOfDeposit = Uri.parse('$android/list_of_deposit');
  static Uri createDeposit = Uri.parse('$android/create_deposit');
  static Uri updateDeposit = Uri.parse('$android/update_deposit/');
  static Uri deleteDeposit = Uri.parse('$android/delete_deposit/');

  // Rate
  static Uri listOfRate = Uri.parse('$android/rate_list');
  // static Uri createDeposit = Uri.parse('$android/create_deposit');
  static Uri updateRate = Uri.parse('$android/update_rate/');
  // static Uri deleteDeposit = Uri.parse('$android/delete_deposit/');

  // Users
  static Uri createUser = Uri.parse('$android/create_user');
  static Uri listOfUser = Uri.parse('$android/users');
  static Uri updateUser = Uri.parse('$android/update_user/');
  static Uri deleteUser = Uri.parse('$android/delete_user/');

  static Uri createUserRole = Uri.parse('$android/user_role');
  static Uri listOfUserRole = Uri.parse('$android/list_of_user_roles');
  static Uri updateUserRole = Uri.parse('$android/update_user_role/');
  static Uri assignRole = Uri.parse('$android/assign_role/');
  static Uri deleteUserRole = Uri.parse('$android/delete_user_role/');

  static Uri createPermission = Uri.parse('$android/access_permission');
  static Uri listOfPermission = Uri.parse('$android/list_of_access_permission');
  static Uri updatePermission = Uri.parse('$android/update_access_permission/');
  static Uri deletePermission = Uri.parse('$android/delete_access_permission/');

  // Wire Transfer
  static Uri listOfWireTransfer = Uri.parse('$android/list_of_wire_transfer');
  static Uri createWireTransfer = Uri.parse('$android/wire_transfer');
  static Uri updateWireTransferStatus = Uri.parse('$android/update_status/');

  // Loan Product
  static Uri listOfLoanProduct = Uri.parse('$android/list_of_loan_product');
  static Uri createLoanProduct = Uri.parse('$android/loan_product');
  static Uri updateLoanProductStatus = Uri.parse('$android/update_status/');
  static Uri updateLoanProduct = Uri.parse('$android/update_loan_product/');
  static Uri deleteLoanProduct = Uri.parse('$android/delete_loan_product/');

  // FDR Packages
  static Uri listOfFdrPackage = Uri.parse('$android/list_of_fdr_plans');
  static Uri createFdrPackage = Uri.parse('$android/fdr_plan');
  static Uri updateFdrPackageStatus = Uri.parse('$android/fdr_update_status/');
  static Uri updateFdrPackage = Uri.parse('$android/fdr_update/');
  static Uri deleteFdrPackage = Uri.parse('$android/delete_fdr/');

  // Branch
  static Uri listOfBranch = Uri.parse('$android/list_of_branches');
  static Uri createBranch = Uri.parse('$android/branch');
  static Uri updateBranch = Uri.parse('$android/update_branch/');
  static Uri deleteBranch = Uri.parse('$android/delete_branch/');

  // Other Banks
  static Uri listOfOtherBank = Uri.parse('$android/list_of_other_banks');
  static Uri createOtherBank = Uri.parse('$android/other_bank');
  static Uri updateOtherBankStatus =
      Uri.parse('$android/update_other_bank_status/');
  static Uri updateOtherBank = Uri.parse('$android/update_other_bank/');
  static Uri deleteOtherBank = Uri.parse('$android/delete_other_bank/');

  // Currency
  static Uri listOfCurrency = Uri.parse('$android/list_of_currency');
  static Uri createCurrency = Uri.parse('$android/currency');
  static Uri updateCurrencyStatus =
      Uri.parse('$android/update_currency_status/');
  static Uri updateCurrency = Uri.parse('$android/update_currency/');
  static Uri deleteCurrency = Uri.parse('$android/delete_currency/');

  // Service
  static Uri listOfService = Uri.parse('$android/list_of_services');
  static Uri createService = Uri.parse('$android/create_service');
  static Uri updateService = Uri.parse('$android/update_service/');
  static Uri deleteService = Uri.parse('$android/delete_service/');

  // FAQ
  static Uri listOfFaq = Uri.parse('$android/list_of_faqs');
  static Uri createFaq = Uri.parse('$android/create_faq');
  static Uri updateFaqStatus = Uri.parse('$android/update_faq_status/');
  static Uri updateFaq = Uri.parse('$android/update_faq/');
  static Uri deleteFaq = Uri.parse('$android/delete_faq/');

  // Testimonials
  static Uri listOfTestimonial = Uri.parse('$android/list_of_testimonials');
  static Uri createTestimonial = Uri.parse('$android/create_testimonial');
  static Uri updateTestimonialStatus =
      Uri.parse('$android/update_testimonial_status/');
  static Uri updateTestimonial = Uri.parse('$android/update_testimonial/');
  static Uri deleteTestimonial = Uri.parse('$android/delete_testimonial/');

  // Teams
  static Uri listOfTeam = Uri.parse('$android/list_of_teams');
  static Uri createTeam = Uri.parse('$android/create_team');
  static Uri updateTeam = Uri.parse('$android/update_team/');
  static Uri deleteTeam = Uri.parse('$android/delete_team/');

  // Gift Card
  static Uri createGiftCard = Uri.parse('$android/gift_card');
  static Uri listOfGiftCard = Uri.parse('$android/list_of_gift_cards');
  static Uri updateGiftCard = Uri.parse('$android/update_gift_card/');
  static Uri deleteGiftCard = Uri.parse('$android/delete_gift_card/');

  static Uri listOfUsedGiftCard = Uri.parse('$android/list_of_used_gift_cards');
  static Uri updateUsedGiftCard = Uri.parse('$android/update_used_time/');
  static Uri updateUsedGiftCardCode = Uri.parse('$android/update_code/');

  // Transaction
  static Uri listOfExchangeMoney = Uri.parse('$android/list_of_exchange_money');
  static Uri listOfSendMoney = Uri.parse('$android/list_of_send_money');
  static Uri listOfWalletTransactions = Uri.parse('$android/wallet_transactions_list');

  // Navigation
  static Uri createNavigation = Uri.parse('$android/navigation');
  static Uri listOfNavigation = Uri.parse('$android/list_of_navigations');
  static Uri updateNavigation = Uri.parse('$android/update_navigation/');
  static Uri deleteNavigation = Uri.parse('$android/delete_navigation/');

  static Uri listOfCustomer = Uri.parse('$android/delete_navigation/');

  static Uri createNavigationItem = Uri.parse('$android/navigation_item');
  static Uri listOfNavigationItem =
      Uri.parse('$android/list_of_navigation_items');
  static Uri updateNavigationItem =
      Uri.parse('$android/update_navigation_item/');
  static Uri deleteNavigationItem =
      Uri.parse('$android/delete_navigation_item/');
}
