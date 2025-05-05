import 'package:antoinette/app/modules/session/model/all_session_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllSessionController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllSessionItemModel> sessionsList = [];
  List<AllSessionItemModel> get allProductList => sessionsList;

  final int _limit = 9999;
  int page = 0;

  
  int? lastPage; 

  Future<bool> getSessionList() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;
 
    _inProgress = true;

    update();

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allsessionUrl,
        queryParams: queryparam,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllSessionModel allSessionModel =
          AllSessionModel.fromJson(response.responseData);
      sessionsList.addAll(allSessionModel.data ?? []);

      if (allSessionModel.meta?.totalPage != null) {
        lastPage = allSessionModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}


// import 'package:antoinette/app/modules/session/model/all_session_model.dart';
// import 'package:antoinette/app/urls.dart';
// import 'package:antoinette/app/utils/get_storage.dart';
// import 'package:antoinette/services/network_caller/network_caller.dart';
// import 'package:antoinette/services/network_caller/network_response.dart';
// import 'package:get/get.dart';

// class AllSessionController extends GetxController {
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

  
//   var allProductsList = <AllSessionItemModel>[].obs;
//   RxList<AllSessionItemModel> sessionsList = <AllSessionItemModel>[].obs;  // Make it reactive

//   final int _limit = 5;
//   int page = 1;  // Default to 1, to start fetching from the first page

//   int? lastPage;

//   // Keep the getSessionList function
//   Future<bool> getSessionList() async {
//     if (_inProgress) {
//       return false;
//     }
//     page++;

//     if (lastPage != null && page > lastPage!) return false;

//     bool isSuccess = false;
 
//     _inProgress = true;

//     update();

//     Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//         Urls.allsessionUrl,
//         queryParams: queryparam,
//         accesToken: box.read('user-login-access-token'));

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;

//       AllSessionModel allSessionModel =
//           AllSessionModel.fromJson(response.responseData);
//       sessionsList.addAll(allSessionModel.data ?? []);

//       if (allSessionModel.meta?.totalPage != null) {
//         lastPage = allSessionModel.meta!.totalPage;
//       }
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }

//   // Same fetchAllSession function for reusability
//   Future<void> fetchAllSession(String? sessionQuery) async {
//     if (_inProgress) return;

//     _inProgress = true;
//     update();  // Update the UI with loading state

//     Map<String, dynamic> queryparam = {
//       'limit': _limit,
//       'page': page,
//       'searchTerm': sessionQuery ?? '',
//     };

//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//       Urls.allsessionUrl,
//       queryParams: queryparam,
//       accesToken: box.read('user-login-access-token')
//     );

//     if (response.isSuccess) {
//       AllSessionModel allSessionModel = AllSessionModel.fromJson(response.responseData);
//       sessionsList.addAll(allSessionModel.data ?? []);

//       if (allSessionModel.meta?.totalPage != null) {
//         lastPage = allSessionModel.meta!.totalPage;
//       }
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();  // Update the UI after fetching data
//   }

//   // Search handler to fetch sessions based on search query
//   void onSearchQueryChangedSession(String sessionQuery) {
//     page = 1;  // Reset to the first page for new search query
//     sessionsList.clear();  // Clear existing sessions before fetching new ones
//     fetchAllSession(sessionQuery);
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllSession(null);  // Fetch initial data when the controller is initialized
//   }
// }
