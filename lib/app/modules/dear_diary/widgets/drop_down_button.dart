import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButton extends StatefulWidget {
  final List<String> option;
  const DropDownButton({
    super.key, 
    required this.option,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool _isDropdownOpen = false;
  String _selectedValue = '';

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.option.isNotEmpty ? widget.option[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 24.h,
          width: 93.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color(0xffD9A48E)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedValue,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                
                GestureDetector(
                  onTap: _toggleDropdown,
                  child: CircleAvatar(
                    radius: 8.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        _isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Color(0xffD9A48E),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen) ...[
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding:  EdgeInsets.all(4.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var val in widget.option)
                    GestureDetector(
                      onTap: () {
                        
                        setState(() {
                          _selectedValue = val;
                          _isDropdownOpen = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Text(
                          val,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ],
    );
  }
}