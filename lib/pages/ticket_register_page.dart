import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class TicketRegisterPage extends StatelessWidget {
  const TicketRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

  final scanListProvider = Provider.of<ScanListProvider>(context);
  final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[i].id?.toInt() ?? 0);
        },
        child: ListTile(
          leading: Icon(Icons.text_snippet_outlined, color: Theme.of(context).primaryColor),
          title: Text('FECHA: '+ scans[i].fecha + '   RUT: ' +  scans[i].rut + '   FOLIO: '+ scans[i].folio),
          subtitle: Text('Monto: '+ scans[i].monto),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print(scans[i].id.toString()),
        ),
      )
    );
  }
}
