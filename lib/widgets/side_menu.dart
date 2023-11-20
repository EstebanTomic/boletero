import 'package:boletero/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_auth_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<FirebaseAuthProvider>(context);
    final User? user = userProvider.getUser();
    debugPrint('user: ${user}');
    return Drawer(
      child: ListView(
        children: [
          _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black87),
            title:
                Text('${user?.email}', style: TextStyle(color: Colors.black87)),
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.black87),
            title: const Text('Editar Perfil',
                style: TextStyle(color: Colors.black87)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.close, color: Colors.red),
            title: const Text('Cerrar Sesión',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () {
              userProvider.logout();
              Get.to(() => const LoginPage());
              //Navigator.pushNamed(context, LoginPage.routerName);
            },
          )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icon/sideMenuIcon.png'),
              fit: BoxFit.cover)),
    );
  }
}
