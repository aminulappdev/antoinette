import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChatAppBar extends StatefulWidget {
  final String name;

  const CustomChatAppBar({
    super.key,
    required this.name,
  });

  @override
  State<CustomChatAppBar> createState() => _CustomChatAppBarState();
}

class _CustomChatAppBarState extends State<CustomChatAppBar> {
  List<CameraDescription>? cameras; // Nullable to handle initialization
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 24.r,
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        Text(
          widget.name,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            color: Color(0xff626262),
            fontWeight: FontWeight.w500,
          ),
        ),
        // Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: GestureDetector(
        //         onTap: () {
        //           if (cameras != null && cameras!.isNotEmpty) {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => CameraScreen(cameras: cameras!),
        //               ),
        //             );
        //           } else {
        //             print('No cameras available');
        //           }
        //         },
        //         child: Icon(
        //           Icons.videocam_sharp,
        //           size: 30.h,
        //         ),
        //       ),
        //     ),
        //     widthBox8,
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: Icon(
        //         Icons.error_outline,
        //         size: 30.h,
        //       ),
        //     ),
        //   ],
        // ),
        Container()
      ],
    );
  }
}
