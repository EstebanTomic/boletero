import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class TicketRegisterPage extends StatelessWidget {
  const TicketRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.black87,
            child: ListView.builder(
                itemCount: scans.length,
                itemBuilder: (_, i) => Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Color.fromARGB(255, 218, 45, 33),
                      ),
                      onDismissed: (DismissDirection direction) {
                        Provider.of<ScanListProvider>(context, listen: false)
                            .deleteScanById(scans[i].id?.toInt() ?? 0);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        elevation: 5,
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(12),
                          leading: Icon(Icons.text_snippet_outlined,
                              color: Theme.of(context).primaryColor),
                          title:
                              Text(scans[i].fecha + '\n' + scans[i].rut + '\n',
                              style: TextStyle(fontSize: 16)),
                          subtitle:
                              Text('Folio: ' + scans[i].folio + '\n',
                              style: TextStyle(fontSize: 14)),
                          trailing: Text(
                            '\$ ' + scans[i].monto,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          onTap: () => print(scans[i].id.toString()),
                        ),
                      ),
                    ))));
  }
}
