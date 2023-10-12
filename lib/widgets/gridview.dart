import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/pages.dart';
import '../providers/scan_list_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class CardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return GridView.builder(
      itemCount: scans.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
      ),
// Cantidad de Cards a mostrar
      itemBuilder: (_, i) {
        return GridTile(
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2.0,
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(scans[i].razonSocial,
                                  style: TextStyle(
                                      fontSize: 14, 
                                      fontFamily: "Roboto")
                                      ))),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "${scans[i].fecha}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontFamily: "Roboto"),
                                  )))
                        ],
                      ), // Reemplaza con el icono que desees
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                scans[i].monto,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 18,
                                    fontFamily: "Roboto"),
                              ))),
                      /*
                    TextButton(
                      onPressed: () => throw Exception(),
                      child: const Text("Throw Test Exception"),
                  ),
                  */
                    ],
                  ),
                  onTap: () =>
                      Navigator.pushNamed(context, BoletasPage.routerName, arguments: scans[i]),
                ),
          ),
        );
      },
    );
  }
}
