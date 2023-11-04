import 'dart:typed_data';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MobileScannerView(),
    );
  }
}

class MobileScannerView extends StatefulWidget {
  const MobileScannerView({super.key});

  @override
  State<MobileScannerView> createState() => _MobileScannerViewState();
}

class _MobileScannerViewState extends State<MobileScannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
      ),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          // facing: CameraFacing.back,
          // torchEnabled: false,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;

          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
          }

          if (image != null) {
            showDialog(
              context: context,
              builder: (context) => Image(
                image: MemoryImage(image),
              ),
            );

            Future.delayed(
              const Duration(seconds: 5),
              () {
                Navigator.pop(context);
              },
            );
          }
        },
      ),
    );
  }
}
