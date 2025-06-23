
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerScreen extends StatefulWidget {
  const TimePickerScreen({super.key});

  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  Duration _selectedDuration = const Duration(minutes: 15);

  void _showTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: Colors.white,
        child: CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.hm, // Can be hms if you need seconds
          initialTimerDuration: _selectedDuration,
          onTimerDurationChanged: (Duration newDuration) {
            setState(() {
              _selectedDuration = newDuration;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cupertino Time Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_selectedDuration.inHours} hours "
              "${_selectedDuration.inMinutes.remainder(60)} min",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showTimePicker(context),
              child: const Text("Pick Time"),
            ),
          ],
        ),
      ),
    );
  }
}