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
  final AllDiariesController allDiariesController = Get.find<AllDiariesController>();
  final DeleteDiariesController deleteDiariesController = DeleteDiariesController();

  List<bool> isBlurList = [];

  @override
  void initState() {
    super.initState();
    _loadDiaries();
  }

  Future<void> _loadDiaries() async {
    await allDiariesController.getDiaryList(refresh: true);
    setState(() {
      isBlurList = List.generate(allDiariesController.allDiaryList.length, (_) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, AddDiaryScreen.routeName);
                    // Refresh list after returning from Add screen
                    await _loadDiaries();
                  },
                  child: Container(
                    height: 42.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 202, 200, 200)),
                      color: const Color(0xffEDE6E4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: AppColors.iconButtonThemeColor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SetJournalPasswordScreen.routeName);
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 24.r,
                    child: const Icon(Icons.lock),
                  ),
                ),
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
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [CustomPiChart(), MentalStatusWidget()],
                ),
              ),
            ),
            heightBox8,
            Expanded(
              child: GetBuilder<AllDiariesController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.allDiaryList.isEmpty) {
                  return const Center(child: Text("No diaries available"));
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.allDiaryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: HealthConditionCard(
                        titleColor: Colors.black,
                        isBlur: isBlurList.length > index ? isBlurList[index] : true,
                        iconPath: controller.allDiaryList[index].feelings == 'happy'
                            ? AssetsPath.angle
                            : controller.allDiaryList[index].feelings == 'calm'
                                ? AssetsPath.happy
                                : controller.allDiaryList[index].feelings == 'sad'
                                    ? AssetsPath.sad
                                    : controller.allDiaryList[index].feelings == 'anxious'
                                        ? AssetsPath.tired
                                        : controller.allDiaryList[index].feelings == 'motivated'
                                            ? AssetsPath.muscle
                                            : AssetsPath.angry,
                        status: '${controller.allDiaryList[index].feelings}',
                        day: '${controller.allDiaryList[index].date}',
                        time: '${controller.allDiaryList[index].time}',
                        description: '${controller.allDiaryList[index].description}',
                        lockOntap: () {
                          if (!isBlurList[index]) {
                            setState(() {
                              isBlurList[index] = true;
                            });
                          } else {
                            lockButton(index, 'view');
                          }
                        },
                        themeColor: const Color(0xffD9A48E).withAlpha(20),
                        onDeleteTap: () {
                          lockButton(index, 'delete', diaryId: controller.allDiaryList[index].sId);
                        },
                        onEditTap: () {
                          lockButton(index, 'edit', diaryId: controller.allDiaryList[index].sId);
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
    );
  }

  void lockButton(int index, String action, {String? diaryId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    if (value == null || value.isEmpty) {
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
                    onTapToNextButton(passwordController.text, index, action, diaryId: diaryId);
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

  Future<void> deleteDiary(String diaryId) async {
    final bool isSuccess = await deleteDiariesController.deleteDiaries(diaryId);

    if (isSuccess) {
      if (mounted) {
        // Refresh the diary list and update blur list
        await allDiariesController.getDiaryList(refresh: true);
        setState(() {
          isBlurList = List.generate(allDiariesController.allDiaryList.length, (_) => true);
        });
        showSnackBarMessage(context, 'Successfully deleted!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          deleteDiariesController.errorMessage ?? 'Something went wrong',
          true,
        );
      }
    }
  }

  Future<void> onTapToNextButton(String password, int index, String action, {String? diaryId}) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await accessJournalPasswordController.accessJournalPassword(password);

      if (isSuccess) {
        clearTextField();
        Navigator.pop(context); // Close dialog first
        if (mounted) {
          if (action == 'view') {
            setState(() {
              isBlurList[index] = false;
            });
            showSnackBarMessage(context, 'Access granted');
          } else if (action == 'edit' && diaryId != null) {
            await Navigator.pushNamed(context, EditDiaryScreen.routeName, arguments: diaryId);
            // Refresh diary list & blur states after editing
            await _loadDiaries();
            showSnackBarMessage(context, 'Access granted for edit');
          } else if (action == 'delete' && diaryId != null) {
            await deleteDiary(diaryId);
          }
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
