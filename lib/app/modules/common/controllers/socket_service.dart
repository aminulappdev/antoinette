import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:antoinette/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';

class SocketService extends GetxController {
  late IO.Socket _socket;

  RxBool isLoading = false.obs;
  final ProfileController profileController = Get.put(ProfileController());
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  // 🟢 RxList রাখা হয়েছে যাতে UI Obx দিয়ে observe করতে পারে
  final _messageList = <Map<String, dynamic>>[].obs;
  final _socketTherapistList = <Map<String, dynamic>>[].obs;

  // 🔁 Updated: এখন RxList return করবে, Obx রিঅ্যাক্ট করবে
  RxList<Map<String, dynamic>> get messageList => _messageList;
  RxList<Map<String, dynamic>> get socketTherapistList => _socketTherapistList;

  String? userIID;

  IO.Socket get sokect => _socket;

  Future<SocketService> init() async {
    profileController.getProfileData();
    final token = await box.read('user-login-access-token');
    print('user Id socket theke : ${StorageUtil.getData('user-id')}');
    final userId = StorageUtil.getData('user-id') ??
        'Id ekhono ase nay'; // এখানে আপনি চাইলে profile থেকে নিতে পারেন

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

    _socket.on('checking_notification', (data) {
      print('Check in data from socket');
      print(data);
    });

    _socket.on('checking_notification::${StorageUtil.getData('user-id')}',
        (data) {
      Get.snackbar('Success', 'Sms sent to all trusted contacts',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xffC37D60),
          colorText: Colors.white);
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
