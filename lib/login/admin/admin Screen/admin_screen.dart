import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/login/admin/admin%20Screen/delete_user/delete_user.dart';
import 'package:soutenance_app/login/admin/drawer/drawer_screen.dart';
import '../../../../core/modele/user.dart';
import '../../../shared/enums/role_user.dart';
import '../../../widgets/utils.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  late final TextEditingController _filter;
  String _searchText = "";
  List<String> _data = []; // Les données récupérées depuis Firebase
  List<String> _filteredData = [];

  final _searchController = TextEditingController();
  List<UserCreated> _users = [];
  List<UserCreated> _filteredUsers = [];

  List<UserCreated> _userList = [];

  List<User> get userList => _userList;

  double xOffset = 0;
  double yOffset = 0;
  late final FormGroup _formSearch;
  bool isDrawerOpen = false;

  int connectedAgents = 2;

  void deleteUser(User userToDelete) {
    _users.remove(userToDelete);
    // Update UI or data source accordingly
  }

  showUserDetailsDialog(BuildContext context, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "FICHE AGENT",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                child: Row(
                  children: [
                    const Text(
                      "Nom :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        userData['firstName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                child: Row(
                  children: [
                    const Text(
                      "Prénom :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        userData['lastName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                child: Row(
                  children: [
                    const Text(
                      "Téléphone :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        userData['phoneNumber'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                child: Row(
                  children: [
                    const Text(
                      "Identifiant :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: SingleChildScrollView(
                        child: Text(
                          userData['email'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                child: Row(
                  children: [
                    const Text(
                      "Matricule :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        userData['matricule'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Stream<List<UserCreated>> readUsers() {
    try {
      return FirebaseFirestore.instance.collection('USER').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => UserCreated.fromJson(doc.data()))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  Widget buildUser(User user) => ListTile(
        title: Text(user.lastName),
        subtitle: Text(user.matricule),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width / 3.3,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const DeleteUser();
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
                      return const DeleteUser();
                    },
                  );
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
      );

  void _filterData(String searchText) {
    _filteredData.clear();
    if (searchText.isEmpty) {
      setState(() {
        _filteredData.addAll(_data);
      });
    } else {
      for (String data in _data) {
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _filteredData.add(data);
        }
      }
    }
  }

  Stream<List<UserCreated>> _getUsers() {
    return FirebaseFirestore.instance
        .collection('USER') // Replace with your actual collection name
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserCreated.fromJson(doc.data())).toList();
    });
  }

  void _filterProducts(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _filteredUsers = _users;
      });
      return;
    }

    setState(() {
      _filteredUsers = _users.where((user) {
        return user.lastName.toLowerCase().contains(searchText.toLowerCase()) ||
            user.email.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    });
  }

  void _showDeleteUserDialog(UserCreated user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer l\'utilisateur'),
          content: Text(
              'Êtes-vous sûr de vouloir supprimer l\'utilisateur ${user.lastName} ${user.firstName} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('USER')
                    .doc(user.id)
                    .delete();

                setState(() {
                  _filteredUsers = _filteredUsers
                      .where((u) => u.id != user.email)
                      .toList();
                });

                Navigator.pop(context); // Close the dialog
                Utils.showSnackBar(context, 'Utilisateur supprimé');
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  void modifyUser(User userToModify) {
    showDialog(
      context: context,
      builder: (context) {
        final _firstNameController =
            TextEditingController(text: userToModify.firstName);
        final _lastNameController =
            TextEditingController(text: userToModify.lastName);
        final _emailController =
            TextEditingController(text: userToModify.email);
        final _matriculeController =
            TextEditingController(text: userToModify.matricule);
        var _role =
            userToModify.role; // Or use a dropdown to select the new role

        return AlertDialog(
          title: Text('Modifier l\'utilisateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _matriculeController,
                decoration: const InputDecoration(labelText: 'Matricule'),
              ),
              DropdownButton<RoleUser>(
                value: _role,
                items: RoleUser.values
                    .map((role) => DropdownMenuItem<RoleUser>(
                          value: role,
                          child: Text(role.name),
                        ))
                    .toList(),
                onChanged: (newRole) {
                  setState(() {
                    _role = newRole!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Create a new User object with updated data
                final modifiedUser = User(
                  email: _emailController.text,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  matricule: _matriculeController.text,
                  role: _role,
                  phoneNumber: userToModify
                      .phoneNumber, // Assuming phone number remains the same
                );

                // Update the original user list
                setState(() {
                  //_userList.replaceWhere((user) => user == userToModify, (user) => modifiedUser);
                });

                // Update data source (e.g., Firebase) if necessary
                // ...

                Navigator.pop(context); // Close the dialog
                Utils.showSnackBar(context, 'Utilisateur modifié');
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _filter = TextEditingController();
    _formSearch = fb.group({
      "search": FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
    });
    _getUsers().listen((users) {
      setState(() {
        _users = users;
        _filteredUsers = users;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
              ),
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
                                child: const Icon(Icons.menu),
                                onTap: () {
                                  setState(() {
                                    xOffset = 290;
                                    yOffset = 80;
                                    isDrawerOpen = true;
                                  });
                                },
                              ),
                        const SizedBox(
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(
                      'images/dgtt2.jpg',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('USER')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            'Une erreur est survenue : ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Chargement des données...');
                      }

                      int? numberOfUsers = snapshot.data?.docs.length;

                      return Text(
                        'Utilisateurs  enrégistrés: $numberOfUsers',
                        style: const TextStyle(
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
                  /*TextField(
                   controller: _filter,
                   onChanged: (value) {
                     setState(() {
                       _searchText = value;
                       _filterData(_searchText); // Appeler la méthode de filtrage avec le texte de recherche actuel
                     });
                   },
                 ),*/
                  /* ReactiveForm(
                    formGroup: _formSearch,
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                        ),
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
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration:
                          const InputDecoration(labelText: 'Rechercher'),
                      onChanged: (text) {
                        _filterProducts(text);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("USER")
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: _filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = _filteredUsers[index];
                                return Opacity(
                                  opacity: 0.8,
                                  child: Card(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Informations de l\'utilisateur',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.0),
                                              ),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Email: ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 17.0),
                                                        ),
                                                        Text(user.email),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Prénom: ',style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                        .w600,
                                                        fontSize: 17.0),),
                                                              Text(user.firstName),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Nom: ',style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 17.0),),
                                                        Text(user.lastName),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Matricule: ',style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 17.0),),
                                                        Text(user.matricule),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Rôle: ',style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 17.0),),
                                                        Text(user.role.name),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Téléphone: ',style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 17.0),),
                                                        Text(user.phoneNumber),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                  },
                                                  child: const Text('Fermer'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(user.firstName.toString()),
                                        subtitle: Text(user.email),
                                        trailing: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.3,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  modifyUser(user);
                                                },
                                                icon: const Icon(
                                                    Icons.edit_outlined),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _showDeleteUserDialog(user);
                                                },
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
