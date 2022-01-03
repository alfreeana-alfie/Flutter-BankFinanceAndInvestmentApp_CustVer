String defaultUserImage =
    'https://villasearch.de/market/resources/assets/images/user.jpg';

// Header Settings
const Map<String, String> headers = {'Accept': 'application/json'};
const Map<String, String> headersMultiPart = {
  'Accept': 'application/json',
  'Content-Type': 'multipart/form-data'
};

String android = 'http://10.0.2.2:8000/api';
String device = 'http://192.168.0.1:8000/api';
String ios = 'http://127.0.0.1:8000/api/';

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

  static Uri userTransactionHistoryList = Uri.parse('$android/user_payment_history/');

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
  static Uri listOfSupportTicket =
      Uri.parse('$android/list_of_support_tickets');

  // Drop Down List(s)
  static Uri listOfCurrency = Uri.parse('$android/list_of_currency');
  static Uri listofFdrPlans = Uri.parse('$android/list_of_fdr_plans');
  static Uri listofUsers = Uri.parse('$android/users');
}

class AdminAPI {
  // Deposit
  static Uri listOfDeposit = Uri.parse('$android/list_of_deposit');
  static Uri createDeposit = Uri.parse('$android/create_deposit');

  // Users
  static Uri listOfUser = Uri.parse('$android/users');
  static Uri listOfUserRole = Uri.parse('$android/list_of_user_roles');
  static Uri listOfPermission = Uri.parse('$android/list_of_access_permission');

  static Uri createUser = Uri.parse('$android/create_user');
  static Uri createUserRole = Uri.parse('$android/user_role');
  static Uri createPermission = Uri.parse('$android/access_permission');

  // Wire Transfer
  static Uri listOfWireTransfer = Uri.parse('$android/list_of_wire_transfer');
  static Uri createWireTransfer = Uri.parse('$android/wire_transfer');
  static Uri updateWireTransferStatus = Uri.parse('$android/update_status/');

  // Loan Product
  static Uri listOfLoanProduct = Uri.parse('$android/list_of_loan_product');
  static Uri createLoanProduct = Uri.parse('$android/loan_product');
  static Uri updateLoanProductStatus =
      Uri.parse('$android/user_loan_request_list/');

  // FDR Packages
  static Uri listOfFdrPackage = Uri.parse('$android/list_of_fdr_plans');
  static Uri createFdrPackage = Uri.parse('$android/fdr_plan');
  static Uri updateFdrPackageStatus = Uri.parse('$android/fdr_update_status/');

  // Branch
  static Uri listOfBranch = Uri.parse('$android/list_of_branches');
  static Uri createBranch = Uri.parse('$android/branch');

  // Other Banks
  static Uri listOfOtherBank = Uri.parse('$android/list_of_other_banks');
  static Uri createOtherBank = Uri.parse('$android/other_bank');
  static Uri updateOtherBankStatus = Uri.parse('$android/update_other_bank/');

  // Currency
  static Uri listOfCurrency = Uri.parse('$android/list_of_currency');
  static Uri createCurrency = Uri.parse('$android/currency');
  static Uri updateCurrencyStatus =
      Uri.parse('$android/update_currency_status/');

  // Service
  static Uri listOfService = Uri.parse('$android/list_of_currency');
  static Uri createService = Uri.parse('$android/list_of_currency');

  // FAQ
  static Uri listOfFaq = Uri.parse('$android/list_of_faqs');
  static Uri createFaq = Uri.parse('$android/create_faq');
  static Uri updateFaqStatus = Uri.parse('$android/update_faq_status/');

  // Testimonials
  static Uri listOfTestimonial = Uri.parse('$android/list_of_testimonials');
  static Uri createTestimonial = Uri.parse('$android/create_testimonial');
  static Uri updateTestimonialStatus =
      Uri.parse('$android/update_testimonial_status/');

  // Teams
  static Uri listOfTeam = Uri.parse('$android/list_of_teams');
  static Uri createTeam = Uri.parse('$android/create_team');

  // Gift Card
  static Uri createGiftCard = Uri.parse('$android/gift_card');
  static Uri listOfGiftCard = Uri.parse('$android/list_of_gift_cards');

  static Uri listOfUsedGiftCard = Uri.parse('$android/list_of_used_gift_cards');

  // Transaction
  static Uri listOfExchangeMoney = Uri.parse('$android/list_of_exchange_money');
  static Uri listOfSendMoney = Uri.parse('$android/list_of_send_money');

  // Navigation
  static Uri createNavigation = Uri.parse('$android/navigation');
  static Uri listOfNavigation = Uri.parse('$android/list_of_navigations');

  static Uri createNavigationItem = Uri.parse('$android/navigation_item');
  static Uri listOfNavigationItem =
      Uri.parse('$android/list_of_navigation_items');
}
