import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../pages/boletas_page.dart';
import '../providers/scan_list_provider.dart';
import '../providers/ticket_provider.dart';

class boletaCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    TicketRepository tr = Get.put(TicketRepository());
    tr.fetchTicketDocuments(uid);

    return tr.obx(
      (state) {
        return ListView.builder(
            itemCount: tr.ticketsDocuments.length,
            itemBuilder: (_, i) => Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Color.fromARGB(255, 218, 45, 33),
                  ),
                  onDismissed: (DismissDirection direction) {
                    tr.deleteTicketByFields(uid, tr.ticketsDocuments[i].rut,
                        tr.ticketsDocuments[i].folio);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(6),
                    elevation: 3,
                    child: ListTile(
                        //dense: true,
                        //contentPadding: const EdgeInsets.all(12),
                        leading: Image.asset(
                          'assets/ticketIcon.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(tr.ticketsDocuments[i].razonSocial + '\n',
                            style: TextStyle(fontSize: 16)),
                        subtitle: Text(
                            DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                    tr.ticketsDocuments[i].fecha)) +
                                '\n',
                            style: TextStyle(fontSize: 14)),
                        trailing: Text(
                          NumberFormat('#,###', 'es_CL')
                              .format(int.parse(tr.ticketsDocuments[i].monto)),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        //onTap: () => print(scans[i].id.toString()),
                        onTap: () => Navigator.pushNamed(
                            context, BoletasPage.routerName,
                            arguments: tr.ticketsDocuments[i])),
                  ),
                ));
      },
      onLoading: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Center(child: new CircularProgressIndicator())),
    );

/*
    return Obx(() {
      return ListView.builder(
          itemCount: tr.ticketsDocuments.length,
          itemBuilder: (_, i) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Color.fromARGB(255, 218, 45, 33),
                ),
                onDismissed: (DismissDirection direction) {
                  tr.deleteTicketById(tr.ticketsDocuments[i].id);
                },
                child: Card(
                  margin: const EdgeInsets.all(6),
                  elevation: 3,
                  child: ListTile(
                      //dense: true,
                      //contentPadding: const EdgeInsets.all(12),
                      leading: Icon(Icons.text_snippet_outlined,
                          color: Theme.of(context).primaryColor),
                      title: Text(
                          tr.ticketsDocuments[i].fecha +
                              '\n' +
                              tr.ticketsDocuments[i].rut +
                              '\n' +
                              tr.ticketsDocuments[i].empresa,
                          style: TextStyle(fontSize: 16)),
                      subtitle: Text(
                          'Folio: ' + tr.ticketsDocuments[i].folio + '\n',
                          style: TextStyle(fontSize: 14)),
                      trailing: Text(
                        tr.ticketsDocuments[i].monto,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      //onTap: () => print(scans[i].id.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, BoletasPage.routerName,
                          arguments: tr.ticketsDocuments[i])),
                ),
              ));
    });
    */
  }
}
