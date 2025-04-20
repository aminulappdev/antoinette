import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';

class SocketService extends GetxService {
  late IO.Socket _socket;
  bool isSocketInitialized = false;
  RxBool isLoading = false.obs;
  Map<String, dynamic>? lastMessageResponse;

  // Use RxList to update the message and friend lists
  final RxList<Map<String, dynamic>> _messageList =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _friendList = <Map<String, dynamic>>[].obs;

  final ProfileController profileController = Get.put(ProfileController());

  List<Map<String, dynamic>> get messageList => _messageList;
  List<Map<String, dynamic>> get friendList => _friendList;

  IO.Socket get sokect => _socket;

  Future<void> initializeSocket() async {
    if (isSocketInitialized) return;

    final token = box.read('user-login-access-token');
    final userId = profileController.profileData?.id;

    // _socket = IO.io(
    //   Urls.socketUrl,
    //   IO.OptionBuilder()
    //       .setTransports(['websocket'])
    //       .disableAutoConnect()
    //       .setAuth({'token': token})
    //       .build(),
    // );

    _socket = IO.io(Urls.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true, // Auto connect to the server
      'extraHeaders': {'token': token},
    });

  
     _socket.on('connect', (data) {
      print('Connected to the server');
      _socket.emit("connection",userId);
    });


    _socket.onConnect((_) async {
      print('Socket connected');
      if (userId != null) {
        _socket.emit("connection", userId);
        print('User ID sent to server: $userId');
      }
    });

    _socket.on('new-message', (data) {
      _handleIncomingMessage(data);
    });

    _socket.on('latest_friend', (data) {
      _handleIncomingFriends(data);
    });

    _socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    isSocketInitialized = true;
  }

  // Handle incoming messages from the server and update the message list
  void _handleIncomingMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      _messageList.add(data); // Add the new message to the message list
      print('New message received and added to list: ${_messageList.length}');
    }
  }

  // Handle incoming friend data from the server and update the friend list
  void _handleIncomingFriends(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('receiver')) {
      _friendList.add(data);
      print('Friend received and added to list: ${_friendList.length}');
    }
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    _socket.disconnect();
  }
}
