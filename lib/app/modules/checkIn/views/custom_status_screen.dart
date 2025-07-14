import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStatusScreen extends StatefulWidget {
  static const String routeName = '/custom-status-screen';
  const CustomStatusScreen({super.key});

  @override
  State<CustomStatusScreen> createState() => _CustomStatusScreenState();
}

class _CustomStatusScreenState extends State<CustomStatusScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController statusCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              heightBox24,
              CustomAppBar(name: 'Custom status'),
              heightBox12,
              Row(
                children: [
                  Icon(Icons.add, size: 18.h),
                  widthBox8,
                  Text('Add Custom Status',
                      style: GoogleFonts.poppins(fontSize: 14.sp)),
                ],
              ),
              heightBox12,
              TextFormField(
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter status';
                  }
                  return null;
                },
                controller: statusCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 50.h),
              GradientElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                        context, statusCtrl.text); // Return the custom status
                  }
                },
                text: '+ Add Check-In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
