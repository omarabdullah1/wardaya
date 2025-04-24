// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wardaya/features/address/logic/recipient_details_cubit/recipient_details_cubit.dart';
import 'package:wardaya/features/address/ui/widgets/recipient_details/recipient_details.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../data/models/address_response.dart';

class RecipientDetailsScreen extends StatelessWidget {
  final Address? address;
  const RecipientDetailsScreen({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipientDetailsCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppAppBar(title: 'Recipient Details'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 16.0.h,
            ),
            child: RecipientDetails(
              address: address,
            ),
          ),
        ),
      ),
    );
  }
}
