import 'package:antoinette/app/modules/chatting/views/text_therapy_screen.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antoinette/app/modules/chatting/controllers/all_friend_controller.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
 
class HealingNoteScreen extends StatefulWidget {
  static const String routeName = '/healing-note-screen';
  const HealingNoteScreen({super.key});

  @override
  State<HealingNoteScreen> createState() => _HealingNoteScreenState();
}

class _HealingNoteScreenState extends State<HealingNoteScreen> {
  
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController = Get.put(FriendController()); // Get the controller

  @override
  void initState() {
    super.initState();
    socketService.init();
    friendController.getAllFriends(); // Ensure data is loaded when screen is initialized
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
                heightBox24,
                CustomSearchBar(shouldBackButton: false),
                heightBox12,
                SizedBox(
                  height: 650.h,
                  child: GetBuilder<FriendController>(  // Fetch friends from controller
                    builder: (controller) {
                      if (controller.inProgress) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.friendList.isEmpty) {
                        return const Center(child: Text('No Friends Found'));
                      }

                      return ListView.builder(
                        itemCount: controller.friendList.length,
                        itemBuilder: (context, index) {
                          var friend = controller.friendList[index];
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                // Navigating to the message screen when a friend is clicked
                                Get.to(TextTherapyScreen(
                                  
                                  chatId: friend.chat!.id!,
                                  receiverId: friend.chat!.participants[0].id!,
                                  receiverName: friend.chat!.participants[0].name!,
                                  receiverImage: friend.chat!.participants[0].photoUrl!,
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
                                            image: NetworkImage(friend.chat?.participants[0].photoUrl ?? ''),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      widthBox8,
                                      Padding(
                                        padding: EdgeInsets.all(2.0.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              friend.chat?.participants[0].name ?? "Unknown",
                                              style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                            ),
                                            heightBox12,
                                            Text(
                                              'That sounds tough. Stress from work can',
                                              style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
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
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
