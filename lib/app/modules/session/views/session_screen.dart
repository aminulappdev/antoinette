import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';

import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';

import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionScreen extends StatefulWidget {
  static const String routeName = '/session-screen';
  const SessionScreen({
    super.key,
  });
 
  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {

  AllSessionController allSessionController = Get.find<AllSessionController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() { 
    scrollController.addListener(_loadMoreData);
    // allSessionController.getSessionList();

    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allSessionController.inProgress) {
      allSessionController.getSessionList();
    }
    {
      allSessionController.getSessionList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchBar(
                  shouldBackButton: true,
                  shouldfontButton: false,
                ),
                heightBox12,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 200.w,
                    child: Text(
                      'Shop Your Health Must-Haves',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ),
                ),
                heightBox12,
                GetBuilder<AllSessionController>(
                  builder: (controller) {
                     if (controller.inProgress && controller.page == 1) {
                        return Center(child: CircularProgressIndicator());
                      }
                    return SizedBox(
                      height: 700.h, 
                      width: 250.w,                             
                      child: ListView.builder( 
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.sessionsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 6.h),
                            child: PsychoSupportCard(
                           sessionItemModel: controller.sessionsList[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
