import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/payment/controllers/confirmed_payment_controller.dart';
import 'package:antoinette/app/modules/payment/views/payment_success_screen.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewScreen extends StatefulWidget {
  final Map<String, dynamic> paymentData;
  static const String routeName = '/payment-webview-screen';

  const PaymentWebviewScreen({super.key, required this.paymentData});

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late WebViewController _controller;
  final ConfirmedPaymentController confirmedPaymentController =
      ConfirmedPaymentController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Payment"),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: widget.paymentData['link'],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          onPageStarted: (String url) {
            debugPrint('Page start loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            if (url.contains("confirm-payment")) {
              print('Confirmed payment hoye geche............................');
              await confirmPayment('${widget.paymentData['reference']}');
              Navigator.pushNamed(context, PaymentSuccessScreen.routeName);
              // Call your payment result handler or anything you want here
              debugPrint('::::::::::::: if condition ::::::::::::::::');
            }
          },
        ),
      ),
    );
  }

  Future<void> confirmPayment(String reference) async {
    final bool isSuccess =
        await confirmedPaymentController.confirmPaymentfunction(reference);
    if (isSuccess) {
      if (mounted) {
       

      } else {
        if (mounted) {
          showSnackBarMessage(
              context, confirmedPaymentController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(context,
            confirmedPaymentController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
