import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketService extends GetxService {
  late IO.Socket socket;
  bool isSocketInitialized = false;
  RxBool isLoading = false.obs;
  Map<String, dynamic>? lastMessageResponse;
  Future<void> initializeSocket() async {
    if (isSocketInitialized) return;


    socket = IO.io(Urls.socketUrl, 
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': box.read('user-login-access-token')})
          .build(),
    );
    socket.connect();
    socket.onConnect((_) async {
      print('Socket connected');

    });
    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
    isSocketInitialized = true;
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    socket.disconnect();
  }
}