import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YourQRWidget extends StatelessWidget {
  final String data;

  const YourQRWidget(this.data);

  @override
  Widget build(BuildContext context) => Center(
        child: QrImageView(
          data: data,
          size: 200,
        ),
      );
}
