import 'package:antoinette/app/modules/chatting/model/all_friends_model.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final SocketService socketService = Get.put(SocketService());

  // progress states and messages
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // friend related data
  var friends = AllFriendsModel(success: false, statusCode: 0, message: "", data: []).obs;
  var friendList = <AllFriendsItemModel>[].obs;

  // initialize friends on controller startup
  @override
  void onInit() {
    super.onInit();
    getAllFriends();
  }

  @override
  void onReady() {
    super.onReady();
    getAllFriends();
  }

  Future<bool> getAllFriends() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allFriendsChatnUrl,
        accesToken: box.read('user-login-access-token'));

    print('response data is : ${response.responseData}');

    if (response.isSuccess) {
      friendList.clear();
      friends.value = AllFriendsModel.fromJson(response.responseData);
      friendList.addAll(friends.value.data);

      socketService.socketTherapistList.clear(); // Clear the socket's friend list

      if (friendList.isNotEmpty) {
        for (var i = 0; i < friendList.length; i++) {
          var chat = friendList[i].chat;
          if (chat != null && chat.participants != null && chat.participants!.isNotEmpty) {
            socketService.socketTherapistList.add({
              "id": chat.id ?? 'No ID',
              "name": chat.participants![0].name ?? 'No Name',
              "email": chat.participants![0].email ?? 'No Email',
              "phoneNumber": chat.participants![0].contactNumber ?? 'No Phone Number',
              "image": chat.participants![0].photoUrl ?? 'No Image',
              "lastMessage": friendList[i].message?.text ?? 'No Message',
            });
          } else {
            print("Participants list is empty or chat is null for friend $i");
          }
        }
      }

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
