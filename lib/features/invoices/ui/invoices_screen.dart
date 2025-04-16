import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/features/invoices/logic/cubit/invoices_cubit.dart';

import 'widgets/invoices_list.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: const AppAppBar(title: 'Invoices'),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorsManager.mainRose,
          onRefresh: () async {
            context.read<InvoicesCubit>().getInvoices();
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: 
                InvoicesList(),
          ),
        ),
      ),
    );
  }
}