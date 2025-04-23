import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';
import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
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
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    scrollController.addListener(_loadMoreData);
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
                Row(
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
                    widthBox4,
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.search_rounded,
                                  size: 30.h,
                                  color: AppColors.iconButtonThemeColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: searcCtrl,
                                onChanged: (value) {
                                  setState(() {
                                    search = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                GetBuilder<AllSessionController>(builder: (controller) {
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
                        var sessionTitle =
                            controller.allProductList[index].title;

                        if (searcCtrl.text.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 6.h),
                            child: PsychoSupportCard(
                              sessionItemModel: controller.sessionsList[index],
                            ),
                          );
                        } else if (sessionTitle!
                            .toLowerCase()
                            .contains(searcCtrl.text.toLowerCase())) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 6.h),
                            child: PsychoSupportCard(
                              sessionItemModel: controller.sessionsList[index],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';
// import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
// import 'package:antoinette/app/utils/app_colors.dart';
// import 'package:antoinette/app/utils/responsive_size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SessionScreen extends StatefulWidget {
//   static const String routeName = '/session-screen';
//   const SessionScreen({
//     super.key,
//   });

//   @override
//   State<SessionScreen> createState() => _SessionScreenState();
// }

// class _SessionScreenState extends State<SessionScreen> {
//   AllSessionController allSessionController = Get.find<AllSessionController>();
//   final ScrollController scrollController = ScrollController();
//   final TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     scrollController.addListener(_loadMoreData);
//     super.initState();
    
//   }

//   void _loadMoreData() {
//     if (scrollController.position.extentAfter < 500 &&
//         !allSessionController.inProgress) {
//       allSessionController.page++;  // Increment the page number to load more data
//       allSessionController.fetchAllSession(searchController.text);  // Fetch more data
//     }
//   }

//   void _onSearch() {
//     String query = searchController.text;
//     allSessionController.onSearchQueryChangedSession(query);  // Trigger search
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(12.r),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: CircleAvatar(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         radius: 24.r,
//                         child: Icon(
//                           Icons.arrow_back,
//                         ),
//                       ),
//                     ),
//                     widthBox4,
//                     Expanded(
//                       child: Container(
//                         height: 48.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(color: Colors.grey[300]!),
//                         ),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               onTap: _onSearch,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                 child: Icon(
//                                   Icons.search_rounded,
//                                   size: 30.h,
//                                   color: AppColors.iconButtonThemeColor,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 controller: searchController,
//                                 onChanged: (_) {
//                                   _onSearch(); // Trigger search on text change
//                                 },
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 heightBox12,
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: SizedBox(
//                     width: 200.w,
//                     child: Text(
//                       'Shop Your Health Must-Haves',
//                       style: GoogleFonts.poppins(fontSize: 20),
//                     ),
//                   ),
//                 ),
//                 heightBox12,
//                 // Using Obx for reactivity
//                 Obx(() {
//                   if (allSessionController.inProgress && allSessionController.page == 1) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   return SizedBox(
//                     height: 700.h,
//                     width: 250.w,
//                     child: ListView.builder(
//                       controller: scrollController,
//                       scrollDirection: Axis.vertical,
//                       itemCount: allSessionController.sessionsList.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 4.w, vertical: 6.h),
//                           child: PsychoSupportCard(
//                             sessionItemModel:
//                                 allSessionController.sessionsList[index],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     allSessionController.fetchAllSession(null);
//     super.dispose();
//   }
// }

