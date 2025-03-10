import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCheckInScreen extends StatefulWidget {
  static const String routeName = '/add-check-screen';
  const AddCheckInScreen({super.key});

  @override
  State<AddCheckInScreen> createState() => _AddCheckInScreenState();
}

class _AddCheckInScreenState extends State<AddCheckInScreen> {
  int hours = 0, minutes = 15, seconds = 0;

  // void _showCustomPicker(BuildContext context) {
  //   Picker(
  //     adapter: NumberPickerAdapter(data: [
  //       NumberPickerColumn(begin: 0, end: 23, suffix: Text(" hours")),
  //       NumberPickerColumn(begin: 0, end: 59, suffix: Text(" min")),
  //       NumberPickerColumn(begin: 0, end: 59, suffix: Text(" sec")),
  //     ]),
  //     selecteds: [hours, minutes, seconds],
  //     title: Text("Select Time"),
  //     onConfirm: (Picker picker, List<int> values) {
  //       setState(() {
  //         hours = values[0];
  //         minutes = values[1];
  //         seconds = values[2];
  //       });
  //     },
  //   ).showModal(context);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(name: 'Add Check-In'),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22,
                  ),
                  widthBox4,
                  Text(
                    'Set Check-In Timer',
                    style: GoogleFonts.poppins(fontSize: 15),
                  )
                ],
              ),

// Text(
//               "$hours hours  $minutes min  $seconds sec",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showCustomPicker(context),
//               child: Text("Select Time"),
//             ),

              SizedBox(
                height: 500,
              ),
              GradientElevatedButton(onPressed: () {}, text: 'Check-In')
            ],
          ),
        ),
      ),
    );
  }
}
