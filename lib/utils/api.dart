String defaultUserImage =
    'https://villasearch.de/market/resources/assets/images/user.jpg';

  // Header Settings
  const Map<String, String> headers = {'Accept': 'application/json'};
  const Map<String, String> headersMultiPart = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data'
  };

// API SETUP(S)
class API {
  // User authorizations
  static Uri login = Uri.parse('http://127.0.0.1:8000/api/auth/login');
  static Uri getUserDetails = Uri.parse('http://127.0.0.1:8000/api/auth/user');
  static Uri logout = Uri.parse('http://127.0.0.1:8000/api/auth/logout');

  // Send Money
  static Uri sendMoney = Uri.parse('http://127.0.0.1:8000/api/send_money');
  static Uri listOfSendMoney =
      Uri.parse('http://127.0.0.1:8000/api/list_of_send_money');
  static Uri userSendMoneyList =
      Uri.parse('http://127.0.0.1:8000/api/user_send_money_list/');

  // Exchange Money
  static Uri exchangeMoney =
      Uri.parse('http://127.0.0.1:8000/api/exchange_money');
  static Uri listOfExchangeMoney =
      Uri.parse('http://127.0.0.1:8000/api/list_of_exchange_money');
  static Uri userExchangeMoneyList = Uri.parse('');

  // Wire Transfer
  static Uri wireTransfer =
      Uri.parse('http://127.0.0.1:8000/api/wire_transfer');
  static Uri listOfWireTransfer =
      Uri.parse('http://127.0.0.1:8000/api/list_of_wire_transfer');
  static Uri userWireTransferList = Uri.parse('');

  // Payment Request
  static Uri paymentRequest =
      Uri.parse('http://127.0.0.1:8000/api/payment_request');
  static Uri listOfPaymentRequest =
      Uri.parse('http://127.0.0.1:8000/api/list_of_payment_request');
  static Uri userPaymentRequestList =
      Uri.parse('http://127.0.0.1:8000/api/user_payment_request_list/');

  // Loan Request
  static Uri loanRequest = Uri.parse('http://127.0.0.1:8000/api/loan_request');
  static Uri listOfLoanRequest =
      Uri.parse('http://127.0.0.1:8000/api/list_of_loan_request');
  static Uri userLoanRequestList =
      Uri.parse('http://127.0.0.1:8000/api/user_loan_request_list/');

  // Fixed Deposit
  static Uri fixedDeposit =
      Uri.parse('http://127.0.0.1:8000/api/fixed_deposit');
  static Uri listOfFixedDeposit =
      Uri.parse('http://127.0.0.1:8000/api/list_of_fixed_deposit');
  static Uri userFixedDepositList =
      Uri.parse('http://127.0.0.1:8000/api/user_fixed_deposit_list/');

  // Drop Down List(s)
  static Uri listOfCurrency =
      Uri.parse('http://127.0.0.1:8000/api/list_of_currency');
  static Uri listofFdrPlans =
      Uri.parse('http://127.0.0.1:8000/api/list_of_fdr_plans');
  static Uri listofUsers = Uri.parse('http://127.0.0.1:8000/api/users');
}

class AdminAPI {
  // Deposit
  static Uri listOfDeposit = Uri.parse('http://127.0.0.1:8000/api/create_deposit');
  static Uri createDeposit = Uri.parse('http://127.0.0.1:8000/api/list_of_deposit');

  // Users
  static Uri listOfUser = Uri.parse('http://127.0.0.1:8000/api/users');
  static Uri createUser = Uri.parse('http://127.0.0.1:8000/api/create_user');

  // Wire Transfer
  static Uri listOfWireTransfer = Uri.parse('http://127.0.0.1:8000/api/list_of_wire_transfer');
  static Uri createWireTransfer = Uri.parse('http://127.0.0.1:8000/api/wire_transfer');
  static Uri updateWireTransferStatus = Uri.parse('http://127.0.0.1:8000/api/update_status/');

  // Loan Product
  static Uri listOfLoanProduct = Uri.parse('http://127.0.0.1:8000/api/list_of_loan_request');
  static Uri createLoanProduct = Uri.parse('http://127.0.0.1:8000/api/loan_product');
  static Uri updateLoanProductStatus = Uri.parse('http://127.0.0.1:8000/api/user_loan_request_list/');

  // FDR Packages
  static Uri listOfFdrPackage = Uri.parse('http://127.0.0.1:8000/api/list_of_fdr_plans');
  static Uri createFdrPackage = Uri.parse('http://127.0.0.1:8000/api/fdr_plan');
  static Uri updateFdrPackageStatus = Uri.parse('http://127.0.0.1:8000/api/fdr_update_status/');

  // Branch
  static Uri listOfBranch = Uri.parse('http://127.0.0.1:8000/api/list_of_branches');
  static Uri createBranch = Uri.parse('http://127.0.0.1:8000/api/branch');

  // Other Banks
  static Uri listOfOtherBank = Uri.parse('http://127.0.0.1:8000/api/list_of_other_banks');
  static Uri createOtherBank = Uri.parse('http://127.0.0.1:8000/api/other_bank');
  static Uri updateOtherBankStatus = Uri.parse('http://127.0.0.1:8000/api/update_other_bank/');

  // Currency
  static Uri listOfCurrency = Uri.parse('http://127.0.0.1:8000/api/list_of_currency');
  static Uri createCurrency = Uri.parse('http://127.0.0.1:8000/api/currency');
  static Uri updateCurrencyStatus = Uri.parse('http://127.0.0.1:8000/api/update_currency_status/');
}
