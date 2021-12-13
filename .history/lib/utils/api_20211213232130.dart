String defaultUserImage =
    'https://villasearch.de/market/resources/assets/images/user.jpg';

// API SETUP(S)
class API {
  static const Map<String, String> headers = {'Accept': 'application/json'};
  static const Map<String, String> headersMultiPart = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data'
  };
  

  static Uri login = Uri.parse('http://127.0.0.1:8000/api/auth/login');
  static Uri getUserDetails = Uri.parse('http://127.0.0.1:8000/api/auth/user');
  static Uri logout = Uri.parse('http://127.0.0.1:8000/api/auth/logout');
  
  static Uri sendMoney = Uri.parse('http://127.0.0.1:8000/api/send_money');
  static Uri listOfSendMoney = Uri.parse('http://127.0.0.1:8000/api/list_of_send_money');

  static Uri exchangeMoney = Uri.parse('http://127.0.0.1:8000/api/exchange_money');
  static Uri listOfExchangeMoney = Uri.parse('http://127.0.0.1:8000/api/list_of_exchange_money');

  static Uri wireTransfer = Uri.parse('http://127.0.0.1:8000/api/wire_transfer');
  static Uri listOfWireTransfer = Uri.parse('http://127.0.0.1:8000/api/list_of_wire_transfer');
  
  static Uri paymentRequest = Uri.parse('http://127.0.0.1:8000/api/payment_request');
  static Uri listOfPaymentRequest = Uri.parse('http://127.0.0.1:8000/api/list_of_payment_request');
  
  static Uri loanRequest = Uri.parse('http://127.0.0.1:8000/api/loan_request');
  static Uri 

  static Uri fixedDeposit = Uri.parse('http://127.0.0.1:8000/api/fixed_deposit');
}
