import 'package:antoinette/app/modules/chatting/model/all_friends_model.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

class FriendController extends GetxController {
  final SocketService socketService = Get.put(SocketService()); // Ensure SocketService is initialized

  // progress states and messages
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // friend related data
  var friends = AllFriendsModel(success: false, statusCode: 0, message: "", data: []).obs;
  var friendList = <AllFriendsItemModel>[].obs;

  // page related data
  int page = 0;
  int? lastPage;

  // initialize friends on controller startup
  @override
  void onInit() {
    super.onInit();
    getAllFriends(); // Fetch friends when the controller is initialized
  }

  // reload friends on ready
  @override
  void onReady() {
    super.onReady();
    getAllFriends(); // Fetch friends when the controller is ready
  }

  /// Get all Friends from server and update the socket
  Future<bool> getAllFriends() async {
    bool isSuccess = false;
    _inProgress = true;
    update(); // Trigger UI update when the loading starts

    String token = await box.read('user-login-access-token');

    try {
      var headers = {'Accept': 'application/json', 'Authorization': token};
      var url = Uri.parse(Urls.allFriendsChatnUrl);
      var response = await http.get(url, headers: headers);
      print('Response is ..................');
      print(response);
      

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        friendList.clear();
        friends.value = AllFriendsModel.fromJson(responseBody);
        friendList.addAll(friends.value.data);

        socketService.friendList.clear(); // Clear the socket's friend list

        if (friendList.isNotEmpty) {
          for (var i = 0; i < friendList.length; i++) {
            if (friendList[i].participants.isNotEmpty) {
              // Add the friend data to socketService's friendList
              socketService.friendList.add({
                "id": friendList[i].id,
                "name": friendList[i].participants[0].name,
                "email": friendList[i].participants[0].email,
                "phoneNumber": friendList[i].participants[0].contactNumber,
                "image": friendList[i].participants[0].photoUrl,
              });
            } else {
              print("Participants list is empty for friend $i");
            }
          }
        }

        isSuccess = true;
      } else {
        _errorMessage = 'Unable to load all friends data!';
        isSuccess = false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      print(e);
    }

    _inProgress = false;
    update(); // Trigger UI update when loading finishes

    return isSuccess;
  }
}
