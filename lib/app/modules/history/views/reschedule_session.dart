import 'package:antoinette/app/modules/session/controllers/booking_controller.dart';
import 'package:antoinette/app/modules/session/controllers/get_session_slotById_controller.dart';
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class RescheduleSessionScreen extends StatefulWidget {
  
   static const String routeName = '/reschedule-session-screen';
  // final SessionDataModel sessionDataModel;
  final Map<String,dynamic> data;
  const RescheduleSessionScreen({super.key, required this.data});

  @override
  State<RescheduleSessionScreen> createState() => _RescheduleSessionScreenState();
}

class _RescheduleSessionScreenState extends State<RescheduleSessionScreen> {
  final SessionDetailsController sessionDetailsController =
      Get.find<SessionDetailsController>();

  
  late String userId;

  Map<String, dynamic> slotData = {
    'sessionId': '',
    'slotId': '',
    'therapyType': '',
    'therapyId' : ''

  };

  final BookingController bookingController = BookingController();

  

  List<DateTime> enabledDates = [];
  List<DateTime> disabledDates = []; // For holding booked dates
  String? selectedTimeSlot;
  String? selectedSlotId;
  DateTime selectedDate = DateTime.now();
  String? slotId;

  @override
  void initState() {

    print('reception er sessionId ${widget.data['sessionId']}');
    sessionDetailsController.getSessionDetails(widget.data['sessionId']);
    super.initState();

    // Fetch session slots by ID
    Get.find<AllSessionSlotByIdController>()
        .getSessionById(widget.data['sessionId'])
        .then((_) {
      var controller = Get.find<AllSessionSlotByIdController>();

      List<DateTime> validDates = [];
      List<DateTime> bookedDates = []; // To track booked dates

      // Iterate over session slots and segregate booked and available dates
      controller.sessionListById?.forEach((sessionSlot) {
        DateTime date = DateTime.parse(sessionSlot.date!);

        if (sessionSlot.isBooked == true) {
          // If the slot is booked, add to disabledDates
          bookedDates.add(date);
        } else {
          validDates.add(date);
        }
      });

      setState(() {
        enabledDates = validDates; // Valid dates
        disabledDates = bookedDates; // Booked dates
      });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSessionSlotByIdController>(builder: (controller) {
      if (controller.inProgress) {
        return Center(child: CircularProgressIndicator());
      }

      Map<String, String> availableSlotMap =
          controller.getSlotMapForSelectedDate(selectedDate);

      return Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              heightBox8,
         
              heightBox8,
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: selectedDate,
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    controller.updateSelectedDate(selectedDay);
                    selectedTimeSlot = null;
                    selectedSlotId = null;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  disabledDecoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                enabledDayPredicate: (day) {
                  // Check if the day is either available or not booked
                  return enabledDates.any((date) =>
                          date.year == day.year &&
                          date.month == day.month &&
                          date.day == day.day) &&
                      !disabledDates.contains(day);
                },
              ),
              heightBox8,
              Text("Select Date & Time:",
                  style: GoogleFonts.poppins(fontSize: 15.sp)),
              heightBox8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: availableSlotMap.entries.map((entry) {
                  String timeSlot = entry.key;
                  String slotId = entry.value;
          
                  // Check if slot is booked
                  if (controller.bookedSlots.contains(slotId)) {
                    return SizedBox.shrink(); // Skip booked slots
                  }
          
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: slotId,
                          groupValue: selectedSlotId,
                          onChanged: (String? value) {
                            setState(() {
                              selectedSlotId = value;
                              selectedTimeSlot = timeSlot;
                              slotId = selectedSlotId!;
                              print('Selected slot ID: $selectedSlotId');
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        Text(timeSlot,
                            style: GoogleFonts.poppins(fontSize: 12.sp)),
                      ],
                    ),
                  );
                }).toList(),
              ),
              heightBox8,
              GetBuilder<SessionDetailsController>(builder: (controller) {
                return GradientElevatedButton(
                    onPressed: () {
                      print('Add chat er data ..............');             
                      print(controller.sessionDetailsModel?.data!.therapist?.sId);                  
                      print('Datails page er slot id : ${widget.data['sessionId']}');
                      slotData['sessionId'] = widget.data['sessionId'];
                      slotData['slotId'] = selectedSlotId!;          
                      slotData['therapyId'] = controller.sessionDetailsModel?.data!.therapist?.sId;
                      slotData['bookingId'] = widget.data['bookingId'];
          
                      
                      Navigator.pushNamed(context, SessionFormScreen.routeName,
                          arguments: slotData);
                    },
                    text: 'Book now');
              })
            ],
          ),
        ),
      );
    });
  }

  
}
