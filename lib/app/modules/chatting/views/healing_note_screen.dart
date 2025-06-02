import 'package:antoinette/app/modules/chatting/views/text_therapy_screen.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antoinette/app/modules/chatting/controllers/all_friend_controller.dart';

class HealingNoteScreen extends StatefulWidget {
  static const String routeName = '/healing-note-screen';
  const HealingNoteScreen({super.key});

  @override
  State<HealingNoteScreen> createState() => _HealingNoteScreenState();
}

class _HealingNoteScreenState extends State<HealingNoteScreen> {
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController =
      Get.put(FriendController()); // Get the controller
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    super.initState();
    socketService.init();
    friendController.getAllFriends(); // Ensure data is loaded when screen is initialized
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
              heightBox24,
              Row(
                children: [
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
              heightBox10,
              SizedBox(
                height: 650.h,
                child: GetBuilder<FriendController>(
                  builder: (controller) {
                    if (controller.inProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.friendList.isEmpty) {
                      return const Center(child: Text('No Therapist Found'));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.friendList.length,
                      itemBuilder: (context, index) {
                        var friend = controller.friendList[index];
                        var chat = friend.chat;
                        var name = chat?.participants?[0].name ?? 'Unknown';
                        var photoUrl = chat?.participants?[0].photoUrl ?? '';
                        var messageText = friend.message?.text ?? 'No Message';
                        var chatId = chat?.id ?? '';
                        var receiverId = chat?.participants?[0].id ?? '';
                        var receiverName = chat?.participants?[0].name ?? 'Unknown';
                        var receiverImage = chat?.participants?[0].photoUrl ?? '';

                        if (searcCtrl.text.isEmpty || name.toLowerCase().contains(searcCtrl.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(TextTherapyScreen(
                                  chatId: chatId,
                                  receiverId: receiverId,
                                  receiverName: receiverName,
                                  receiverImage: receiverImage,
                                ));
                              },
                              child: Container(
                                height: 66.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(photoUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      widthBox8,
                                      Padding(
                                        padding: EdgeInsets.all(4.0.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            heightBox12,
                                            Text(
                                              messageText,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
