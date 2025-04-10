import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutUserInfo extends StatelessWidget {
  final String name;
  final String number;

  const CheckoutUserInfo({
    super.key,
    required this.name,
    required this.number,

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
           
          ],
        ),
        Text(
          number,
          style: GoogleFonts.poppins(fontSize: 12.sp, color: Color(0xff626262)),
        ),
        heightBox8,
        // Container(
        //   height: 19.h,
        //   width: 49.w,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: const Color.fromARGB(255, 218, 211, 211)),
        //   child: Center(
        //     child: Text(
        //       status,
        //       style: TextStyle(fontSize: 12.sp),
        //     ),
        //   ),
        // ),
        // heightBox8,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         SizedBox(
        //             width: 170,
        //             child: Text(
        //               address,
        //               style: GoogleFonts.poppins(fontSize: 10.sp),
        //             )),
        //         Icon(Icons.location_on_rounded)
        //       ],
        //     ),
        //     GestureDetector(
        //         onTap: addressArrowOntap,
        //         child: Icon(
        //           Icons.arrow_forward_ios_rounded,
        //           size: 18.h,
        //         ))
        //   ],
        // ),
      ],
    );
  }
}
