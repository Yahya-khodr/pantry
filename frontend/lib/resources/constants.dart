class Constants {
  static String appName = "PantryPal";

  static String api = "http://192.168.8.202:8000/api/";

  static String loginUrl = api + "login/";
  static String registerUrl = api + "register/";
  static String getUserDetailsUrl = api + "profile/";
  static String updateUserInfoUrl = api + "update_user/";
  static String updateProfileInfoUrl = api + "update_profile/";
  static String updateProfileImageUrl = api + "update_profile_image/";

  static String addProductUrl = api + "add_product/";
  static String getProduct = api + "product/";
  static String getProductByCategory = api + "product_by_category/";

  static String remoteApi = "https://world.openfoodfacts.org/api/v0/product/";
}
