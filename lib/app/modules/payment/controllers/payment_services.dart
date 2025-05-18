// // payment_service.dart
// import 'package:antoinette/app/modules/payment/controllers/payment_controller.dart';
// import 'package:antoinette/app/modules/payment/views/payment_webview_screen.dart';
// import 'package:antoinette/app/widgets/show_snackBar_message.dart';
// import 'package:flutter/material.dart';


// class PaymentService {
//   final PaymentController paymentController = PaymentController();

//   Future<void> payment(BuildContext context, String modelType, String userId,
//       String referenceId) async {
//     final bool isSuccess =
//         await paymentController.getPayment(modelType, userId, referenceId);

//     Map<String, dynamic> paymentData = {
//       'link' : paymentController.paymentData?.data,
//       'reference' : referenceId 
//     };

//     if (isSuccess) {
//       // Directly use context without mounted check
//       showSnackBarMessage(context, 'Payment request done');
//       Navigator.pushNamed(
//         context,
//         PaymentWebviewScreen.routeName,  
//         arguments: paymentData,
//       );
//     } else {
//       // Error handling
//       showSnackBarMessage(
//           context, paymentController.errorMessage ?? 'There was a problem', true);
//     }
//   }
// }
