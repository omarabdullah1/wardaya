// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../../../core/theming/colors.dart';
// import '../../../../core/widgets/app_text_button.dart';
// import '../../data/models/address_model.dart';

// class ContinueButton extends StatelessWidget {
//   final AddressModel? address;
//   final String recipientName;
//   final String phoneNumber;
//   final String addressLine1;
//   final String addressLine2;
//   final String area;
//   final LatLng selectedLocation;

//   const ContinueButton({
//     super.key,
//     this.address,
//     required this.recipientName,
//     required this.phoneNumber,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.area,
//     required this.selectedLocation,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppTextButton(
//       buttonText: 'Continue',
//       textStyle: TextStyle(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w600,
//         color: ColorsManager.white,
//       ),
//       backgroundColor: const Color(0xFF006A78),
//       onPressed: () {
//         // Save address and navigate back
//         final updatedAddress = address?.copyWith(
//               recipientName: recipientName,
//               phoneNumber: phoneNumber,
//               addressLine1: addressLine1,
//               addressLine2: addressLine2,
//               area: area,
//               latitude: selectedLocation.latitude,
//               longitude: selectedLocation.longitude,
//             ) ??
//             AddressModel(
//               id: DateTime.now().millisecondsSinceEpoch.toString(),
//               label: recipientName,
//               recipientName: recipientName,
//               phoneNumber: phoneNumber,
//               addressLine1: addressLine1,
//               addressLine2: addressLine2,
//               area: area,
//               latitude: selectedLocation.latitude,
//               longitude: selectedLocation.longitude,
//             );

//         Navigator.pop(context, updatedAddress);
//       },
//     );
//   }
// }
