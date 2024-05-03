import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/pasage/my_new_app.dart';
import 'package:soutenance_app/screen/options/addSomething/data_management.dart';
import 'package:soutenance_app/screen/options/sanction/sanction_list.dart';
import 'package:soutenance_app/screen/options/sanction/sanction_page.dart';
import 'package:soutenance_app/widgets/add_sanction/modify_sanction_page.dart';
import '../../../core/modele/sanction/sanction.dart';
import '../../../widgets/add_agent_dialog/add_agent_dialog.dart';
import '../../../widgets/add_sanction/add_sanction.dart';
import '../../../widgets/new_row.dart';

class DrawerColumn extends StatefulWidget {
  const DrawerColumn({super.key});

  @override
  State<DrawerColumn> createState() => _DrawerColumnState();
}

class _DrawerColumnState extends State<DrawerColumn> {
  final List<SanctionCreated> sanctions = [
    SanctionCreated(id: '1', sanction: 'Sanction 1'),
    SanctionCreated(id: '2', sanction: 'Sanction 2'),
    SanctionCreated(id: '3', sanction: 'Sanction 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          child: const Opacity(
            opacity: 0.7,
            child: SizedBox(
              child: Card(
                color: Colors.blueGrey,
                child: NewRow(
                  text: 'Ajouter un utilisateur',
                  icon: Icons.person_add,
                ),
              ),
            ),
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
          child: Opacity(
            opacity: 0.7,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: const Card(
                color: Colors.blueGrey,
                child: NewRow(
                  text: 'Ajouter une sanction',
                  icon: Icons.add,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SanctionListPage()));
          },
          child: Opacity(
            opacity: 0.7,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: const Card(
                color: Colors.blueGrey,
                child: NewRow(
                  text: 'Gérer les sanctions',
                  icon: Icons.add_circle,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SanctionPage()));
          },
          child: const Opacity(
            opacity: 0.7,
            child: SizedBox(
              width: 130.0,
              child: Card(
                color: Colors.blueGrey,
                child: Center(
                  child: NewRow(
                    text: 'Controles',
                    icon: Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
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
          child: const Opacity(
            opacity: 0.6,
            child: SizedBox(
              width: 130.0,
              child: Card(
                color: Colors.blueGrey,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'DONNEES',
                      style: TextStyle(color: Colors.grey, fontSize: 11.0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
