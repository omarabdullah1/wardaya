import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/product_details/logic/product_details/product_details_cubit.dart';
import 'package:wardaya/features/product_details/ui/widgets/product_details_builder.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FavoritesCubit>()..getFavorites(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductDetailsCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorsManager.offWhite,
        body: ProductDetailsBuilder(product: product),
      ),
    );
  }
}
