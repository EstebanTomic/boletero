import 'package:flutter/material.dart';
import 'package:boletero/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan( String valor, String monto, String rut, String folio, String fecha, String empresa) async {
    final nuevoScan = ScanModel(valor: valor, monto: monto, rut: rut, folio: folio, fecha: fecha, empresa: empresa);
    final id = await DBProvider.db.newScan(nuevoScan);
    //Asignar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if( this.selectedType == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }


  loadScanByType(String tipo) async {
    final scans = await DBProvider.db.getScansByType(tipo);
    this.scans = [...scans];
    this.selectedType = tipo;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }


}