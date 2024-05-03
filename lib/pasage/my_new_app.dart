import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/pasage/your_qr_widget.dart';
class MyNewApp extends StatelessWidget {
  const MyNewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('DRIVER_LICENSES').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune donnée trouvée'));
          } else {
            /*List<Map<String, dynamic>> dataList = [];

            for (var doc in snapshot.data!.docs) {
              Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
              dataList.add(docData);
              print (dataList);
            }*/
           // var sna = snapshot.data!.docs.first.data();
            final doc  = snapshot.data!.docs[2].data();
            final data = json.encode(doc);
            //print(data);
            return YourQRWidget(data); // Passer les données au widget pour générer le QR code
          }
        },
      ),
    );
  }
}
