import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChattingFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller; // Added controller to get the text input

  const ChattingFieldWidget({
    super.key, 
    required this.hintText, 
    required this.controller, // Passing controller
  });

  @override
  State<ChattingFieldWidget> createState() => _ChattingFieldWidgetState();
}

class _ChattingFieldWidgetState extends State<ChattingFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: widget.controller, // Using the passed controller to access text input
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffixIcon: GestureDetector(
            onTap: () {
              if (widget.controller.text.isNotEmpty) {
                // When the user taps the send icon, the entered text is processed
                // You can call your sendMessage function here
                print("Sending Message: ${widget.controller.text}");
                widget.controller.clear(); // Clear the text field after sending the message
              }
            },
            child: Icon(Icons.send, color: Colors.blue), // Send icon
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 12.r),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
