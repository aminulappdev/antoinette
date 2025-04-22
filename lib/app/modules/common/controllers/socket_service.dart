import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';

class SocketService extends GetxController {
  late IO.Socket _socket;

  RxBool isLoading = false.obs;
  final ProfileController profileController = Get.put(ProfileController());

  // 🟢 RxList রাখা হয়েছে যাতে UI Obx দিয়ে observe করতে পারে
  final _messageList = <Map<String, dynamic>>[].obs;
  final _socketTherapistList = <Map<String, dynamic>>[].obs;

  // 🔁 Updated: এখন RxList return করবে, Obx রিঅ্যাক্ট করবে
  RxList<Map<String, dynamic>> get messageList => _messageList;
  RxList<Map<String, dynamic>> get socketTherapistList => _socketTherapistList;

  IO.Socket get sokect => _socket;

  Future<SocketService> init() async {
    final token = await box.read('user-login-access-token');
    final userId = "67dfad3574eb1ff506ea4f82"; // এখানে আপনি চাইলে profile থেকে নিতে পারেন

    _socket = IO.io(Urls.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'token': token},
    });

    _socket.on('connect', (_) {
      print('✅ Connected to the server');
      _socket.emit("connection", userId);
    });

    _socket.onConnect((_) async {
      print('🟢 Socket connected');
      _socket.emit("connection", userId);
    });

    // 🎯 নতুন মেসেজ এলে add করে messageList-এ
    _socket.on('new-message', (data) {
      _handleIncomingMessage(data);
    });

    // 🎯 নতুন friend এলে add করে socketTherapistList-এ
    _socket.on('latest_friend', (data) {
      _handleIncomingFriends(data);
    });

    _socket.onDisconnect((_) {
      print('🔴 Socket disconnected');
    });

    return this;
  }

  void disconnect() {
    _socket.disconnect();
  }

  // 🛠 Incoming Message Handle
  void _handleIncomingMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final parsedMessage = {
        "id": data["id"]?.toString(),
        "text": data["text"] ?? "",
        "imageUrl": data["imageUrl"] ?? "",
        "seen": data["seen"] ?? false,
        "senderId": data["sender"]?.toString(),
        "receiverId": data["receiver"]?.toString(),
        "chat": data["chat"]?.toString(),
      };

      _messageList.add(parsedMessage);
      print('📩 Message added to list: ${_messageList.length}');
    }
  }

  // 🛠 Incoming Friend Handle
  void _handleIncomingFriends(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('receiver')) {
      _socketTherapistList.add(data);
      print('👥 Friend added to list: ${_socketTherapistList.length}');
    }
  }
}
