class Constants {
  static String appName = "PantryPal";

  static String api = "http://192.168.8.202:8000/api/";
  static String imageApi = "http://192.168.8.202:8000";
  // static String api = "http://10.0.2.2:8000/api/";

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
  static String getFoodByCategoryUrl = api + "get_food_by_category/"; // takes category as parameter
  static String removeFoodUrl = api + "remove_food/"; // takes food Id as parameter
  static String increaseFood = api + "increase_quantity/";
  static String decreaseFood = api + "decrease_quantity/";
      

  static String addItemUrl = api + "add_item/";
  static String getItemsUrl = api + "get_items/";
  static String removeItemUrl =
      api + "remove_item/"; // takes item id as parameter

  static String remoteApi = "https://world.openfoodfacts.org/api/v0/product/";
}
