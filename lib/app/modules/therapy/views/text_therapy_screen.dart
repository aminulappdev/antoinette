import 'package:antoinette/app/modules/therapy/views/camera_screen.dart';
import 'package:antoinette/app/modules/therapy/widgets/chatting_appbar.dart';
import 'package:antoinette/app/modules/therapy/widgets/chatting_field.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTherapyScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';

  const TextTherapyScreen({
    super.key,
  });

  @override
  State<TextTherapyScreen> createState() => _TextTherapyScreenState();
}

class _TextTherapyScreenState extends State<TextTherapyScreen> {
  List<CameraDescription>? cameras; // Nullable to handle initialization
  final List<Map<String, dynamic>> messageList = [
    {
      "text": "I have some loads, can you transfer them to Dhaka safely?",
      "isSent": true
    },
    {"text": "Oh it’s okay.", "isSent": false},
    {"text": "Next time, we will meet again", "isSent": true},
    {"text": "Oh it’s okay i like it too babe", "isSent": false},
    {"text": "Okay see you soon very soon", "isSent": true},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the camera list
    _initializeCamera();
  }

  // Method to initialize cameras
  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomChatAppBar(name: 'Dr. Jane Smith'),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.r),
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final message = messageList[index];
                    return Align(
                      alignment: message['isSent']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: message['isSent']
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            '11:30 AM',
                            style: TextStyle(fontSize: 10),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                  topLeft: Radius.circular(16.r)),
                            ),
                            child: Text(
                              message['text'],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: message['isSent']
                                      ? Color(0xffD9A48E)
                                      : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 70.h,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(Icons.add),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: ChattingFieldWidget(hintText: '  Let it out')),
                    widthBox8,
                    GestureDetector(
                      onTap: () {
                        if (cameras != null && cameras!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CameraScreen(cameras: cameras!),
                            ),
                          );
                        } else {
                          print('No cameras available');
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: AppColors.iconButtonThemeColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
