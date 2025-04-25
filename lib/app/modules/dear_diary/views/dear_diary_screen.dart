import 'package:antoinette/app/modules/dear_diary/controllers/access_journal_key_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/all_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/delete_diary_controller.dart';
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
  final DeleteDiariesController deleteDiariesController =
      DeleteDiariesController();

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,
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
                    children: [CustomPiChart(), MentalStatusWidget()],
                  ),
                ),
              ),
              heightBox8,
              SizedBox(
                height: 440,
                child: GetBuilder<AllDiariesController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Check if the diary list is empty
                  if (controller.allDiaryList.isEmpty) {
                    return const Center(child: Text("No diaries available"));
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.allDiaryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: HealthConditionCard(
                          // titleColor: controller
                          //             .allDiaryList[index].feelings ==
                          //         'happy'
                          //     ? Color(0xff82FF34)
                          //     : controller.allDiaryList[index].feelings ==
                          //             'calm'
                          //         ? Colors.greenAccent
                          //         : controller.allDiaryList[index].feelings ==
                          //                 'sad'
                          //             ? Colors.blueAccent
                          //             : controller.allDiaryList[index]
                          //                         .feelings ==
                          //                     'anxious'
                          //                 ? Colors.pinkAccent
                          //                 : controller.allDiaryList[index]
                          //                             .feelings ==
                          //                         'motivated'
                          //                     ? Colors.orangeAccent
                          //                     : Colors.redAccent,
                          titleColor: Colors.black,
                          isBlur: isBlurList[index],
                          iconPath: controller.allDiaryList[index].feelings ==
                                  'happy'
                              ? AssetsPath.happy
                              : controller.allDiaryList[index].feelings ==
                                      'calm'
                                  ? AssetsPath.sad
                                  : controller.allDiaryList[index].feelings ==
                                          'sad'
                                      ? AssetsPath.sad
                                      : controller.allDiaryList[index]
                                                  .feelings ==
                                              'anxious'
                                          ? AssetsPath.tired
                                          : controller.allDiaryList[index]
                                                      .feelings ==
                                                  'motivated'
                                              ? AssetsPath.muscle
                                              : AssetsPath.angle,
                          status: '${controller.allDiaryList[index].feelings}',
                          day: '${controller.allDiaryList[index].date}',
                          time: '${controller.allDiaryList[index].time}',
                          description:
                              '${controller.allDiaryList[index].description}',
                          lockOntap: () {
                            if (!isBlurList[index]) {
                              setState(() {
                                isBlurList[index] = true;
                              });
                            } else {
                              lockButton(index);
                            }
                          },
                          themeColor: const Color(0xffD9A48E).withAlpha(20),
                          onDeleteTap: () {
                            // print('${controller.allDiaryList[index].sId}');
                            setState(() {
                              deleteDiary(
                                  '${controller.allDiaryList[index].sId}');
                            });
                          },
                          onEditTap: () {
                            Navigator.pushNamed(
                                context, EditDiaryScreen.routeName,
                                arguments:
                                    '${controller.allDiaryList[index].sId}');
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

  Future<void> deleteDiary(String userId) async {
    final bool isSuccess = await deleteDiariesController.deleteDiaries(userId);

    if (isSuccess) {
      if (mounted) {
        allDiariesController.getDiaryList();
        allDiariesController.update();
        showSnackBarMessage(
          context,
          'Successfully deleted!',
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            deleteDiariesController.errorMessage ?? 'Something went wrong',
            true);
      }
    }
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
