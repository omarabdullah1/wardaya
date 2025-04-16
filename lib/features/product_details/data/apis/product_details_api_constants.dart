class ProductDetailsApiConstants {
  static const String apiBaseUrl = "https://wecareroot.ddns.net:5100/";
  static const String apiBaseUrlForImages = "https://wecareroot.ddns.net:5100";

  // Endpoints
  static const String productById = "api/products/";
  static const String relatedProducts = "api/products/related/";

  // Full API paths
  static String getProductByIdPath(String productId) =>
      "api/products/$productId";
  static String getRelatedProductsPath(String productId) =>
      "api/products/related/$productId";
}
