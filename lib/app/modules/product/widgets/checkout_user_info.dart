import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutUserInfo extends StatelessWidget {
  final String name;
  final String number;
  final String streetAddress;
  final String appartment;
  final String town;
  final String state;
  final String country; 


  const CheckoutUserInfo({
    super.key,
    required this.name,
    required this.number, required this.streetAddress, required this.appartment, required this.town, required this.state, required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal information',
          style:
              GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.iconButtonThemeColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dataColumn('Name', name),
            dataColumn('Contact', number),
          ],
        ),
        heightBox20,
        Text(
          'Shipping address',
          style:
              GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.iconButtonThemeColor),
        ),
        heightBox8,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Street address',
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          Text(
            streetAddress,
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
        ]),
        heightBox8,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dataColumn('Appartment/Suite', appartment),
            dataColumn('Town/City', town),
          ],
        ),
        heightBox8,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dataColumn('State', state),
            dataColumn('Country', country),
          ],
        ),
      ],
    );
  }

  Widget dataColumn(
    String key,
    String value,
  ) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
