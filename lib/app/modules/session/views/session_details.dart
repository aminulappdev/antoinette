import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/views/session_bar.dart';
import 'package:antoinette/app/modules/session/widgets/session_schedule.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionDetailsScreen extends StatefulWidget {
  static const String routeName = '/session-details-screen';
  const SessionDetailsScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  final SessionDetailsController sessionDetailsController =
      Get.find<SessionDetailsController>();

  @override
  void initState() {
    super.initState();
    sessionDetailsController.getSessionDetails(widget.sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'Session Details'),
              heightBox12,
              GetBuilder<SessionDetailsController>(builder: (controller) {
                // if (controller.inProgress) {
                //   return Center(child: CircularProgressIndicator());
                // }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: controller.sessionModel?.thumbnail != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      '${controller.sessionModel?.thumbnail}'),
                                  fit: BoxFit.fill)
                              : DecorationImage(
                                  image: AssetImage(AssetsPath.demo),
                                  fit: BoxFit.fill)
                          // image: DecorationImage(
                          //     image: AssetImage(AssetsPath.session),
                          //     fit: BoxFit.fill),
                          ),
                    ),
                    heightBox4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 280.w,
                          child: Text(
                            '${controller.sessionModel?.title}',
                            style: GoogleFonts.poppins(fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: RichText(
                            text: TextSpan(
                              text: '₦${controller.sessionModel?.fee}.00',
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' per session',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.sp, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.inProgress
                        ? Text('')
                        : SessionSchedule(
                            date: '',
                            time: '',
                            address: '${controller.sessionModel?.location}',
                          ),
                    heightBox8,
                    SessionBar(
                      sessionId: widget.sessionId,
                    ),
                    heightBox12,
                  ],
                );
              }),
            ],
          ))),
    );
  }
}
