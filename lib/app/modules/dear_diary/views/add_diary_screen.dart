import 'package:antoinette/app/modules/dear_diary/controllers/add_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/model/feeling_model.dart';
import 'package:antoinette/app/modules/dear_diary/views/dear_diary_screen.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/drop_down_button.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDiaryScreen extends StatefulWidget {
  static const String routeName = '/add-diary-screen';
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
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
   
  final List<FeelingsModel> feelingsList = [
    FeelingsModel('happy', Color(0xffFFD634).withAlpha(10), Color(0xffE9BD0F), () {},
        fontColor: Color(0xffE9BD0F), emojiPath: AssetsPath.angle),
    FeelingsModel('calm', Color(0xff82FF34).withAlpha(10), Color(0xff5AE205), () {},
        fontColor: Color(0xff5AE205), emojiPath: AssetsPath.happy),
    FeelingsModel('sad', Color(0xff346EFF).withAlpha(10), Color(0xff346EFF), () {},
        fontColor: Color(0xff346EFF), emojiPath: AssetsPath.sad),
    FeelingsModel('anxious', Color(0xffC000E7).withAlpha(10), Color(0xffC000E7), () {},
        fontColor: Color(0xffC000E7), emojiPath: AssetsPath.tired),
    FeelingsModel('angry', Color(0xffFF3434).withAlpha(10), Color(0xffFF3434), () {},
        fontColor: Color(0xffFF3434), emojiPath: AssetsPath.angry),
    FeelingsModel('motivated', Color(0xffFF9318).withAlpha(10), Color(0xffFF9318), () {},
        fontColor: Color(0xffFF9318), emojiPath: AssetsPath.muscle),
  ];

  @override
  void initState() {
    super.initState();
    userAccessId = profileController.profileData!.sId!;
    useName = profileController.profileData!.name!;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

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
                  CustomAppBar(name: 'Dear Diary, Just Between Us.'),
                  heightBox24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                widthBox8,
                                Text('Date'),
                              ],
                            ),
                            heightBox8,
                            SizedBox(
                              height: 48.h,
                              child: TextFormField(
                                controller: dateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: InputDecoration(hintText: 'Select date'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 170.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.schedule),
                                widthBox8,
                                Text('Time'),
                              ],
                            ),
                            heightBox8,
                            SizedBox(
                              height: 48.h,
                              child: TextFormField(
                                controller: timeController,
                                readOnly: true,
                                onTap: () => _selectTime(context),
                                decoration: InputDecoration(hintText: 'Select time'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightBox12,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Description', style: GoogleFonts.poppins(fontSize: 14.sp)),
                      Row(
                        children: [
                          DropDownButton(option: ['Light Mode', 'Dark Mode', 'Eye Mode']),
                          widthBox8,
                          DropDownButton(option: ['cevat', 'poppins', 'outfit']),
                        ],
                      )
                    ],
                  ),
                  heightBox12,
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
                  Text('How Are You Feeling Today?', style: GoogleFonts.poppins(fontSize: 14.sp)),
                  heightBox12,
                  SizedBox(
                    height: 250.h,
                    child: GridView.builder(
                      itemCount: feelingsList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = feelingsList[index];
                        final isSelected = selectedFeelingIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFeelingIndex = index;
                              selectedFeeling = item.name;
                              // print('Feeling is $selectedFeeling');
                            });
                          },
                          child: Container(
                            height: 44.h,
                            width: 172.w,
                            decoration: BoxDecoration(
                              color: isSelected ? item.borderColor.withOpacity(0.2) : item.bgColor,
                              border: Border.all(
                                color: isSelected ? item.borderColor : const Color.fromARGB(255, 145, 144, 144),
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10.r,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(item.emojiPath),
                                  ),
                                  widthBox8,
                                  Text(
                                    item.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: item.fontColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
