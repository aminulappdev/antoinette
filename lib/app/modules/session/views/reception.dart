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

class Reception extends StatefulWidget {
  final String sessionId;
  const Reception({super.key, required this.sessionId});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  final SessionDetailsController sessionDetailsController =
      Get.find<SessionDetailsController>();

  late String userId;

  Map<String, dynamic> slotData = {
    'sessionId': '',
    'slotId': '',
    'therapyType': '',
    'therapyId': ''
  };

  final BookingController bookingController = BookingController();

  String selectedTherapy = "Video Therapy"; // Default selected therapy
  final List<String> therapyOptions = [
    "Video Therapy",
    "Text Therapy",
  ];

  List<DateTime> enabledDates = [];
  List<DateTime> disabledDates = []; // For holding booked dates
  String? selectedTimeSlot;
  String? selectedSlotId;
  DateTime selectedDate = DateTime.now();
  String? slotId;

  @override
  void initState() {
    super.initState();

    print('Reception - sessionId: ${widget.sessionId}');
    sessionDetailsController.getSessionDetails(widget.sessionId);

    // Fetch session slots by ID
    Get.find<AllSessionSlotByIdController>()
        .getSessionById(widget.sessionId)
        .then((_) {
      var controller = Get.find<AllSessionSlotByIdController>();

      List<DateTime> validDates = [];
      List<DateTime> bookedDates = [];

      controller.sessionListById?.forEach((sessionSlot) {
        DateTime date = DateTime.parse(sessionSlot.date!);
        if (sessionSlot.isBooked == true) {
          bookedDates.add(date);
        } else {
          validDates.add(date);
        }
      });

      setState(() {
        enabledDates = validDates;
        disabledDates = bookedDates;
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

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Choose Therapy Type:",
                    style: GoogleFonts.poppins(fontSize: 15.sp)),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6ECE4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTherapy,
                        isExpanded: true,
                        icon:
                            Icon(Icons.arrow_drop_down, color: Colors.black54),
                        items: therapyOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option,
                                style: GoogleFonts.poppins(fontSize: 12.sp)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTherapy = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            heightBox8,
            Text("Select Date:", style: GoogleFonts.poppins(fontSize: 15.sp)),
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

                if (controller.bookedSlots.contains(slotId)) {
                  return SizedBox.shrink();
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
                            this.slotId = selectedSlotId!;
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
              void handleBooking() {
                if (selectedSlotId == null) return; // কিছু না করো
                print('Add chat er data ..............');
                print(controller.sessionDetailsModel?.data!.therapist?.sId);

                print('Details page er session id : ${widget.sessionId}');
                print('Details page er slot id : ${selectedSlotId!}');
                slotData['sessionId'] = widget.sessionId;
                slotData['slotId'] = selectedSlotId!;
                slotData['therapyType'] = selectedTherapy;
                slotData['therapyId'] =
                    controller.sessionDetailsModel?.data!.therapist?.sId;

                Navigator.pushNamed(context, SessionFormScreen.routeName,
                    arguments: slotData);
              }

              return Opacity(
                opacity: selectedSlotId == null ? 0.5 : 1.0,
                child: IgnorePointer(
                  ignoring: selectedSlotId == null, // যেন ট্যাপ কাজ না করে
                  child: GradientElevatedButton(
                    onPressed: handleBooking, // এখন এটা কখনো null হবে না
                    text: 'Book now',
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }
}
