import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PanicAlertDialog extends StatelessWidget {
  final Function onYesPressed;
  final Function onNoPressed;

  const PanicAlertDialog({
    super.key,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
          child: Text('Are you OK?',
              style: GoogleFonts.poppins(fontSize: 20))),
      actions: [
        GestureDetector(
          onTap: () => onYesPressed(),
          child: Container(
            height: 32.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff305FA1).withOpacity(0.1),
              border: Border.all(color: Color(0xff305FA1)),
            ),
            child: Center(
              child: Text(
                'YES',
                style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onNoPressed(),
          child: Container(
            height: 32.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffA13430).withOpacity(0.1),
              border: Border.all(color: Color(0xffA13430)),
            ),
            child: Center(
              child: Text(
                'NO',
                style: TextStyle(color: Color(0xffA13430), fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
