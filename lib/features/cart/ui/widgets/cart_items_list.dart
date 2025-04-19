import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/logic/addToCart/cubit/add_to_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_state.dart';
import 'package:wardaya/features/cart/logic/removeCart/cubit/remove_cart_cubit.dart';

class CartItemsList extends StatelessWidget {
  final List<GetCartItem> items;

  const CartItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final item = items[index];
            return CartItemTile(item: item);
          },
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final GetCartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductTitle(context),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(child: _buildProductPrice(context)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(child: _buildQuantityControls(context)),
                      _buildRemoveButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: ColorsManager.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: item.product.images.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.images.first,
                fit: BoxFit.cover,
              ),
            )
          : null,
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Text(
      item.product.title ?? 'Unnamed Product',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
        color: ColorsManager.mainRose,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductPrice(BuildContext context) {
    final price = item.product.price is Map
        ? Price.fromJson(item.product.price as Map<String, dynamic>)
        : item.product.price;
    return Text(
      '${price.total} ${price.currency}',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: ColorsManager.mainRose,
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Row(
      children: [
        _buildQuantityButton(
          icon: Icons.remove,
          onPressed: () {
            if (item.quantity >= 1) {
              context.read<RemoveCartCubit>().removeFromCart(
                    item.product.productId,
                  );
            }
          },
        ),
        SizedBox(width: 16.w),
        Text(
          item.quantity.toString(),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: ColorsManager.mainRose,
          ),
        ),
        SizedBox(width: 16.w),
        _buildQuantityButton(
          icon: Icons.add,
          onPressed: () {
            context.read<AddToCartCubit>().addToCart(
                  item.product.productId,
                  1,
                  item.bundleItems.map((e) => e.toString()).toList(),
                );
          },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: ColorsManager.mainRose),
        onPressed: onPressed,
        constraints: BoxConstraints(
          minWidth: 32.w,
          minHeight: 32.h,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: ColorsManager.mainRose,
        size: 24.r,
      ),
      onPressed: () {
        context.read<RemoveCartCubit>().removeFromCart(item.product.productId);
      },
    );
  }
}
