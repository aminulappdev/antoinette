import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfController extends GetxController {
  Future<void> generateAndSavePDF(
      String date, String transactionId, String price, String name) async {
    try {
      final pdf = pw.Document();

      // Define custom colors
      final primaryColor = PdfColors.deepPurple; // Custom purple color
      final borderColor = PdfColors.grey300; // Subtle border color
      final textColor = PdfColors.black; // Main text color
      final secondaryColor = PdfColors.green600; // For "Secured by Paystack"
      final ByteData imageData = await DefaultAssetBundle.of(Get.context!).load(AssetsPath.appLogo);
      final Uint8List imageBytes = imageData.buffer.asUint8List();
      final robotoBold = await PdfGoogleFonts.robotoBold();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 100),
              pw.Center(
                child: pw.Image(
                  pw.MemoryImage(imageBytes),
                  width: 250,
                  height: 100,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'Payment Receipt',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(20),
                  border:
                      pw.Border.all(color: PdfColors.deepPurple300, width: 2),
                  color: PdfColors.white, // Background color for container
                ),
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Column(
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(20),
                          color: PdfColors.deepPurple300,
                        ),
                        height: 50,
                        child: pw.Center(
                          child: pw.Text(
                            'Payment Summary',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Date',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                          pw.Text(
                            date,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Transaction ID',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                          pw.Text(
                            transactionId,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Name',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        height: 1,
                        color: borderColor, // Gray divider
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Total Payment',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            '₦$price',
                            style: pw.TextStyle(
                              fontSize: 14,
                              font: robotoBold, // Use Roboto Bold font
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'Secured by Paystack',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 50),
              pw.Center(
                child: pw.Text(
                  'Thank you for prioritizing your healing.',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'www.dearhenrietta.com',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      // Get the directory for saving the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/payment_receipt.pdf');

      // Save the PDF file
      await file.writeAsBytes(await pdf.save());

      // Show success message
      Get.snackbar(
        'Success',
        'PDF receipt has been generated and saved',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('My file is $file');
      // Optional: Open the PDF file
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
