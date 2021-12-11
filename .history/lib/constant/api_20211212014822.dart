String defaultUserImage =
    "https://villasearch.de/market/resources/assets/images/user.jpg";

class API {
  static Uri loginUrl = Uri.parse("http://127.0.0.1:8001/api/auth/login");
  Uri registerUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/regsiter");
  Uri forgotPasswordUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/forgot");
  Uri registerSellerUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/seller/store");
  Uri getUserDetailsUrl =
      Uri.parse("https://villasearch.de/market/public/api/user/show/");
}
