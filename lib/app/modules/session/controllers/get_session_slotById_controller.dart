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

  // To store booked slots
  List<String> bookedSlots = [];

  // Date update
  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    update(); // UI update
  }

  // slot mapping by date: {"4:00 PM - 5:30 PM": "slot_id"}
  Map<String, String> getSlotMapForSelectedDate(DateTime dateTime) {
    if (_selectedDate == null) return {};

    Map<String, String> slotMap = {};
    sessionListById?.forEach((sessionSlot) {
      DateTime date = DateTime.parse(sessionSlot.date!);
      if (date.isSameDate(_selectedDate!) && sessionSlot.isBooked == false) {
        String slot = "${sessionSlot.startTime} - ${sessionSlot.endTime}";
        slotMap[slot] = sessionSlot.sId!;
      } else if (sessionSlot.isBooked == true) {
        // Track booked slots
        bookedSlots.add(sessionSlot.sId!);
      }
    });
    return slotMap;
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

// Extension to compare only date part
extension DateComparison on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }
}
