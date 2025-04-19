import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/modules/session/views/about.dart';
import 'package:antoinette/app/modules/session/views/reception.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SessionBar extends StatefulWidget {
   const SessionBar({super.key, required this.sessionId});
  // final SessionDataModel sessionDataModel; 
  final String sessionId;
  
  @override
  State<SessionBar> createState() => _SessionBarState();
}

class _SessionBarState extends State<SessionBar> {

  final SessionDetailsController sessionDetailsController =
      Get.find<SessionDetailsController>();

  @override
  void initState() {
    print('session bar er sessionId ${widget.sessionId}');
    sessionDetailsController.getSessionDetails(widget.sessionId);
    super.initState();
  }
  

  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<SessionDetailsController>(
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        selectedPage = 0;
                        setState(() {});
                      },
                      child: Text(
                        'Reception',
                        style: TextStyle(
                            decorationColor: Color(0xffD9A48E),
                            decoration: selectedPage == 0
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: selectedPage == 0
                                ? Color(0xffD9A48E)
                                : Color(0xff959595)),
                      )),
                  widthBox12,
                  GestureDetector(
                    onTap: () {
                      selectedPage = 1;
                      setState(() {});
                    },
                    child: Text('About',
                        style: TextStyle(
                          decorationColor: Color(0xffD9A48E),
                          decoration: selectedPage == 1
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: selectedPage == 1
                              ? Color(0xffD9A48E)
                              : Color(0xff959595),
                        )),
                  )
                ],
              ),
              if (selectedPage == 0) ...{
                Reception(sessionId: widget.sessionId,),
              } else if (selectedPage == 1) ...{
                About(sessionId: widget.sessionId,)
              }
            ],
          );
        }
      ),
    );
  }
}
