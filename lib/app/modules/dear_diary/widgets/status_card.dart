
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String emojiPath;
  final String percent;
  const StatusCard({
    super.key,
    required this.emojiPath,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(emojiPath),
            ),
            widthBox4,
            Text(percent)
          ],
        ),
      ),
    );
  }
}
