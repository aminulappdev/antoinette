
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/model/all_session_model.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PsychoSupportCard extends StatefulWidget {

  final AllSessionItemModel sessionItemModel;
  const PsychoSupportCard({
    super.key, required this.sessionItemModel,
  });

  @override
  State<PsychoSupportCard> createState() => _PsychoSupportCardState();
}

class _PsychoSupportCardState extends State<PsychoSupportCard> {

  SessionDetailsController sessionDetailsController = SessionDetailsController();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getSessionScreen,
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
                        image:NetworkImage('${widget.sessionItemModel.thumbnail}'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       ' ${widget.sessionItemModel.status}',
                        style: GoogleFonts.poppins(
                            fontSize: 10.sp, color: Colors.green),
                      ),
                      heightBox50,
                      heightBox30,
                      Text(
                        'Per session: ${widget.sessionItemModel.fee}\$',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: 8.w, vertical: 2.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(AssetsPath.womenBookRead),
                      radius: 16.r,
                    ),
                    widthBox4,
                    Text(
                      '${widget.sessionItemModel.title}',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getSessionScreen() async {
    // print('Hello');
    // print(widget.sessionItemModel.description);
    // print(widget.sessionItemModel.sId);
    final bool isSuccess = await sessionDetailsController
        .getSessionDetails(widget.sessionItemModel.sId!);

    if (isSuccess) {
      if (mounted) {
        print('..........................................................');
        print('Session id is : ${sessionDetailsController.sessionModel?.id}');
        Navigator.pushNamed(context, SessionDetailsScreen.routeName,
            arguments: widget.sessionItemModel.sId!);

      } else {
        if (mounted) {
          showSnackBarMessage(
              context, sessionDetailsController.errorMessage!, true);
        }
      }
    }
  }
}