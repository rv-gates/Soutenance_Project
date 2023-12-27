import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';

class AddSanctionDialog extends StatefulWidget {
  const AddSanctionDialog({super.key});

  @override
  _AddSanctionDialogState createState() => _AddSanctionDialogState();
}

class _AddSanctionDialogState extends State<AddSanctionDialog> {
  late TextEditingController sanctionController;
  late TextEditingController descriptionController;
  String selectValue = "0";

  /*List<Sanction> sanctions = [];

  void getData() {
    readUsers().listen((snapshot) {
      setState(() {
        sanctions = snapshot;

      });
    });
  }*/

  /*Stream<List<Sanction>> readSanction() => FirebaseFirestore.instance
      .collection('sanction')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Sanction.fromJson(doc.data())).toList());

  Widget buildUser(Sanction sanc) => ListTile(
    title: Text(sanc.sanction),
  );*/

  @override
  void initState() {
    descriptionController = TextEditingController();
    sanctionController = TextEditingController();
    super.initState();
  }

  /*void addSanctions() async {
    try {
      String res = await FirestoreService().addSanctions(
        sanctions: sanctionController.text, // description: descriptionController.text
      );
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      print("erreur mec");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(left: 22.0, top: 15.0),
        child: Text(
          'veuillez saisir le motif pour lequel le véhicule a été arrété',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         /* Expanded(
            child: Center(
              child: Container(
                width: 190.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                child: TextField(
                  controller: sanctionController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "ajouter une sanction",
                    border: inputBorder,
                    contentPadding: const EdgeInsets.all(10),

                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),*/
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('SANCTION').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<DropdownMenuItem> clientItems = [];
              if (snapshot.hasError) {
                print("error");
              }
              if (snapshot.hasData) {
                final sanctions = snapshot.data?.docs.reversed.toList();
                clientItems.add(const DropdownMenuItem(
                    value: "0", child: Text("select sanction")));
                for (var sanction in sanctions!) {
                  clientItems.add(DropdownMenuItem(
                      value: sanction.id, child: Text(sanction['sanction'])));
                }
              } else {
                const CircularProgressIndicator();
              }
              return Container(
                width: 190.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: DropdownButton(
                  value: selectValue,
                  isExpanded: true,
                  items: clientItems,
                  onChanged: (clientValue) {
                    setState(() {
                      selectValue = clientValue;
                    });
                    print(clientValue);
                  },
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Annuler'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Ajouter'),
          onPressed: () {
            //addSanctions();
          },
        ),
      ],
    );
  }
}
