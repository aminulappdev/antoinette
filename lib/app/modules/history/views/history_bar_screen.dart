import 'package:antoinette/app/modules/history/views/completed_screen.dart';
import 'package:antoinette/app/modules/history/views/upcoming_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryBar extends StatefulWidget {
  
  const HistoryBar({super.key});

  @override
  State<HistoryBar> createState() => _HistoryBarState();
}

class _HistoryBarState extends State<HistoryBar> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Completed',
                    style: TextStyle(
                        decorationColor: Color(0xffD9A48E),
                        decoration: selectedPage == 0
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        fontSize: 14.sp,
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
                child: Text('Upcoming',
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
              ),
             
            ],
          ),
          heightBox8,
       
          if (selectedPage == 0) ...{
            CompletedScreen(),
          } else if (selectedPage == 1) ...{
            UpcomingScreen()
          } 
        ],
      ),
    );
  }
}
