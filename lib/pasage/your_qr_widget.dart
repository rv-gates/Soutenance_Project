import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YourQRWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const YourQRWidget(this.data);
  @override
  Widget build(BuildContext context) {
    String qrData = data.toString(); // Transformer les données en String pour le QR code
    return Center(
      child: QrImageView(
        data: qrData,
        size: 200,
      ),
    );
  }
}