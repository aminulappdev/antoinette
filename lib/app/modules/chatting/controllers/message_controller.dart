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
  
  
  // Fetch messages from server and update socket with the latest data
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

      
      print('message list ......................................');
      print(messageList);
      socketService.messageList.clear();
      
       for (var i = 0; i < messageList.length; i++) {
          socketService.messageList.add(
              {
                "id": messageList[i].id.toString(),
                "text": messageList[i].text.toString(),
                "imageUrl": messageList[i].imageUrl.toString(),
                "seen":  messageList[i].seen,
                "senderId": messageList[i].sender?.id.toString(),               
                "receiverId": messageList[i].receiver?.id.toString(),       
                "chat": messageList[i].chat.toString(),
              }
          );
          
        }
     
    } else {
      _errorMessage = response.errorMessage;
    }

    isLoading(false);
    update();

    
  }
}
