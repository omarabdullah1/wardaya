import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/removeCart/cubit/remove_cart_cubit.dart';
import 'package:wardaya/features/cart/ui/widgets/builders/cart_builder.dart';

import '../logic/addToCart/cubit/add_to_cart_cubit.dart';
import '../logic/addToCart/cubit/add_to_cart_state.dart';
import '../logic/removeCart/cubit/remove_cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> styles = ['Handwritten', 'Typed'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                ),
              );
            });
          },
          loaded: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            context.read<GetCartCubit>().getCart();
          },
          error: (message) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return BlocConsumer<RemoveCartCubit, RemoveCartState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingWidget(
                      loadingState: true,
                    ),
                  );
                });
              },
              loaded: (response) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
                context.read<GetCartCubit>().getCart();
              },
              error: (message) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return CartBuilder(styles: styles);
          },
        );
      },
    );
  }
}
