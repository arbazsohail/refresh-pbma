import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'DMSans',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
       
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 100,
                      color: Colors.white54,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Position QR code within the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'The scanner will automatically detect the QR code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
