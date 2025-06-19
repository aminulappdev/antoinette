import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
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
  SessionDetailsController sessionDetailsController =
      SessionDetailsController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBox24,
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
               heightBox8,
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(AssetsPath.therapyHeader),
                      fit: BoxFit.fill),
                ),
              ),
              heightBox12,
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 300.w,
                  child: Text(
                    'Let’s talk about what’s been heavy.',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
              ),          
              heightBox12,
              GetBuilder<AllSessionController>(builder: (controller) {
                if (controller.inProgress && controller.page == 1) {
                  return Center(child: CircularProgressIndicator());
                }
                // Check if the list is empty and not in progress
                if (!controller.inProgress &&
                    (controller.allProductList.isEmpty)) {
                  return Center(
                    child: Text(
                      'Data session available',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  );
                }
                return SizedBox(
                  height: 700.h,
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.allProductList.length,
                    itemBuilder: (context, index) {
                      var sessionTitle =
                          controller.allProductList[index].title ?? '';

                      if (searcCtrl.text.isEmpty) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: InkWell(
                              onTap: () {
                                getSessionScreen(
                                    '${controller.allProductList[index].sId}');
                              },
                              child: Container(
                                height: 220.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 170.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${controller.allProductList[index].thumbnail ?? ''}'),
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${controller.allProductList[index].status ?? ''}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  color: Colors.green),
                                            ),
                                            Text(
                                              'Per session: ₦${controller.allProductList[index].fee ?? 0}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16.sp,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 2.h),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${controller.allProductList[index].thumbnail ?? ''}'),
                                            radius: 18.r,
                                          ),
                                          widthBox4,
                                          FittedBox(
                                            child: SizedBox(
                                              width: 250.h,
                                              child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                '${controller.allProductList[index].title ?? ''}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      } else if (sessionTitle
                          .toLowerCase()
                          .contains(searcCtrl.text.toLowerCase())) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 6.h),
                            child: InkWell(
                              onTap: () {
                                getSessionScreen(
                                    '${controller.allProductList[index].sId}');
                              },
                              child: Container(
                                height: 175.h,
                                width: 238.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 133.h,
                                        width: 238.w,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${controller.allProductList[index].thumbnail ?? ''}'),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${controller.allProductList[index].status ?? ''}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10.sp,
                                                    color: Colors.green),
                                              ),
                                              heightBox50,
                                              heightBox30,
                                              Text(
                                                'Per session: ₦${controller.allProductList[index].fee ?? 0}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12.sp,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 2.h),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${controller.allProductList[index].thumbnail ?? ''}'),
                                              radius: 16.r,
                                            ),
                                            widthBox4,
                                            FittedBox(
                                              child: SizedBox(
                                                width: 180.h,
                                                child: Text(
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  controller
                                                          .allProductList[index]
                                                          .title ??
                                                      '',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
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
    );
  }

  Future<void> getSessionScreen(String id) async {
    final bool isSuccess = await sessionDetailsController.getSessionDetails(id);

    if (isSuccess) {
      if (mounted) {
        print('..........................................................');
        print('Session id is : ${sessionDetailsController.sessionModel?.sId}');
        Navigator.pushNamed(context, SessionDetailsScreen.routeName,
            arguments: id);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            sessionDetailsController.errorMessage ?? "Something went wrong",
            true);
      }
    }
  }
}
