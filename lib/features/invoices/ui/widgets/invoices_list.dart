import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/invoices/data/models/invoice_response.dart';
import 'package:wardaya/features/invoices/logic/cubit/invoices_cubit.dart';
import 'package:wardaya/features/invoices/logic/cubit/invoices_state.dart';
import 'package:wardaya/features/invoices/ui/invoice_details_screen.dart';

import '../../../../core/widgets/loading_widget.dart';

class InvoicesList extends StatelessWidget {
  const InvoicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicesCubit, InvoicesState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            // Trigger loading on initial state
            context.read<InvoicesCubit>().getInvoices();
            return const SizedBox.shrink();
          },
          loading: () {
            // Schedule the dialog to be shown after the current build phase completes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                ),
              );
            });
            return Skeletonizer(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return InvoiceCard(
                    invoice: InvoiceItem(
                      id: 'loading-$index',
                      orderID: [],
                      invoiceDate: DateTime.now(),
                      name: 'Loading...',
                      email: 'loading@example.com',
                      phoneNumber: 'N/A',
                      totalPrice: 0,
                      currency: 'SAR',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      version: 0,
                    ),
                  );
                },
              ),
            );
          },
          success: (invoices) {
            // Dismiss any loading dialogs
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            if (invoices.isEmpty) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: context.screenHeight * 0.8,
                  maxWidth: context.screenWidth.w,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.el.noInvoicesTitle,
                        style: TextStylesInter.font16BlackSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.el.noInvoicesSubtitle,
                        style: TextStylesInter.font15GreyRegular,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                return InvoiceCard(invoice: invoices[index]);
              },
            );
          },
          error: (message) {
            // Dismiss any loading dialogs
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: $message',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final InvoiceItem invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    // Format the date
    final dateFormat = DateFormat('dd MMM, yyyy');
    final formattedDate = dateFormat.format(invoice.invoiceDate);

    // Safely extract the ID suffix
    final idSuffix = invoice.id.length > 8
        ? invoice.id.substring(invoice.id.length - 8)
        : invoice.id;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceDetailsScreen(invoice: invoice),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side - Invoice ID and Customer Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#$idSuffix',
                        style: TextStylesInter.font14BlackSemiBold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        invoice.name,
                        style: TextStylesInter.font14GreyRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Right side - Date and Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStylesInter.font14GreyRegular,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${invoice.currency} ${invoice.totalPrice.toStringAsFixed(0)}',
                      style: TextStylesInter.font16BlackSemiBold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
