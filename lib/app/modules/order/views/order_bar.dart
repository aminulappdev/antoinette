import 'package:antoinette/app/modules/order/views/all_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderBarScreen extends StatefulWidget {
  static const String routeName = '/my-order-screen';
  const OrderBarScreen({super.key});

  @override
  State<OrderBarScreen> createState() => _OrderBarScreenState();
}

class _OrderBarScreenState extends State<OrderBarScreen> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          children: [
            CustomAppBar(name: "My Orders"),
            heightBox12,
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                      onTap: () {
                        selectedPage = 0;
                        setState(() {});
                      },
                      child: Text(
                        'All',
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
                    child: Text('Pending',
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
                  widthBox12,
                   GestureDetector(
                      onTap: () {
                        selectedPage = 2;
                        setState(() {});
                      },
                      child: Text(
                        'Processing',
                        style: TextStyle(
                            decorationColor: Color(0xffD9A48E),
                            decoration: selectedPage == 2
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: selectedPage == 2
                                ? Color(0xffD9A48E)
                                : Color(0xff959595)),
                      )),
                  widthBox12,
                  GestureDetector(
                    onTap: () {
                      selectedPage = 3;
                      setState(() {});
                    },
                    child: Text('Delivered',
                        style: TextStyle(
                          decorationColor: Color(0xffD9A48E),
                          decoration: selectedPage == 3
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: selectedPage == 3
                              ? Color(0xffD9A48E)
                              : Color(0xff959595),
                        )),
                  ),
                   widthBox12,
                  GestureDetector(
                    onTap: () {
                      selectedPage = 4;
                      setState(() {});
                    },
                    child: Text('Canceled',
                        style: TextStyle(
                          decorationColor: Color(0xffD9A48E),
                          decoration: selectedPage == 4
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: selectedPage == 4
                              ? Color(0xffD9A48E)
                              : Color(0xff959595),
                        )),
                  ),
                ],
              ),
            ),
            
            if (selectedPage == 0) ...{
              AllScreen(),
            } else if (selectedPage == 1) ...{
              AllScreen()
            }
            else if (selectedPage == 2) ...{
              AllScreen()
            }
            else if (selectedPage == 3) ...{
              AllScreen()
            }
            else if (selectedPage == 4) ...{
              AllScreen()
            }
          ],
        ),
      ),
    ));
  }
}
