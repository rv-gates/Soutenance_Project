import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/login/admin/drawer/drawer_column.dart';
import '../../../core/service/authentification_service.dart';
import '../../../screen/acceuil_page.dart';
import '../../../widgets/new_row.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {

  /*void addSanction() async {
    // signup user using our authmethodds
    String res = await FirestoreService().addSanction(
      sanction: sanctionController.text,
    );
    // if string returned is sucess, user has been created
    // navigate to the home screen
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueGrey,
          elevation: 7.0,
          content: const Row(
            children: [
              Text('Sanction Enregistrée'),
              Spacer(),
              Icon(
                Icons.check,
                color: Colors.green,
              )
            ],
          ),
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) => Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 05, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('images/secirity.jpg'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Authentics',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const DrawerColumn(),
            GestureDetector(
              onTap: (){
                ref.read(firebaseAuthProvider).signOut();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("DECONNEXION", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w600),),
                          SizedBox(height: 13.0,),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                );

                Future.delayed(const Duration(seconds: 7), () {
                  Navigator.of(context, rootNavigator: true).pop();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AcceuilPage(),
                    ),
                        (route) => false,
                  );
                });
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Déconnexion',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

}
