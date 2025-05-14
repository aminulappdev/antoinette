import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/therapy/widgets/chatting_appbar.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:antoinette/app/modules/chatting/controllers/message_controller.dart';
import 'package:antoinette/app/modules/chatting/controllers/message_send_controller.dart';
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
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController messageController = TextEditingController();
  final MessageController messageFetchController = Get.put(MessageController());
  final MessageSendController messageSendController =
      Get.put(MessageSendController());
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSending = false;
  bool isTextEmpty = true;
  String updatesenderId = '';
  String updatereceiverId = '';
  late String senderId;
  int cnt = 1;

  @override
  void initState() {
    super.initState();
    senderId = profileController.profileModel!.data!.id!;
    print(senderId);

    socketService.init(); // Initialize the socket connection
    updatesenderId = '67dfad3574eb1ff506ea4f82';
    updatereceiverId = widget.receiverId;

    // Listen for incoming messages from the socket
    socketService.sokect.on('new-message::${widget.chatId}', (data) {
      cnt++;
      print('Soket data first time ...............');
      updatesenderId = data['sender'];
      updatereceiverId = data['receiver'];
      print('senderId :  ${data['sender']}');
      print('receiverId :  ${data['receiver']}');
      _handleIncomingMessage(data);
    });

    // Fetch the initial messages from the server (if any)
    messageFetchController.getMessages(chatId: widget.chatId).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    });

    // Add listener to track text field content
    messageController.addListener(() {
      setState(() {
        isTextEmpty = messageController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    messageController.dispose(); // Dispose the controller
    _scrollController.dispose();
    socketService.sokect.off(
        'new-message::${widget.chatId}'); // Remove socket listener
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
    _scrollToEnd(); // Scroll to the latest message
  }

  // Function to send message
  Future<void> sendMessage() async {
    setState(() {
      isLoading = true;
    });

    String messageText = messageController.text;

    if (messageText.isNotEmpty) {
      // Send message using the controller
      await messageSendController.sendMessage(
          widget.receiverId, messageText, "");

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
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust for keyboard
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          children: [
            heightBox24,
            CustomChatAppBar(name: widget.receiverName),
            Expanded(
              child: Obx(() {
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

                    var senderId = message['senderId'] ?? message['sender'];

                    print('Sender confusion ............................');
                    print(message['senderId']);
                    print(message['sender']);

                    return Align(
                      alignment: senderId == widget.receiverId
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: senderId == widget.receiverId
                                ? Colors.grey[200]
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(message['text'] ?? ''),
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
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Message cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    isSending
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.send,
                              color: isTextEmpty ? Colors.grey : Colors.blue,
                            ),
                            onPressed: isSending || isTextEmpty
                                ? null
                                : () {
                                    sendMessageBTN(
                                        widget.chatId,
                                        messageController.text,
                                        widget.receiverId);
                                  },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessageBTN(
      String chatId, String text, String receiverId) async {
    if (_formKey.currentState!.validate() && !isSending && text.trim().isNotEmpty) {
      setState(() {
        isSending = true; // Start loader
      });

      final bool isSuccess =
          await messageSendController.sendMessage(chatId, text, receiverId);

      if (isSuccess) {
        if (mounted) {
          messageController.clear();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToEnd(); // Scroll to the latest message after sending
          });
          // showSnackBarMessage(context, 'Message sent');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, messageSendController.errorMessage ?? 'Ekhanei problem', true);
        }
      }

      if (mounted) {
        setState(() {
          isSending = false; // Stop loader
        });
      }
    } else if (text.trim().isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty');
    }
  }
}