import 'package:antoinette/app/modules/dear_diary/controllers/add_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/model/feeling_model.dart';
import 'package:antoinette/app/modules/dear_diary/views/dear_diary_screen.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDiaryScreen extends StatefulWidget {
  final String userId;
  static const String routeName = '/edit-diary-screen';
  const EditDiaryScreen({super.key, required this.userId});

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController desCtrl = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final AddDiariesController addDiariesController = AddDiariesController();
  final ProfileController profileController = Get.find<ProfileController>();

  late String userAccessId;
  late String useName;
  String selectedFeeling = '';
  int? selectedFeelingIndex;
   
 


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(name: 'Edit Dear Diary'),
                  heightBox24,
                         
                 TextFormField(
                    controller: desCtrl,
                    style: GoogleFonts.caveat(),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Write note ...',
                      hintStyle: GoogleFonts.caveat(),
                    ),
                  ),
                  heightBox4,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(useName, style: GoogleFonts.caveat(fontSize: 12.sp, color: Color(0xffD9A48E))),
                        Container(height: 1.h, width: 50.w, color: Color(0xffD9A48E)),
                      ],
                    ),
                  ),
                  heightBox12,
                 
                  GradientElevatedButton(
                    onPressed: () {
                      onTapToNextButton(
                        userAccessId,
                        dateController.text,
                        timeController.text,
                        desCtrl.text,
                        selectedFeeling,
                      );
                    },
                    text: 'Save',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(String userId, String date, String time, String des, String feeling) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await addDiariesController.addDiaries(userId, date, time, des, feeling);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Diary added successfully');
          Navigator.pushNamed(context, DearDiaryScreen.routeName);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, addDiariesController.errorMessage ?? 'Something went wrong', true);
        }
      }
    }
  }
}
