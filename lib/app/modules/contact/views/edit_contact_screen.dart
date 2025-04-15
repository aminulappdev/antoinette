import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/edit_contact_controller.dart';
import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditContactScreen extends StatefulWidget {
  final Map<String,dynamic> contactData;
  static const String routeName = '/edit-contact-screen';
  const EditContactScreen({super.key, required this.contactData});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController numberCtrl = TextEditingController();
  EditContactController editContactController = EditContactController();
  bool togggleActive = false;
  bool isToggled = false;

  @override
  void initState() {
    numberCtrl.text = widget.contactData['number'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(name: 'Edit Trusted Contacts'),
                  heightBox12,
                  Text('Number',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: numberCtrl,                 
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter number';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox30,
                  GradientElevatedButton(onPressed:(){
                    onTapToNextButton();
                  }, text: 'Save')
                ],
              ),
            )),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await editContactController.editContact(widget.contactData['contactId'], numberCtrl.text);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Contact updated');
          Get.find<AllContactController>().getContactList();
          Navigator.pushNamed(context, ContactScreen.routeName);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, editContactController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          // print('Error show ----------------------------------');
          showSnackBarMessage(
              context, editContactController.errorMessage!, true);
        }
      }
    }
  }
}
