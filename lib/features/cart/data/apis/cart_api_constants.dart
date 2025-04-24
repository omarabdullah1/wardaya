class CartApiConstants {
  static const String apiBaseUrl = "https://wecareroot.ddns.net:5100/";
  static const String apiBaseUrlForImages = "https://wecareroot.ddns.net:5100";

  // Endpoints
  static const String cart = 'api/cart';
  static const String removeFromCart = "api/cart/remove/{productId}";
  static const String giftCards = "api/gift-cards";
  static const String signatureUpload = "api/cart/image_upload";
  static const String videoUpload = "api/cart/video_upload";
  static const String checkout = "api/cart/checkout";
  static const String promoCode = "api/promo-codes/validate-promo-code";

  // Full API paths
  static String removeFromCartByIdPath(String productId) =>
      "api/cart/remove/$productId";
}
