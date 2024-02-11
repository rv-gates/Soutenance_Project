import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soutenance_app/GridViewOptions/authentification-permis/permit_information.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  QRViewController? _qrViewController;
  late final StreamController<String> _qrStreamCtrl;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var streamHasEmitted = false;

  @override
  void initState() {
    super.initState();

    _qrStreamCtrl = StreamController();

    _qrStreamCtrl.stream.listen((data) {
      if (data.isNotEmpty) {
        streamHasEmitted = true;
        final driverLicenseId = json.decode(data)['id'];

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PermitInformation(driverLicenseId: driverLicenseId)));
        // TODO: creer methode _openPermitInformationPage
      }
    });
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    _qrStreamCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'veuillez mettre le QR code dans la zone de scan qui est délimité par des barres rouge',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await _qrViewController?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: _qrViewController?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;

    _qrViewController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && !streamHasEmitted) _qrStreamCtrl.sink.add(scanData.code!);
    });
  }

/*Future<bool> compareWithFirebase(String qrData) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('qrCodes')
        .where('data', isEqualTo: qrData)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }*/
}
