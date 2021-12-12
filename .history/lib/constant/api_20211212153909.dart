String defaultUserImage =
    "https://villasearch.de/market/resources/assets/images/user.jpg";

// API SETUP(S)
class API {
  static const Map<String, String> headers = {"Accept": "application/json"};
  static const Map<String, String> headersMultiPart = {
    "Accept": "application/json",
    "Content-Type": "multipart/form-data"
  };

  static Uri login = Uri.parse("http://127.0.0.1:8001/api/auth/login");
  static Uri getUserDetails = Uri.parse("http://127.0.0.1:8001/api/auth/user");
  static Uri logout = Uri.parse("http://127.0.0.1:8001/api/auth/logout");
  
  Uri registerUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/regsiter");
  Uri forgotPasswordUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/forgot");
  Uri registerSellerUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/seller/store");
}
