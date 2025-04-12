import 'package:antoinette/app/modules/session/controllers/booking_controller.dart';
import 'package:antoinette/app/modules/session/controllers/get_session_slotById_controller.dart';
import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Reception extends StatefulWidget {
  final SessionDataModel sessionDataModel;
  const Reception({super.key, required this.sessionDataModel});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {

   Map<String,dynamic> slotData = {
    'sessionId' : '',
    'slotId' : '',
    'therapyType': ''
  };

  final BookingController bookingController = BookingController();


  String selectedTherapy = "Video Therapy";
  final List<String> therapyOptions = [
    "Video Therapy",
    "Text Therapy",
  ];

  List<DateTime> enabledDates = [];
  String? selectedTimeSlot;
  String? selectedSlotId;
  DateTime selectedDate = DateTime.now();
  String? slotId;

  @override
  void initState() {
    super.initState();
    
    Get.find<AllSessionSlotByIdController>()
        .getSessionById(widget.sessionDataModel.sId!)
        .then((_) {
      var controller = Get.find<AllSessionSlotByIdController>();

      List<DateTime> validDates = [];
      controller.sessionListById?.forEach((sessionSlot) {
        DateTime date = DateTime.parse(sessionSlot.date!);
        validDates.add(date);
      });

      setState(() {
        enabledDates = validDates;
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
                    date.day == day.day);
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
            GradientElevatedButton(
                onPressed: (){
                  slotData['sessionId'] = widget.sessionDataModel.sId!;
                  slotData['slotId'] = selectedSlotId!;
                  slotData['therapyType'] = selectedTherapy;
                  Navigator.pushNamed(context, SessionFormScreen.routeName, arguments: slotData);
                }, text: 'Book now')
          ],
        ),
      );
    });
  }

  
}
