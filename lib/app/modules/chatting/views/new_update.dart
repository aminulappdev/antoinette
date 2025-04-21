
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:antoinette/app/modules/chatting/controllers/message_controller.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController messageController = TextEditingController();
  final MessageController messageFetchController = Get.put(MessageController());
  // final MessageSendController messageSendController =
  //     Get.put(MessageSendController());
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    socketService.init(); // Initialize the socket connection

    // Listen for incoming messages from the socket
    socketService.sokect.on('new-message::${widget.chatId}', (data) {
      _handleIncomingMessage(data);
    });

    // Fetch the initial messages from the server (if any)
    messageFetchController.getMessages(chatId: widget.chatId).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    socketService.sokect.off(
        'new-message::${widget.chatId}'); // Remove socket listener when the screen is disposed
    super.dispose();
  }

  void _scrollToEnd() {
  Future.delayed(const Duration(milliseconds: 100), () {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  });
}


  // Handle incoming messages from the socket
  void _handleIncomingMessage(dynamic data) {
    socketService.messageList.add(data); // Add the new message to the list
    print(socketService.messageList.length.toString() +
        " this is message list demo length");
    _scrollToEnd(); // Scroll to the latest message
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  // The list of messages will be automatically updated when the message list is updated
                  if (messageFetchController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (messageFetchController.messageList.isEmpty) {
                    return const Center(child: Text('No Messages Found'));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: socketService.messageList.length,
                    itemBuilder: (context, index) {
                      var message = socketService.messageList[index];
                      return Align(
                        alignment: socketService.messageList[index]
                                    ['senderId'] ==
                                "67dfad3574eb1ff506ea4f82"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: socketService.messageList[index]
                                          ['senderId'] ==
                                      widget.receiverId
                                  ? Colors.blue
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                                socketService.messageList[index]['text'] ?? ''),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      TextFormField(
                        // validator: (String? value) {
                        //   if (value!.isEmpty) {
                        //     return 'Type something';
                        //   }
                        //   return null;
                        // },
                        controller: messageController,
                        decoration:
                            InputDecoration(hintText: 'Type your message'),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            // sendMessageBTN(widget.chatId, widget.receiverId,
                            //     messageController.text);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> sendMessageBTN(String chatId, String recieverId, text) async {
  //   if (_formKey.currentState!.validate()) {
  //     final bool isSuccess =
  //         await messageSendController.sendMessage(chatId, recieverId, text);

  //     if (isSuccess) {
  //       if (mounted) {
  //         showSnackBarMessage(context, 'Message sent');
  //       } else {
  //         if (mounted) {
  //           showSnackBarMessage(
  //               context, messageSendController.errorMessage!, true);
  //         }
  //       }
  //     } else {
  //       if (mounted) {
  //         // print('Error show ----------------------------------');
  //         showSnackBarMessage(context,
  //             messageSendController.errorMessage ?? 'Ekhanei problem', true);
  //       }
  //     }
  //   }
  // }
}
