import 'package:boletero_qr_reader/pages/ticket_register_page.dart';
import 'package:boletero_qr_reader/providers/db_provider.dart';
import 'package:boletero_qr_reader/providers/scan_list_provider.dart';
import 'package:boletero_qr_reader/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_navigatorbar.dart';
import '../widgets/scan_button.dart';
//import '../widgets/scan_mobile.dart';

import 'historial_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Boletero'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                .deleteAll();
            }
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      //floatingActionButton: const ScanMobileButton(),
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
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);


    // TODO: Temporal leer BD
    final tempScan = new ScanModel(valor: 'PRUEBA');
    //DBProvider.db.newScan(tempScan);
    //DBProvider.db.getScanById(2).then((scan) => print(scan?.valor));
    
    switch (currentIndex) {
      case 0:
        scanListProvider.loadScanByType('geo');
        return const TicketRegisterPage();
      case 1:
      scanListProvider.loadScanByType('http');
        return const HistorialPage();
      default:
        return const TicketRegisterPage();
    }
  }
}
