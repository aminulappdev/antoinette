import 'package:antoinette/app/modules/chatting/model/chat_message_model.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:get/get.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:antoinette/app/urls.dart'; 
import 'package:antoinette/app/utils/get_storage.dart';

class MessageController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final SocketService socketService = Get.put(SocketService());
  var isLoading = false.obs;

  var message = ChatMessageModel().obs;
  var messageList = <MessageData>[].obs;

  // 🔁 Server থেকে মেসেজ এনে socketService.messageList এ সেভ করে
  Future<void> getMessages({required String chatId}) async {
    _inProgress = true;
    isLoading(true);
    update();

    String token = await box.read('user-login-access-token');

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getMessagesUrl(chatId), accesToken: token);

    if (response.isSuccess) {
      messageList.clear();
      message.value = ChatMessageModel.fromJson(response.responseData);
      messageList.addAll(message.value.data!);

      print('📦 Messages loaded from API: ${messageList.length}');

      // 🔁 আগের মেসেজ clear করে নতুন মেসেজ socket messageList এ add করা হচ্ছে
      socketService.messageList.clear();

      for (final msg in messageList) {
        socketService.messageList.add({
          "id": msg.id.toString(),
          "text": msg.text ?? '',
          "imageUrl": msg.imageUrl,
          "seen": msg.seen,
          "senderId": msg.sender?.id?.toString(),
          "receiverId": msg.receiver?.id?.toString(),
          "chat": msg.chat.toString(),
        });
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    isLoading(false);
    update();
  }
}
