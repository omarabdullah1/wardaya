import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/product_details/ui/widgets/product_details_builder.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    log(product.id.toString());
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      body: ProductDetailsBuilder(product: product),
    );
  }
}
