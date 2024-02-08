import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final String _result = "";

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
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
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
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
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async{

      Map<String, dynamic> jsonData = json.decode(scanData.code.toString());
      String scannedId = jsonData['id'];

      if (result != null) {
        try {
          FirebaseFirestore.instance
              .collection('DRIVER_LICENSES')
              .doc(scannedId)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists ) {
              var data = documentSnapshot.data();
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          const PermitInformation(/*qrData: barcode.code*/)));
            } else {

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text("Erreur lors du scan"),
                    );
                  }
              );
            }
          });
        } catch (e) {
          print('Erreur lors du décodage du JSON : $e');
        }
      }
      /*checkingValue() {
        try {
          if (_result != null || _result != "") {
            if (_result.contains("https") || _result.contains("http")) {
              return _launchURL(_result);
            } else {
              Text("erreur");
            }
          }
        } catch (_) {
          print("ce n'est pas une url");
        }

        /*if(qrDoc.exists){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PermitInformation()));
    } else{
      print("error");
      showDialog(
          context: context,
          builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text("Erreur lors du scan"),
        );
      }
      );
    }*/
      }*/
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
