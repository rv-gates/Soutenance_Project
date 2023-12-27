
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

/*
class QrCodeGenerator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  final user = FirebaseAuth.instance.currentUser!;
String qrData =
      "test";
  // already generated qr code when the page opens

  String _buildQrCode() {
    var content = "Daniella";
    var type = "Sambo";
    var email = "dani02@gmail.com";
    Map<String,dynamic> myData = {
      'nom': type,
      'prenom': content,
      'email': email,
    };

    String encodedJson = jsonEncode(myData);
    print(encodedJson);
    return encodedJson;
  }

  @override
  Widget build(BuildContext context) {
    final uid = user.uid;
    var endcodedJson = _buildQrCode();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(31, 146, 144, 144),
        appBar: AppBar(
          title: const Text('QR Code Generator'),
          actions: <Widget>[],
          backgroundColor: const Color.fromARGB(31, 146, 144, 144),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImageView(
                  //plce where the QR Image will be shown
                  data: endcodedJson,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  "New QR Link Generator",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                TextField(
                  controller: qrdataFeed,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Input your data",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: ElevatedButton(
                    onPressed: _buildQrCode,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12), //padding for the button
                        textStyle: const TextStyle(
                          fontSize: 18,
                        )
                    ),
                    child: const Text('Generate QR',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Générateur de code QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc()
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                String name = snapshot.data?['name'] ?? "";
                String matricule = snapshot.data?['matricule'] ?? "";
                String firstName = snapshot.data?['firstName'] ?? "";
                List<String> categories =
                List<String>.from(snapshot.data?['categories'] ?? "");

                String qrData =
                    "Nom: $name\nPrénom: $firstName\nCatégories: ${categories.join(', ')}";

                return
                   QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  }*/