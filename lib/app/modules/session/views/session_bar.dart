import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/modules/session/views/about.dart';
import 'package:antoinette/app/modules/session/views/reception.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionBar extends StatefulWidget {
   const SessionBar({super.key, required this.sessionDataModel});
  final SessionDataModel sessionDataModel; 
  @override
  State<SessionBar> createState() => _SessionBarState();
}

class _SessionBarState extends State<SessionBar> {
  

  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            Reception(sessionDataModel: widget.sessionDataModel,),
          } else if (selectedPage == 1) ...{
            About(sessionDataModel: widget.sessionDataModel,)
          }
        ],
      ),
    );
  }
}
