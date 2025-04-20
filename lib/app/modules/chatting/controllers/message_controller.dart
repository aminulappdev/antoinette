import 'package:antoinette/app/modules/chatting/model/chat_message_model.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:get/get.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';

class MessageController extends GetxController {

  final SocketService socketService = Get.put(SocketService());
  var isLoading = false.obs;
  var messageList = <Map<String, dynamic>>[].obs;
  var message = ChatMessageModel().obs;
  
  // Fetch messages from server and update socket with the latest data
  Future<void> getMessages(String chatId) async {
    isLoading(true);
    update();

    String token = await box.read('user-login-access-token');

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getMessagesUrl(chatId), accesToken: token);

    if (response.isSuccess) {
      var responseBody = response.responseData;
      if (responseBody is Map && responseBody.containsKey('data')) {
        var dataList = responseBody['data'];
        messageList.value = List<Map<String, dynamic>>.from(
          dataList.map((item) => item as Map<String, dynamic>)
        );
      } else {
        print('Invalid data format');
      }
    } else {
      print('Error fetching messages');
    }

    isLoading(false);
    update();
  }
}
