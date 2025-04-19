class CartApiConstants {
  static const String apiBaseUrl = "https://wecareroot.ddns.net:5100/";
  static const String apiBaseUrlForImages = "https://wecareroot.ddns.net:5100";

  // Endpoints
  static const String cart = 'api/cart';
  static const String removeFromCart = "api/cart/remove/{productId}";

  // Full API paths
  static String removeFromCartByIdPath(String productId) =>
      "api/cart/remove/$productId";
}
