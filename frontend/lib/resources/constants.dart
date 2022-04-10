class Constants {
  static String appName = "PantryPal";

  static String api = "http://3.21.227.244:3000/api/";
  static String imageApi = "http://3.21.227.244:3000";


  static String loginUrl = api + "login/";
  static String registerUrl = api + "register/";
  static String getUserDetailsUrl = api + "profile/";
  static String updateUserInfoUrl = api + "update_user/";
  static String updateProfileInfoUrl = api + "update_profile/";
  static String updateProfileImageUrl = api + "update_profile_image/";

  static String addProductUrl = api + "add_product/";
  static String getProductUrl = api + "product/";
  static String getProductByCategory =
      api + "product_by_category/"; // takes category as parameter

  static String addFoodUrl = api + "add_food/";
  static String getFoodsUrl = api + "get_foods/";
  static String getRecentFoodsUrl = api + "get_recend_foods/";
  static String getExpiredFoodsUrl = api + "get_expired_foods/";
  static String getFoodByCategoryUrl =
      api + "get_food_by_category/"; // takes category as parameter
  static String removeFoodUrl =
      api + "remove_food/"; // takes food Id as parameter
  static String increaseFood = api + "increase_quantity/";
  static String decreaseFood = api + "decrease_quantity/";

  static String addShopItem = api + "create_item/";
  static String getShopItems = api + "items/";
  static String deleteShopItem = api + "delete_item/";

  static String remoteApi = "https://world.openfoodfacts.org/api/v0/product/";
}
