import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/login/admin/admin%20Screen/delete_user/delete_user.dart';
import 'package:soutenance_app/login/admin/drawer/drawer_screen.dart';
import 'package:soutenance_app/widgets/custom_text_field.dart';
import '../../../../core/modele/user.dart';


class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('user');

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  double xOffset = 0;
  double yOffset = 0;
  late final FormGroup _formSearch;
  bool isDrawerOpen = false;

  int connectedAgents = 2;
  void addSanction() async {
    // signup user using our authmethodds
    /*String res = await FirestoreService().addSanction(
      sanction: sanctioncontroller.text,
    );*/
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
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget buildUser(User user) => ListTile(
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width/3.3,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteUser();
                    },
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteUser();
                    },
                  );
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
        title: Text(user.lastName),
        subtitle: Text(user.matricule),
      );

  @override
  void initState() {
    super.initState();
    _formSearch = fb.group({
      "search": FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const DrawerScreen(),
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(isDrawerOpen ? 0.85 : 1.00)
                ..rotateZ(isDrawerOpen ? -50 : 0),
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
              ),
              /*appBar: AppBar(
                title: const Text('ADMINISTRATEUR',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AdminSearch();
                          },
                        );
                      },
                      icon: const Icon(Icons.search)),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: '1',
                        child: Text('profile'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        value: '2',
                        child: const Text('Deconnexion'),
                      ),
                    ],
                    onSelected: (value) {
                      // Action à effectuer lorsque l'option est sélectionnée
                      // Vous pouvez mettre en place la logique pour afficher la fenêtre souhaitée ici
                    },
                  ),
                ],
              ),*/
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: Row(
                      children: [
                        isDrawerOpen
                            ? GestureDetector(
                                child: const Icon(Icons.arrow_back_ios),
                                onTap: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    isDrawerOpen = false;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Icon(Icons.menu),
                                onTap: () {
                                  setState(() {
                                    xOffset = 290;
                                    yOffset = 80;
                                    isDrawerOpen = true;
                                  });
                                },
                              ),
                        SizedBox(
                          width: 50.0,
                          height: 10.0,
                        ),
                        const Text('ADMINISTRATEUR',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        /*PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: '1',
                              child: Text('profile'),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              value: '2',
                              child: const Text('Deconnexion'),
                            ),
                          ],
                          onSelected: (value) {
                            // Action à effectuer lorsque l'option est sélectionnée
                            // Vous pouvez mettre en place la logique pour afficher la fenêtre souhaitée ici
                          },
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(
                      'images/dgtt2.png',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            'Une erreur est survenue : ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Chargement des données...');
                      }

                      int? numberOfUsers = snapshot.data?.docs.length;

                      return Text(
                        'Utilisateurs  enrégistrés: $numberOfUsers',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  const Row(
                    children: [
                      SizedBox(
                        width: 5.0,
                      ),
                      /*Expanded(
                        child: ElevatedButton(
                          child: const Text(
                            'Ajouter une sanction',
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                          },
                        ),
                      ),*/
                    ],
                  ),
                  const Text(
                    'Liste des Agents:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                 ReactiveForm(
                   formGroup: _formSearch,
                   child: const Row(
                      children: [
                        SizedBox(width: 40.0,),
                        SingleChildScrollView(
                          child: SizedBox(
                              height: 50.0,
                              width: 210.0,
                              child: CustomTextField(
                                formControlName: "search",
                                obscureText: false,
                                label: 'rechercher un utilisateur',
                                inputType: TextInputType.text,
                              )),
                        ),
                        //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      ],
                    ),
                 ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<List<User>>(
                      stream: readUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: /*users.map(buildUser).toList(),*/
                                users.map(buildUser).toList(),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
