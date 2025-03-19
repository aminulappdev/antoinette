import 'package:antoinette/app/modules/dear_diary/controllers/model/feelings_model.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/drop_down_button.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDiaryScreen extends StatefulWidget {
  static const String routeName = '/add-diary-screen';
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  List<FeelingsModel> feelingsList = [
    FeelingsModel(
        'Happy', Color(0xffFFD634).withAlpha(10), Color(0xffE9BD0F), () {},
        fontColor: Color(0xffE9BD0F), emojiPath: AssetsPath.angle),
    FeelingsModel(
        'Calm', Color(0xff82FF34).withAlpha(10), Color(0xff5AE205), () {},
        fontColor: Color(0xff5AE205), emojiPath: AssetsPath.happy),
    FeelingsModel(
        'Sad', Color(0xff346EFF).withAlpha(10), Color(0xff346EFF), () {},
        fontColor: Color(0xff346EFF), emojiPath: AssetsPath.sad),
    FeelingsModel(
        'Anxious', Color(0xffC000E7).withAlpha(10), Color(0xffC000E7), () {},
        fontColor: Color(0xffC000E7), emojiPath: AssetsPath.tired),
    FeelingsModel(
        'Angry', Color(0xffFF3434).withAlpha(10), Color(0xffFF3434), () {},
        fontColor: Color(0xffFF3434), emojiPath: AssetsPath.angry),
    FeelingsModel(
        'HAPPY', Color(0xffFF9318).withAlpha(10), Color(0xffFF9318), () {},
        fontColor: Color(0xffFF9318), emojiPath: AssetsPath.muscle),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
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
                          SizedBox(height: 48.h, child: TextFormField())
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
                              Icon(Icons.timer),
                              widthBox8,
                              Text('Time'),
                            ],
                          ),
                          heightBox8,
                          SizedBox(height: 48.h, child: TextFormField())
                        ],
                      ),
                    )
                  ],
                ),
                heightBox12,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropDownButton(
                          option: ['Light Mode', 'Dark Mode', 'Eye Mode'],
                        ),
                        widthBox8,
                        DropDownButton(
                          option: ['cevat', 'poppins', 'outfit'],
                        ),
                      ],
                    )
                  ],
                ),
                heightBox12,
                TextFormField(
                  style: GoogleFonts.caveat(),
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Write note ...',
                      hintStyle: GoogleFonts.caveat()),
                ),
                heightBox4,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Aminul',
                        style: GoogleFonts.caveat(
                            fontSize: 12.sp, color: Color(0xffD9A48E)),
                      ),
                      Container(
                        height: 1.h,
                        width: 50.w,
                        color: Color(0xffD9A48E),
                      )
                    ],
                  ),
                ),
                heightBox12,
                Text(
                  'How Are You Feeling Today?',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                  ),
                ),
                heightBox12,
                SizedBox(
                  height: 250.h,
                  child: GridView.builder(
                    itemCount: feelingsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 44.h,
                          width: 172.w,
                          decoration: BoxDecoration(
                              color: feelingsList[index].bgColor,
                              border: Border.all(
                                  color: feelingsList[index].borderColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 10.r,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage(feelingsList[index].emojiPath),
                                ),
                                widthBox8,
                                Text(
                                  feelingsList[index].name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: feelingsList[index].fontColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GradientElevatedButton(onPressed: () {}, text: 'Save')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
