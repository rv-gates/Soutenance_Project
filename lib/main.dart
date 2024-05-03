import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/user.dart';
import 'package:soutenance_app/login/admin/admin%20Screen/admin_screen.dart';
import 'package:soutenance_app/screen/acceuil_page.dart';
import 'package:soutenance_app/screen/home/home.dart';
import 'package:soutenance_app/shared/enums/role_user.dart';
import 'package:soutenance_app/shared/services/user_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final currentUsers = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: currentUsers == null
          ? const AcceuilPage()
          : FutureBuilder<UserCreated>(
              future: ref.read(userService).getUser(currentUsers?.uid ?? ""),
              builder: (context, snapshot) {
                if(currentUsers != null) {
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    if (user.role == RoleUser.administrateur) {
                      return const AdminScreen();
                    } else {
                      return Home();
                    }
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {}
                return const SizedBox();
              },
            ),
      debugShowCheckedModeBanner: false,
    );
  }
}
