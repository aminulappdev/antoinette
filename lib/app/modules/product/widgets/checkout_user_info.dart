import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutUserInfo extends StatelessWidget {
  final String name;
  final String number;
  final String status;
  final String address;
  final VoidCallback editOntap;
  final VoidCallback addressArrowOntap;
  const CheckoutUserInfo({
    super.key,
    required this.name,
    required this.number,
    required this.status,
    required this.address,
    required this.editOntap,
    required this.addressArrowOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(fontSize: 14.sp),
            ),
            GestureDetector(
              onTap: editOntap,
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.edit,
                    size: 18.h,
                  ),
                ),
              ),
            )
          ],
        ),
        Text(
          number,
          style: GoogleFonts.poppins(fontSize: 12.sp, color: Color(0xff626262)),
        ),
        heightBox8,
        Container(
          height: 19.h,
          width: 49.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 218, 211, 211)),
          child: Center(
            child: Text(
              status,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ),
        heightBox8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 170,
                    child: Text(
                      address,
                      style: GoogleFonts.poppins(fontSize: 10.sp),
                    )),
                Icon(Icons.location_on_rounded)
              ],
            ),
            GestureDetector(
                onTap: addressArrowOntap,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.h,
                ))
          ],
        ),
      ],
    );
  }
}
