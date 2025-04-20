import 'package:antoinette/app/modules/chatting/controllers/message_send_controller.dart';
import 'package:antoinette/app/modules/therapy/widgets/chatting_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:antoinette/app/modules/chatting/controllers/message_controller.dart';


class TextTherapyScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';

  final String chatId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;

  const TextTherapyScreen({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<TextTherapyScreen> createState() => _TextTherapyScreenState();
}

class _TextTherapyScreenState extends State<TextTherapyScreen> {
  final TextEditingController messageController = TextEditingController();
  final MessageController messageFetchController = Get.put(MessageController());
  final MessageSendController messageSendController = Get.put(MessageSendController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch messages once the screen is loaded
    messageFetchController.getMessages(widget.chatId);
  }

  // Function to send message
  Future<void> sendMessage() async {
    setState(() {
      isLoading = true;
    });

    String messageText = messageController.text;

    if (messageText.isNotEmpty) {
      // Send message using the controller
      await messageSendController.sendMessage(widget.receiverId, messageText, "");

      // Clear message input field after sending
      messageController.clear();
      setState(() {
        isLoading = false;
      });

      Get.snackbar('Message Sent', 'Your message was successfully sent');
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error', 'Message cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              CustomChatAppBar(name: widget.receiverName),
              Expanded(
                child: GetBuilder<MessageController>(
                  builder: (controller) {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.messageList.isEmpty) {
                      return const Center(child: Text('No Messages Found'));
                    }

                    return ListView.builder(
                      itemCount: controller.messageList.length,
                      itemBuilder: (context, index) {
                        var message = controller.messageList[index];
                        return Align(
                          alignment: message['sender'] == widget.receiverId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: message['sender'] == widget.receiverId
                                    ? Colors.blue
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(message['text'] ?? ''),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_box_outlined),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(hintText: 'Type your message'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendMessage, // Use the sendMessage method here
                    ),
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
