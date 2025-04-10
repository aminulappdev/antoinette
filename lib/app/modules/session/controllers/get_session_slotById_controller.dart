// import 'package:antoinette/app/modules/session/model/session_slot_by_id_model.dart';
// import 'package:antoinette/app/urls.dart';
// import 'package:antoinette/app/utils/get_storage.dart';
// import 'package:antoinette/services/network_caller/network_caller.dart';
// import 'package:antoinette/services/network_caller/network_response.dart';
// import 'package:get/get.dart';

// class AllSessionSlotByIdController extends GetxController {
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

 

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   String? _accessToken;
//   String? get accessToken => _accessToken;



//   SessionSlotByIdModel? _sessionSlotByIdModel;
//   List<SessionSlotItemModel>? get sessionListById => _sessionSlotByIdModel?.data;

//   Future<bool> getSessionById(String id) async {
  
//     bool isSuccess = false;

//     _inProgress = true;

//     update();

   
//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//         Urls.sessionSlotById(id),
//         accesToken: box.read('user-login-access-token'));

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;  
      
//       _sessionSlotByIdModel = SessionSlotByIdModel.fromJson(response.responseData);
//      print(sessionListById?[0].sId);
      
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }
// }

import 'package:antoinette/app/modules/session/model/session_slot_by_id_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllSessionSlotByIdController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  SessionSlotByIdModel? _sessionSlotByIdModel;
  List<SessionSlotItemModel>? get sessionListById => _sessionSlotByIdModel?.data;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  // Update the selected date
  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    update(); // Update the UI
  }

  // Get the available time slots for the selected date
  List<String> getTimeSlotsForSelectedDate(DateTime dateTime) {
    if (_selectedDate == null) return [];

    List<String> timeSlots = [];
    sessionListById?.forEach((sessionSlot) {
      DateTime date = DateTime.parse(sessionSlot.date!);
      if (date.isSameDate(_selectedDate!)) {
        timeSlots.add("${sessionSlot.startTime} - ${sessionSlot.endTime}");
      }
    });
    return timeSlots;
  }

  Future<bool> getSessionById(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.sessionSlotById(id),
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _sessionSlotByIdModel = SessionSlotByIdModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}

// Extension method to compare only the date part of DateTime
extension DateComparison on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}
