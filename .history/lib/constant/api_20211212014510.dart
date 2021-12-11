String defaultUserImage =
    "https://villasearch.de/market/resources/assets/images/user.jpg";

// User API
Uri loginUrl = Uri.parse("https://villasearch.de/market/public/api/user/login");
Uri registerUrl =
    Uri.parse("https://villasearch.de/market/public/api/user/regsiter");
Uri forgotPasswordUrl =
    Uri.parse("https://villasearch.de/market/public/api/user/forgot");
Uri registerSellerUrl =
    Uri.parse("https://villasearch.de/market/public/api/user/seller/store");
Uri getUserDetailsUrl =
    Uri.parse("https://villasearch.de/market/public/api/user/show/");

// Misc API
Uri getCategoryListUrl =
    Uri.parse("https://villasearch.de/market/public/api/misc/show/category");
Uri getStateListUrl =
    Uri.parse("https://villasearch.de/market/public/api/misc/show/state");

// Product API
Uri showAllUrl = Uri.parse(
    "https://villasearch.de/market/public/api/prod/show/approved/all");
Uri showProductByCategoryUrl =
    Uri.parse("https://villasearch.de/market/public/api/prod/show/approved");

// Cart API
Uri addToCartUrl =
    Uri.parse("https://villasearch.de/market/public/api/cart/store");
Uri showCartListUrl =
    Uri.parse("https://villasearch.de/market/public/api/cart/show/");
