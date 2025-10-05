class AppLinks {
  static const String server = "http://192.168.1.7/duraykish_market/user";

  static const String filesUrl = "http://192.168.1.7/duraykish_market/upload";
  static const String userImageLink = "$filesUrl/user/";
  static const String productImageLink = "$filesUrl/products/";
  static const String deliveryImage = "$filesUrl/delivery/";
  static const String chatImages = "$filesUrl/messages/images/";
  static const String chatVoices = "$filesUrl/messages/voices/";

  //=========================== WebSocket ==============================
  static const String chatWebSocket =
      "ws://192.168.1.6:8080/duraykish_market/server_chat.php";

  // =====================AUTH============================================
  static const String signUpLink = "$server/auth/signup/sign_up.php";
  static const String signUpWithGoogleLink =
      "$server/auth/signup/sign_up_with_google.php";
  static const String verifiUserEmailLink =
      "$server/auth/signup/verifi_user_email.php";
  static const String reSendVerifiCodeLink =
      "$server/auth/re_send_verifi_code.php";
  static const String logInLink = "$server/auth/log/login.php";
  static const String logInWithGoogleLink =
      "$server/auth/log/login_with_google.php";
  static const String enterEmailLink =
      "$server/auth/forgetpass/enter_email.php";
  static const String verifiEmailLink =
      "$server/auth/forgetpass/verifi_email.php";
  static const String resetPasswordLink =
      "$server/auth/forgetpass/reset_password.php";

  // ============================  home  ============================
  static const String categroeisLink = "$server/home/discover/categories.php";
  static const String allProductLink = "$server/home/discover/all_product.php";
  static const String productLink = "$server/home/discover/product.php";

  //filter
  static const String maxPriceAllProductLink =
      "$server/home/discover/filterallproduct/get_max_price_allproduct.php";
  static const String lowHighPriceAllProductLink =
      "$server/home/discover/filterallproduct/low_high_price_allproduct.php";
  static const String highLowPriceAllProductLink =
      "$server/home/discover/filterallproduct/high_low_price_allproduct.php";
  static const String rangePriceAllProductLink =
      "$server/home/discover/filterallproduct/range_price_allproduct.php";
  static const String maxPriceProductLink =
      "$server/home/discover/filterprouduct/max_price_product.php";
  static const String lowHighPriceProductLink =
      "$server/home/discover/filterprouduct/low_high_price_product.php";
  static const String highLowPriceProductLink =
      "$server/home/discover/filterprouduct/high_low_price_product.php";
  static const String rangePriceProductLink =
      "$server/home/discover/filterprouduct/range_price_product.php";

  //============================= Notification ======================

  static const String notificationLinks =
      "$server/home/notification/notification.php";
  static const String notificNotRead =
      "$server/home/notification/notification_not_read.php";
  static const String readNotificationLink =
      "$server/home/notification/read_all_notification.php";
  // ============================== Search ============================

  static const String search = "$server/search/search_product.php";

  // ============================ saved =============================
  static const String addToSavedLink = "$server/saved/add_to_saved.php";
  static const String removeFromSavedLink =
      "$server/saved/remove_from_saved.php";
  static const String getSavedProductLink = "$server/saved/get_saved.php";
  static const String removeAllSavedLink = "$server/saved/remove_all_saved.php";

  //============================ Product Details ===================================

  static const String sizesProductLink =
      "$server/product_details/get_all_size.php";
  static const String colorsProductLink =
      "$server/product_details/get_color.php";
  static const String addToCartLink = "$server/product_details/add_to_cart.php";
  static const String avgRatingReviewLink =
      "$server/product_details/avg_rating_number_review.php";
  static const String countGroupRatingLink =
      "$server/product_details/count_group_by_rating.php";
  static const String reviewsLink =
      "$server/product_details/review_rating_product.php";

  //  =========================== CART ===========================

  static const String getCartLink = "$server/cart/get_cart.php";
  static const String removeOnePieceLink = "$server/cart/remove_one_piece.php";
  static const String deleteAllPieceLink = "$server/cart/delete_all_pieces.php";
  static const String addOnePieceLink = "$server/cart/add_one_piece.php";

  // =========================== Checkout =================================

  static const String getDefaultLoction =
      "$server/checkout/get_default_location.php";
  static const String getDefaultCard = "$server/checkout/get_default_card.php";
  static const String allLocationLink = "$server/checkout/get_all_location.php";
  static const String allCardLink = "$server/checkout/get_all_card.php";
  static const String addCardLink = "$server/checkout/add_card.php";
  static const String addLocationLink = "$server/checkout/add_location.php";
  static const String addCouponLink = "$server/checkout/add_coupon.php";
  static const String addOrderLink = "$server/checkout/checkout.php";

  //============================  Order ==================================
  static const String orderOngoingLisnk =
      "$server/myorder/get_my_order_not_completed.php";
  static const String orderCompletedLink =
      "$server/myorder/get_my_order_completed.php";
  static const String ratingOrderLink = "$server/myorder/rating_product.php";
  static const String myLocationLink =
      "$server/myorder/get_my_location_details.php";
  static const String deliveryLink = "$server/myorder/get_delivery_order.php";

  //=========================== MyDetails ===================================
  static const String upDateMyDetials = "$server/auth/update_my_details.php";

  //=========================== FAQS =========================================
  static const String generalFAQsLink = "$server/FAQs/general_faqs.php";
  static const String topicFAQsLink = "$server/FAQs/the_topic_faqs.php";
  static const String searchFAQsLink = "$server/FAQs/search_faqs.php";

  //========================= UploadFile =====================================
  static const String uploadVoice = "$server/messages/upload_voice.php";
  static const String uploadImage = "$server/messages/upload_image.php";
}








// facebook link: https://duraykish-market.firebaseapp.com/__/auth/handler