import 'package:flutter/material.dart';
import 'package:soutenance_app/widgets/text_widget.dart';

class CarteGriseScreen extends StatefulWidget {
  @override
  _CarteGriseScreenState createState() => _CarteGriseScreenState();
}

class _CarteGriseScreenState extends State<CarteGriseScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte grise du véhicule'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            TextWidget(
                text: "Numéro \nd\'immatriculation :",
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
            SizedBox(height: 12.0),
            TextWidget(
                text: "Date de \n délivrance :",
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
            SizedBox(height: 8.0),

            SizedBox(height: 12.0),
            TextWidget(
                text: 'Numéro de carte grise :',
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
            SizedBox(height: 8.0),
            SizedBox(height: 12.0),
            TextWidget(
                text: 'Nom et prénom :',
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
            SizedBox(height: 8.0),
            SizedBox(height: 12.0),
            TextWidget(
                text: 'Marque de la voiture :',
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
            SizedBox(height: 8.0),
            SizedBox(height: 12.0),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
