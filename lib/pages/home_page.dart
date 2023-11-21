import 'package:boletero/pages/ticket_register_page.dart';
import 'package:boletero/providers/scan_list_provider.dart';
import 'package:boletero/providers/ui_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/ticket_provider.dart';
import '../widgets/central_button.dart';
import '../widgets/custom_navigatorbar.dart';
//import '../widgets/scan_mobile.dart';

import '../widgets/widgets.dart';
import 'historial_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
    static const String routerName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('BOLETERO'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAll();
              })
        ],
      ),
      body: _HomePageBody(),
      drawer: SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(),
      // floatingActionButton: const ScanButton(),
      //floatingActionButton: const ScanMobileButton(),
      floatingActionButton: const CentralButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanlistProvider
   // final scanListProvider =
   // Provider.of<ScanListProvider>(context, listen: false);
 
    // TODO: Temporal leer BD
    //final tempScan = new ScanModel(valor: 'PRUEBA');
    //DBProvider.db.newScan(tempScan);
    //DBProvider.db.getScanById(2).then((scan) => print(scan?.valor));

    switch (currentIndex) {
      case 0:
     //   scanListProvider.loadScanByType('boleta');
        return const TicketRegisterPage();
      case 1:
     //   scanListProvider.loadScanByType('http');
        return const HistorialPage();
      default:
        return const TicketRegisterPage();
    }
  }
}
