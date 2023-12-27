import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/modele/user.dart';
import '../../../widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword(email, oldPassword, newPassword) async{

    try{
  var cred = EmailAuthProvider.credential(email: email, password: oldPassword);

  await currentUser!.reauthenticateWithCredential(cred).then((value) {
  currentUser!.updatePassword(newPassword);
  });
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage("images/policeMan.jpg"),
            ),
          ),
          SizedBox(height: 18),
          Center(child: SizedBox(width:150.0,child: Divider(height: 3.0, color: Colors.black,))),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  "Nom :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("SAMBO", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  "Prenom :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("DANIELLA", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  "Matricule :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("112", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  "Téléphone :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("06 960 45 32", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
