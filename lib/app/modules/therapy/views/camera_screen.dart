import 'dart:async';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera-screen';
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isRearCamera = true;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  final int _pointers = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera(isRearCamera ? 0 : 1);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    final cameras = widget.cameras;

    if (cameras.isEmpty) {
      debugPrint("No cameras available");
      return;
    }

    controller = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
    _minZoom = await controller!.getMinZoomLevel();
    _maxZoom = await controller!.getMaxZoomLevel();

    if (!mounted) return;
    setState(() {});
  }

  void toggleCamera() {
    setState(() {
      isRearCamera = !isRearCamera;
    });
    _initializeCamera(isRearCamera ? 0 : 1);
  }

  void takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return;

    try {
      final image = await controller!.takePicture();
      debugPrint("Image saved at: ${image.path}");
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (controller == null || _pointers != 2) return;
    _currentScale = (_baseScale * details.scale).clamp(_minZoom, _maxZoom);
    await controller!.setZoomLevel(_currentScale);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              child: CameraPreview(controller!),
            ),

            /// 📌 Back Button
            Positioned(
              top: height / 20,
              left: width / 20,
              child:  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color(0xffA57EA5).withOpacity(0.4),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
            ),

             /// 📌 Back Button
            Positioned(
              top: 50.h,
              right: 20.w,
              child:  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 143.h,
                      width: 116.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: AssetImage(AssetsPath.doctor),fit: BoxFit.fill)
                      ),
                    )
                  ),
            ),

            /// 📌 Camera Switch & Flash Buttons
            Positioned(
              bottom: 60.h,
              right: 20.w,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color(0xffA57EA5).withOpacity(0.4),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                        size: 44.h,
                      ),
                    ),
                  ),
                  heightBox12,
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color(0xffA57EA5).withOpacity(0.4),
                      child: Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                        size: 30.h,
                      ),
                    ),
                  ),
                   heightBox12,
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                     backgroundColor: Color(0xffA57EA5).withOpacity(0.4),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 30.h,
                      ),
                    ),
                  ),
                   heightBox12,
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color(0xffA57EA5).withOpacity(0.4),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 📌 Floating Capture Button
            Positioned(
              bottom: 50.h,
              left: 150.w,
              child: GestureDetector(
                onTap: takePicture,
                child: Container(
                  height: 90.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 131, 112, 112),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child:
                       Icon(Icons.call_end, size: 40.h, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
