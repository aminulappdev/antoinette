import 'package:antoinette/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  final bool shouldBackButton;
  

  const CustomSearchBar({
    super.key,
    required this.shouldBackButton,
   
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        shouldBackButton
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 24.r,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              )
            : Container(),
        Container(
          height: 48.h,  
          width:shouldBackButton ? (MediaQuery.of(context).size.width - 80).w : (MediaQuery.of(context).size.width - 30).w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                  Icons.search_rounded,
                  size: 30.h,
                  color: AppColors.iconButtonThemeColor,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
             
            ],
          ),
        ),
       
      ],
    );
  }
}
