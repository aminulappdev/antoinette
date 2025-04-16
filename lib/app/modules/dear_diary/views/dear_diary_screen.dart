import 'package:antoinette/app/modules/dear_diary/controllers/access_journal_key_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/all_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/views/add_diary_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/edit_diary_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/set_password_screen.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/custom_pichart.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/health_condition_card.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/mental_status.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DearDiaryScreen extends StatefulWidget {
  static const String routeName = '/dear-diary-screen';
  const DearDiaryScreen({super.key});

  @override
  State<DearDiaryScreen> createState() => _DearDiaryScreenState();
}

class _DearDiaryScreenState extends State<DearDiaryScreen> {
  final AccessJournalPasswordController accessJournalPasswordController =
      AccessJournalPasswordController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final AllDiariesController allDiariesController =
      Get.find<AllDiariesController>();

  List<bool> isBlurList = [];

  @override
  void initState() {
    super.initState();
    allDiariesController.getDiaryList().then((_) {
      setState(() {
        isBlurList = List.generate(
            allDiariesController.allDiaryList.length, (_) => true);
      });
    });
  }

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
                heightBox12,
                CustomSearchBar(shouldBackButton: false),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddDiaryScreen.routeName);
                      },
                      child: Container(
                        height: 42.h,
                        width: 310.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 202, 200, 200)),
                          color: const Color(0xffEDE6E4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.add,
                              color: AppColors.iconButtonThemeColor),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, SetJournalPasswordScreen.routeName);
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 24.r,
                        child: const Icon(Icons.lock),
                      ),
                    )
                  ],
                ),
                heightBox12,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 185.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPiChart(),
                        MentalStatusWidget(
                          toogleOntap: () {},
                        )
                      ],
                    ),
                  ),
                ),
                heightBox8,
                SizedBox(
                  height: 600,
                  child:
                      GetBuilder<AllDiariesController>(builder: (controller) {
                    if (controller.inProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: controller.allDiaryList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: HealthConditionCard(
                            isBlur: isBlurList[index],
                            iconPath: AssetsPath.angle,
                            status:
                                '${controller.allDiaryList[index].feelings}',
                            day: 'Monday',
                            time: '${controller.allDiaryList[index].time}',
                            description:
                                'Today was a good day! The sun felt warm on my face, and I laughed so much with my friends. I want to remember this feeling—light, joyful, and full of possibility.',
                            lockOntap: () {
                              if (!isBlurList[index]) {
                                setState(() {
                                  isBlurList[index] = true;
                                });
                              } else {
                                lockButton(index);
                              }
                            },
                           
                            themeColor: const Color(0xffD9A48E).withAlpha(20), onDeleteTap: () {
                                 
                            }, onEditTap: () {
                                Navigator.pushNamed(context, EditDiaryScreen.routeName,arguments: 'sngggkvukvukvukvukvukvukvukvukvukvukvu');
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void lockButton(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Enter Password", style: TextStyle(fontSize: 12)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '******',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20.h),
                GradientElevatedButton(
                  onPressed: () {
                    onTapToNextButton(passwordController.text, index);
                  },
                  text: 'Enter',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onTapToNextButton(String password, int index) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await accessJournalPasswordController.accessJournalPassword(password);

      if (isSuccess) {
        if (mounted) {
          setState(() {
            isBlurList[index] = false;
          });
          clearTextField();
          Navigator.pop(context);
          showSnackBarMessage(context, 'Access granted');
        }
      } else {
        if (mounted) {
          clearTextField();
          showSnackBarMessage(context, 'Invalid password', true);
        }
      }
    }
  }

  void clearTextField() {
    passwordController.clear();
  }
}
