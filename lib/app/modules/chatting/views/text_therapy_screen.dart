import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
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
   String updatesenderId = '';
   String updatereceiverId = '';
  late String senderId;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                      print(
                          'sender id $updatesenderId');
                      print('reciver id $updatereceiverId');
                      var message = socketService.messageList[index];
                      print("this is: ${socketService.messageList[index]['sender'] } ::::: ${socketService.messageList[index]['sender'] ==
                                '67cd4f2f18d18dfa1fa1c60c'}");
                      return Align(
                       alignment: socketService.messageList[index]['sender'] ==
                                '67cd4f2f18d18dfa1fa1c60c'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: socketService.messageList[index]
                                          ['sender'] ==
                                      widget.receiverId
                                  ? Colors.grey[200]
                                  : Colors.blue,
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
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration:
                              InputDecoration(hintText: 'Type your message'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          sendMessageBTN(widget.chatId, messageController.text,
                              widget.receiverId);
                        }, // Use the sendMessage method here
                      ),
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

  Future<void> sendMessageBTN(
      String chatId, String text, String recieverId) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await messageSendController.sendMessage(chatId, text, recieverId);

      if (isSuccess) {
        if (mounted) {
          messageController.clear();
          // showSnackBarMessage(context, 'Message sent');
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, messageSendController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          // print('Error show ----------------------------------');
          showSnackBarMessage(context,
              messageSendController.errorMessage ?? 'Ekhanei problem', true);
        }
      }
    }
  }
}
