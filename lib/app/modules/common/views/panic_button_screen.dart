import 'dart:async';
import 'package:antoinette/app/modules/common/controllers/pannic_controller.dart';
import 'package:antoinette/app/modules/common/views/panic_alert_dialoge.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as ph;

class PanicButtonScreen extends StatefulWidget {
  static const String routeName = '/panic-button-screen';

  const PanicButtonScreen({super.key});

  @override
  State<PanicButtonScreen> createState() => _PanicButtonScreenState();
}

class _PanicButtonScreenState extends State<PanicButtonScreen>
    with SingleTickerProviderStateMixin {
  final PannicController pannicController = PannicController();
  double? latitude;
  double? longitude;
  bool isPressed = false;
  late Timer _timer;
  bool isHolding = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // Define scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      isHolding = false;
    });
    _animationController.stop();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBox24,
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundColor: const Color(0xffA57EA5).withOpacity(0.1),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Are you in danger?',
                style: GoogleFonts.poppins(
                    fontSize: 32.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Hold for 3 seconds to send an alert.',
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 150.h),
              GestureDetector(
                onLongPress: _onLongPress,
                onLongPressEnd: _onLongPressEnd,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isHolding ? _scaleAnimation.value : 1.0,
                      child: Container(
                        height: 217.h,
                        width: 217.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPressed ? Colors.green : const Color(0xffFA7875),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, isHolding ? 4 : 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            isPressed ? 'Alert Sent!' : 'Panic Button',
                            style: GoogleFonts.poppins(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLongPress() {
    setState(() {
      isHolding = true;
    });
    _animationController.forward();

    _timer = Timer(const Duration(seconds: 2), () {
      if (isHolding) {
        _animationController.stop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => PanicAlertDialog(
            onYesPressed: () {
              Navigator.pop(context);
              setState(() {
                isPressed = false;
                isHolding = false;
              });
              _animationController.reset();
            },
            onNoPressed: () async {
              print('Pannic start');
              await requestLocationPermission();
              await getCurrentLocation();
              print('lat : $latitude lng: $longitude');
              await onTapToNextButton();

              Navigator.pop(context);
            },
          ),
        );
      }
    });
  }

  Future<void> onTapToNextButton() async {
    if (latitude != null && longitude != null) {
      final bool isSuccess =
          await pannicController.panicFunction(latitude!, longitude!);

      if (isSuccess) {
        if (mounted) {
          setState(() {
            isPressed = true;
            isHolding = false;
          });
          showSnackBarMessage(context, 'Sms sent to all trusted contact');
        }
      } else {
        if (mounted) {
          setState(() {
            isPressed = false;
            isHolding = false;
          });
          showSnackBarMessage(context, pannicController.errorMessage!, true);
        }
      }
      _animationController.reset();
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Location not available', true);
        setState(() {
          isHolding = false;
        });
        _animationController.reset();
      }
    }
  }

  Future<void> requestLocationPermission() async {
    final ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      // Permission granted
    } else if (status.isDenied) {
      print('Location_permission_denied');
    }
  }

  Future<void> getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      final loc.LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        print('Location is $latitude and $longitude');
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}