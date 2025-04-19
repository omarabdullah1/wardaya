import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../core/routing/router_imports.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/getCart/cubit/get_cart_cubit.dart';
import '../../logic/getCart/cubit/get_cart_state.dart';

class ProceedPaymentButton extends StatelessWidget {
  const ProceedPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, getCartState) {
        return getCartState.maybeWhen(
          loaded: (cartItems) {
            final totalAmount = cartItems.fold<double>(
              0,
              (sum, item) => sum + (item.product.price.total * item.quantity),
            );
            if (cartItems.isEmpty) {
              return const SizedBox.shrink();
            }
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainRose,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.pushNamed(
                            context,
                            Routes.paymentMethodScreen,
                            arguments: {
                              'amount': totalAmount,
                              'orderId':
                                  'ORD-${DateTime.now().millisecondsSinceEpoch}',
                            },
                          ).then((value) {
                            if (value == true) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.el.paymentSuccessMessage,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }

                              if (context.mounted) {
                                context.read<LayoutCubit>().changeIndex(0);
                              }
                            }
                          });
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.el.proceedToPayment,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0.sp,
                            color: ColorsManager.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${context.el.currencySar}${totalAmount.toStringAsFixed(2)}",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0.sp,
                                color: ColorsManager.white,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorsManager.white,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
