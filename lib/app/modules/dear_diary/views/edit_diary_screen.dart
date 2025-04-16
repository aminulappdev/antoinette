import 'package:antoinette/app/modules/dear_diary/controllers/all_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/edit_diaries_controller.dart';
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
  final ProfileController profileController = Get.find<ProfileController>();
  final EditDiariesController editDiariesController = EditDiariesController();
  final AllDiariesController allDiariesController =
      Get.find<AllDiariesController>();

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
                  heightBox12,
                  GradientElevatedButton(
                    onPressed: () {
                      onTapToNextButton(widget.userId, desCtrl.text);
                    },
                    text: 'Update',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(String userId, String feeling) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await editDiariesController.editDiaries(userId, feeling);

      if (isSuccess) {
        if (mounted) { 
          allDiariesController.getDiaryList();
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context,
              editDiariesController.errorMessage ?? 'Something went wrong',
              true);
        }
      }
    }
  }
}
