import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

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
      ),
// Cantidad de Cards a mostrar
      itemBuilder: (_, i) {
        return Card(
            elevation: 4.0,
            child: InkWell(
                child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(scans[i].empresa,
                          style: TextStyle(
                              fontSize:
                                  20))), // Reemplaza con el icono que desees
                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "${scans[i].fecha}",
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF000000),
                            fontFamily: "Roboto"),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            scans[i].monto,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
                TextButton(
                  onPressed: () => throw Exception(),
                  child: const Text("Throw Test Exception"),
              ),

                ],
              ),
              onTap: () =>
                  Navigator.pushNamed(context, 'boleta', arguments: scans[i]),
            )));
      },
    );
  }
}
