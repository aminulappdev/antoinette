import 'dart:ui';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthConditionCard extends StatelessWidget {
  final bool isBlur;
  final Color themeColor;
  final String iconPath;
  final String status;
  final String day;
  final String time;
  final String description;
  final VoidCallback lockOntap;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;

  const HealthConditionCard({
    super.key,
    required this.iconPath,
    required this.status,
    required this.day,
    required this.time,
    required this.description,
    required this.lockOntap,
    
    required this.themeColor,
    required this.isBlur, required this.onDeleteTap, required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(iconPath),
                  radius: 20.r,
                ),
                widthBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Color(0xffE9BD0F)),
                    ),
                    Row(
                      children: [
                        Text(
                          day,
                          style: GoogleFonts.poppins(fontSize: 10.sp),
                        ),
                        widthBox8,
                        Text(time, style: GoogleFonts.poppins(fontSize: 10.sp)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 150.w,
                ),
                InkWell(
                  onTap: lockOntap,
                  child: Icon(
                    isBlur == true
                        ? Icons.lock_outline_rounded
                        : Icons.lock_open_outlined,
                    size: 26.h,
                  ),
                ),
                
                PopupMenuButton<int>(
                icon: Icon(Icons.more_vert, size: 24),
                onSelected: (value) {
                  if (value == 1) {
                    // updateOntap(); // Trigger the update action
                  } else if (value == 2) {
                    // deleteOntap(); // Trigger the delete action
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text("Update"),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20),
                          SizedBox(width: 8),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ];
                },
                                )
              ],
            ),
            heightBox8,
            ImageFiltered(
              imageFilter: isBlur == true
                  ? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
                  : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Caveat',
                  fontSize: 14.sp,
                  decoration: TextDecoration.underline,
                ),
                textScaleFactor: 1.25,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:ui';
// import 'package:antoinette/app/utils/responsive_size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HealthConditionCard extends StatelessWidget {
//   final bool isBlur;
//   final Color themeColor;
//   final String iconPath;
//   final String status;
//   final String day;
//   final String time;
//   final String description;
//   final VoidCallback lockOntap;
//   final VoidCallback moreHorizOntap;
//   final VoidCallback updateOntap; // New callback for update
//   final VoidCallback deleteOntap; // New callback for delete

//   const HealthConditionCard({
//     super.key,
//     required this.iconPath,
//     required this.status,
//     required this.day,
//     required this.time,
//     required this.description,
//     required this.lockOntap,
//     required this.themeColor,
//     required this.isBlur,
//     required this.updateOntap, // Passing updateOntap
//     required this.deleteOntap, // Passing deleteOntap
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 175.h,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           color: themeColor,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.grey, width: 1)),
//       child: Padding(
//         padding: EdgeInsets.all(8.0.h),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: AssetImage(iconPath),
//                   radius: 20.r,
//                 ),
//                 widthBox8,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       status,
//                       style: GoogleFonts.poppins(
//                           fontSize: 16.sp, color: Color(0xffE9BD0F)),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           day,
//                           style: GoogleFonts.poppins(fontSize: 10.sp),
//                         ),
//                         widthBox8,
//                         Text(time, style: GoogleFonts.poppins(fontSize: 10.sp)),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   width: 150.w,
//                 ),
//                 InkWell(
//                   onTap: lockOntap,
//                   child: Icon(
//                     isBlur == true
//                         ? Icons.lock_outline_rounded
//                         : Icons.lock_open_outlined,
//                     size: 26.h,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 12.w,
//                 ),
//                 // Use PopupMenuButton for More Options
               
//               ],
//             ),
//             heightBox8,
//             ImageFiltered(
//               imageFilter: isBlur == true
//                   ? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
//                   : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
//               child: Text(
//                 description,
//                 style: TextStyle(
//                   fontFamily: 'Caveat',
//                   fontSize: 14.sp,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textScaleFactor: 1.25,
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
