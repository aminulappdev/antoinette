import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Reception extends StatefulWidget {
  const Reception({super.key});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {

  String? selectedTime;

  final List<String> timeSlots = [
    "10:40 AM - 11:00 AM",
    "11:00 AM - 11:20 AM",
    "11:20 AM - 11:40 AM",
    "11:40 AM - 12:00 PM",
  ];

  String selectedTherapy = "Video Therapy";

  final List<String> therapyOptions = [
    "Video Therapy",
    "In-Person Therapy",
    "Text Therapy",
  ];

  @override
  Widget build(BuildContext context) {
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
                    color: Color(0xFFF6ECE4), // Soft beige background
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTherapy,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                      items: therapyOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: GoogleFonts.poppins(fontSize: 12.sp),
                          ),
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
          Text(
            "Select Date:",
            style: GoogleFonts.poppins(fontSize: 15.sp),
          ),
          heightBox8,
          SfDateRangePicker(
            backgroundColor: Colors.white,
            selectionMode: DateRangePickerSelectionMode.range,
          ),
          heightBox8,
          Text(
            "Select Date & Time:",
            style: GoogleFonts.poppins(fontSize: 15.sp),
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: timeSlots.map((time) {
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: 0,horizontal: 0),
              child: Row(
                children: [
                  Radio<String>(
                    value: time,
                    groupValue: selectedTime,
                    onChanged: (String? value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Text(
                    time,
                    style: GoogleFonts.poppins(fontSize: 12.sp)
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      
        ],
      ),
    );
  }
}
