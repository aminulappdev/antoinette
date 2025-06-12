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
  final String note;

  const CheckoutUserInfo({
    super.key,
    required this.name,
    required this.number,
    required this.streetAddress,
    required this.appartment,
    required this.town,
    required this.state,
    required this.country,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal information',
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.iconButtonThemeColor),
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
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.iconButtonThemeColor),
        ),
        heightBox4,
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
        heightBox5,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dataColumn('Appartment/Suite', appartment),
            dataColumn('Town/City', town),
          ],
        ),
        heightBox5,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dataColumn('State', state),
            dataColumn('Country', country),
          ],
        ),
        heightBox4,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Note',
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          Text(
            note,
            style: GoogleFonts.poppins(fontSize: 14.sp,fontStyle: FontStyle.italic),
          ),
        ]),
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
