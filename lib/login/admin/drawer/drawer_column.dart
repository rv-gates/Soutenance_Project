import 'package:flutter/material.dart';
import 'package:soutenance_app/pasage/my_new_app.dart';
import 'package:soutenance_app/screen/options/addSomething/data_management.dart';
import '../../../widgets/add_agent/add_agent.dart';
import '../../../widgets/add_sanction/add_sanction.dart';
import '../../../widgets/new_row.dart';

class DrawerColumn extends StatefulWidget {
  const DrawerColumn({super.key});

  @override
  State<DrawerColumn> createState() => _DrawerColumnState();
}

class _DrawerColumnState extends State<DrawerColumn> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AddAgentDialog();
              },
            );
          },
          child: const NewRow(
            text: 'Ajouter un utilisateur',
            icon: Icons.person_add,
          ),
        ),
        /*const SizedBox(
          height: 20,
        ),
        const NewRow(
          text: 'modifier un utilisateur',
          icon: Icons.edit,
        ),*/
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AddSanction();
              },
            );
          },
          child: const NewRow(
            text: 'Ajouter une sanction',
            icon: Icons.add,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyNewApp()));
          },
          child: const NewRow(
            text: 'Modifier une sanction',
            icon: Icons.add_circle,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DataManagement()));
          },
          child: const Row(
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.grey,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'gestion des données',
                style: TextStyle(color: Colors.grey, fontSize: 11.0),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

      ],
    );
  }
}
