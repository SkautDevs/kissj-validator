
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../utils/api.dart'; // Import the file for API verification logic
import 'user_data_screen.dart'; // Import the UserDataScreen
import '../models/user.dart';

class QRScannerScreen extends StatefulWidget {
  final Key? customKey; // Use a different name for your custom key field
  const QRScannerScreen({this.customKey}) : super(key: customKey);

  @override
  QRScannerScreenState createState() => QRScannerScreenState();
}

class QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String qrCodeData = ''; // Store scanned data here

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Scan the entry QR code')
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const SizedBox()
        ],
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Extract and display the scanned QR code data
      setState(() {
        qrCodeData = scanData.code!;
        if (qrCodeData.isEmpty == false) {
          controller.pauseCamera();
        }
      });

      // Verify the scanned QR code data
      final userData = await getUser(qrCodeData);
      // If the code is valid, navigate to the UserDataScreen
      if (userData.valid) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Valid'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              margin: const EdgeInsets.all(16),
            ),);
        }
        _navigateToUserDataScreen(userData);
      }
      else {
        if (mounted){
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text('Invalid: ${userData.reason}'),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)),
               duration: const Duration(seconds: 2),
               behavior: SnackBarBehavior.floating,
               backgroundColor: Colors.red,
               margin: const EdgeInsets.all(16),
             ),);
          //sleep(const Duration(seconds: 4));
        }
        controller.resumeCamera();
      }
    });
  }

  void _navigateToUserDataScreen(User userData) {
    // Use the context from _onQRViewCreated to navigate
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDataScreen(userData),
        ),
      ).then((value) => controller.resumeCamera());
    }
  }
}
